import { DB, Json, User } from '../objects/Objects.js';

export default (isDomain) => async (request, response) => {
	// Destructure request body into relevant variables
	const { token, article } = request.body;

	// Create return JSON structure
	const json = new Json();

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (article === undefined) undef.push('article');
	if (undef.length > 0) return json.badPayload(undef).send(response);

	// Retrieve user data
	const user = await User.fromToken(token);
	if (user === null) return json.badToken().send(response);

	// Query database for starred articles/domains and return
	await DB.query('INSERT INTO starred_articles(user_id, article, is_domain) VALUES($1, $2, $3);', [user.user_id, article, isDomain]);
	return json.send(response);
};
