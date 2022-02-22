import { User, Json } from '../objects/Objects.js';
import md5 from 'md5';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { email, password } = request.body;

	// Create return JSON structure
	const json = new Json('token');

	// Check if one or more fields is not declared
	const undef = [];
	if (email === undefined) undef.push('email');
	if (password === undefined) undef.push('password');
	if (undef.length > 0) return json.badPayload(undef).send(response);

	// Retrieve user data
	const user = await User.fromLogin(email, password);
	if (user === null) return json.badCredentials().send(response);

	// Create token and update user information, return token
	const token = md5(`token of ${user.user_id} at time ${new Date().getTime().toString()}`);
	await User.setLoginToken(user.user_id, token);
	json.set('token', token);
	return json.send(response);
};
