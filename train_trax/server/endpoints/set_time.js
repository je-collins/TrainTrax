import Article from '../objects/Article.js';

export default (isStart) => async (request, response) => {
	// Destructure request body into relevant variables
	const { token , article_id , time } = request.body;

	// Create return JSON structure
	const json = {
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (article_id === undefined) undef.push('article_id');
	if (time === undefined) undef.push('time');

	// If undeclared field, return error
	if (undef.length > 0) {
		json.error = 'Invalid payload';
		json.message = `Missing the following field${undef.length === 1 ? '' : 's'}: ${undef.join(', ')}.`;
		return response.status(400).json(json);
	}

	// Retrieve user data
	const user = await User.fromToken(token);
    
	// If user token is not valid, return bad request
	if (user === null) {
        json.error = 'Bad request';
		json.message = 'The user session has expired.';
		return response.status(400).json(json);
    }
    
    // Retrieve user data
	const article = await Article.getArticleFromId(article_id);
    
	// If user token is not valid, return bad request
	if (article === null) {
        json.error = 'Bad request';
		json.message = 'The article does not exist.';
		return response.status(400).json(json);
	}
    
    // Update Article information
    await (isStart ? Article.setStart : Article.setEnd)(article_id, new Date(time).toISOString());
	return response.status(200).json(json);
};
