import { DB, Json, User } from '../objects/Objects.js';

export default (isDomain) => async (request, response) => {
	// Destructure request body into relevant variables
	const { token } = request.body;

	// Create return JSON structure
	const json = new Json('results');

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (undef.length > 0) return json.badPayload(undef).send(response);

	// Retrieve user data
	const user = await User.fromToken(token);
	if (user === null) return json.badCredentials().send(response);

	// Query database for starred articles/domains and return
	const rows = await DB.query('SELECT * FROM starred_articles WHERE is_domain = $1;', [isDomain]);
	for (const row of rows) json.get('results').push(row.article);
	return json.send(response);
};
