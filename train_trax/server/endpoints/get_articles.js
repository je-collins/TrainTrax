import User from '../objects/User.js';
import Article from '../objects/Article';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token } = request.body;

	// Create return JSON structure
	const json = {
		'articles': [],
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (team_id === undefined) undef.push('team_id');

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

    // Get all articles in the articles table
	const articles = await Article.getAll();

	// If articles is not null return the articles
	if(articles != null) {
		for (const row in articles) json.articles.push(row.article)
	}
	
	return response.status(200).json(json);
};
