import server from '../server.js';
import md5 from 'md5';

const endpoint = (request, response) => {
    // Unpacking the request body object
    const { user_token, is_library } = request.body;
    console.log('We are currently in the reset password API');
        
    // Check if one or more fields is not declared
	const undef = [];
	if (user_token === undefined) undef.push('user_token');
    if (is_library === undefined) is_library = false;

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
        const article_data = [];

        if(is_library)
        {
            server.query('SELECT * FROM starred_articles WHERE is_domain = FALSE;', [user_data.user_id], (error, res) => {
                if(error) throw error;
            });

            for(let row of res.rows) article_data.push(row.article);
        }
        else
        {
            server.query('SELECT * FROM starred_articles WHERE user_id = $1 AND is_domain = FALSE;', [user_data.user_id], (error, res) => {
                if(error) throw error;
            });
            
            for(let row of res.rows) article_data.push(row.article);
        }

		
        return response.status(200).json({
            'error': '',
            'message': 'Success.'
        });
	});
};

export default endpoint;