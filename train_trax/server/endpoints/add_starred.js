import { Article, Constants, Json, User } from '../objects/Objects.js';

export default (isDomain) => async (request, response) => {
	// Destructure request body into relevant variables
	const { token, article } = request.body;

	// Create return JSON structure
	const json = new Json(response);

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (article === undefined) undef.push('article');
	if (undef.length > 0) return json.badPayload(undef).send();

	// Check if one or more fields are too long
	if (article.length > Constants.DB_ARTICLE_MAX_LENGTH) undef.push('article');
	if (undef.length > 0) return json.badData(undef).send();

	// Retrieve user data
	const user = await User.fromToken(token);
	if (user === undefined) return json.badToken().send();
	if (!user.administrator) return json.notAdmin().send();

	// Query database for starred articles/domains and return
	await Article.addStarred(user.user_id, article, isDomain);
	return json.send();
};
