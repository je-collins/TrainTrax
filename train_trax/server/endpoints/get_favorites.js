import server from '../server.js';

const endpoint = (request, response) => {
    // Unpacking the request body object
    const { user_token } = request.body;
    console.log('We are currently in the reset password API');
        
    // Check if one or more fields is not declared
	const undef = [];
	if (user_token === undefined) undef.push('user_token');

    // If undeclared field, return error
	if (undef.length > 0) {
		return response.status(200).json({
			'error': 'Invalid payload',
			'message': 'Missing the following field(s): ' + undef.join(', ')
		});
	}

    // Check if a user with the given token exists
	server.query('SELECT * FROM users WHERE user_token = $1;', [user_token], (error, res) => {
		if (error) throw error;
		if (res.rows.length === 0) return response.status(200).json({
			'error': 'Invalid token',
			'message': 'The token provided is not a valid token.'
		});

        const user_data = res.rows[0];
        const favorites = [];

        // Select the favorite articles for the user
        server.query('SELECT * FROM starred_articles WHERE user_id = $1 AND is_favorite = TRUE;', [user_data.user_id], (error, res) => {
            if(error) throw error;
        });

        for(let row of res.rows) favorites.push(row.article);

        return response.status(200).json({
            'favorites': favorites,
            'error': '',
            'message': 'Success.'
        });
	});
};

export default endpoint;