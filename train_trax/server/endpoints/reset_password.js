import server from '../server.js';
import md5 from 'md5';

const endpoint = (request, response) => {
    // Unpacking the request body object
    const { validation_token, password } = request.body;
    console.log('We are currently in the reset password API');
        
    // Check if one or more fields is not declared
	const undef = [];
	if (validation_token === undefined) undef.push('verification_code');
    if (password === undefined) undef.push('password');

    // If undeclared field, return error
	if (undef.length > 0) {
		return response.status(200).json({
			'error': 'Invalid payload',
			'message': 'Missing the following field(s): ' + undef.join(', ')
		});
	}

    // Check if a user with the given email exists
	server.query('SELECT * FROM users WHERE validation_token = $1 OR user_token = $1;', [validation_token], (error, res) => {
		if (error) throw error;
		if (res.rows.length === 0) return response.status(200).json({
			'error': 'Invalid token',
			'message': 'The token provided is not a valid token.'
		});

        const data = res.rows[0];
        // TODO: Check validation time

        // Clear user validation token and update password
		server.query('UPDATE users SET validation_token = NULL, validation_expire_time = NULL, password = $2 WHERE user_id = $1;', [data.user_id, md5(password)], (error, res) => {
			if(error) throw error;
		});

		
        return response.status(200).json({
            'error': '',
            'message': 'Success.'
        });
    
	});
};

export default endpoint;