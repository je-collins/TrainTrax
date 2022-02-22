import User from '../objects/User.js';
import DB from '../objects/DB.js';

export default (isDomain) => async (request, response) => {
	// Destructure request body into relevant variables
	const { token, article } = request.body;

	// Create return JSON structure
	const json = {
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (article === undefined) undef.push('article');

	// If undeclared field, return error
	if (undef.length > 0) {
		json.error = 'Invalid payload';
		json.message = `Missing the following field${undef.length === 1 ? '' : 's'}: ${undef.join(', ')}.`;
		return response.status(400).json(json);
	}

	// Retrieve user data
	const user = await User.fromToken(token);

	// If user does not exist, return invalid credentials
	if (user === null) {
		json.error = 'Invalid credentials';
		json.message = 'The token provided is either invalid or expired.';
		return response.status(401).json(json);
	}

	// Query database for starred articles/domains and return
	await DB.query('INSERT INTO starred_articles(user_id, article, is_domain) VALUES($1, $2, $3);', [user.user_id, article, isDomain]);
	return response.status(200).json(json);
};
