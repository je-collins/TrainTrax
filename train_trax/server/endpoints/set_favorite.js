import { Article, Json, User } from '../objects/Objects.js';

export default (addFavorite) => async (request, response) => {
	// Destructure request body into relevant variables
	const { token, article_id } = request.body;

	// Create return JSON structure
	const json = new Json(response);

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (article_id === undefined) undef.push('article_id');
	if (undef.length > 0) return json.badPayload(undef).send();

	// Retrieve user data
	const user = await User.fromToken(token);
	if (user === null) return json.badCredentials().send();

	// Query database for favorited articles and return
	await Article.setFavorite(user.user_id, article_id, addFavorite);
	return json.send();
};
