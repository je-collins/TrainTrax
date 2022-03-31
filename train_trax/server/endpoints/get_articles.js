import { Article, Json, User } from '../objects/Objects.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token } = request.body;

	// Create return JSON structure
	const json = new Json(response, 'results');

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (undef.length > 0) return json.badPayload(undef).send();

	// Retrieve user data
	const user = await User.fromToken(token);
	if (user === undefined) return json.badToken().send();

    // Retrieve all articles
	const articles = await Article.getArticles();
	const results = [];
	for (const row of articles) results.push(row.article);
	json.set('results', results);

	// Send articles
	return json.send();
};
