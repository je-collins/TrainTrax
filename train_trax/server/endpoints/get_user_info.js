import { Json, Team, User } from '../objects/Objects.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token } = request.body;

	// Create return JSON structure
	const json = new Json(response, 'user_id', 'email', 'name', 'phone_number', 'administrator');

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (undef.length > 0) return json.badPayload(undef).send();

	// Retrieve user data
	const user = await User.fromToken(token);
	if (user === undefined) return json.badToken().send();

	json.set('user_id', user.user_id);
	json.set('email', user.email);
	json.set('name', user.name);
	json.set('phone_number', user.phone_number);
	json.set('administrator', user.administrator);

	// Send information
	return json.send();
};
