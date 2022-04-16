import { Article, Json, User } from '../objects/Objects.js';

export default (isStart) => async (request, response) => {
	// Destructure request body into relevant variables
	const { token, article_id, time } = request.body;

	// Create return JSON structure
	const json = new Json(response);

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (article_id === undefined) undef.push('article_id');
	if (isStart && time === undefined) undef.push('time');
	if (undef.length > 0) return json.badPayload(undef).send();

	// Retrieve user data
	const user = await User.fromToken(token);
	if (user === undefined) return json.badToken().send();
    
    // Retrieve article data
	const article = await Article.getArticleFromId(article_id);
    if (article === undefined || article.user_id !== user.user_id) return json.badArticle().send();

    // Update Article information
    await (isStart ? Article.setStart : Article.setEnd)(article_id, new Date(time ?? new Date()).toISOString());
	return json.send();
};
