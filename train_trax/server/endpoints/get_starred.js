import User from '../objects/User.js';
import DB from '../objects/DB.js';

export default (isDomain) => async (request, response) => {
	// Destructure request body into relevant variables
	const { token } = request.body;

	// Create return JSON structure
	const json = {
		'results': [],
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');

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
	const rows = await DB.query('SELECT * FROM starred_articles WHERE is_domain = $1;', [isDomain]);
	for (const row of rows) json.results.push(row.article);
	return response.status(200).json(json);
};
