import server from '../server.js';
import md5 from 'md5';

const endpoint = (request, response) => {
	const { email, password, name, phone_number } = request.body;
	
	// Check if one or more fields is not declared
	const undef = [];
	if (email === undefined) undef.push('email');
	if (password === undefined) undef.push('password');
	if (name === undefined) undef.push('name');
	if (phone_number === undefined) undef.push('phone_number');

	// If undeclared field, return error
	if (undef.length > 0) {
		return response.status(200).json({
			'error': 'Invalid payload',
			'message': 'Missing the following field(s): ' + undef.join(', ')
		});
	}

	// Check if a user with the given email already exists
	server.query('SELECT * FROM users WHERE email = $1;', [email], (error, res) => {
		if (error) throw error;
		if (res.rows.length > 0) return response.status(200).json({
			'error': 'Duplicate email',
			'message': 'A user with the given email already exists'
		});

		// If a user does not exist, add them
		server.query('INSERT INTO users(email, password, name, phone_number) values($1, $2, $3, $4);', [email, md5(password), name, phone_number], (error, res) => {
			if (error) throw error;
		})
	
		return response.status(200).json({
			'error': '',
			'message': ''
		});
	});
};

export default endpoint;