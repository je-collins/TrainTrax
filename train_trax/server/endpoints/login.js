import server from '../server.js';
import md5 from 'md5';

const endpoint = (request, response) => {
	const { email, password } = request.body;
	
	// Check if one or more fields is not declared
	const undef = [];
	if (email === undefined) undef.push('email');
	if (password === undefined) undef.push('password');

	// If undeclared field, return error
	if (undef.length > 0) {
		return response.status(200).json({
			'error': 'Invalid payload',
			'message': 'Missing the following field(s): ' + undef.join(', ')
		});
	}

	// Retrieve information from user with given email and password
	server.query('SELECT * FROM users WHERE email = $1 and password = $2;', [email, md5(password)], (error, res) => {
		if (error) throw error;
		if (res.rows.length === 0) return response.status(200).json({
			'error': 'Incorrect credentials',
			'message': 'No user exists with the given email or password.'
		});

		const data = res.rows[0];

		// Generate random token and insert into database
		const token = md5(new Date().getTime().toString());
		server.query('INSERT INTO user_tokens(user_id, token, expire_time) values($1, $2, $3) ON CONFLICT (user_id) DO UPDATE SET token = $2, expire_time = $3;', [data.user_id, token, new Date().toISOString()], (error, res) => {
			if(error) throw error;
		});

		return response.status(200).json({
			'token': token,
			'error': '',
			'message': ''
		});
	});
};

export default endpoint;