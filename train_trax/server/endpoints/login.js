import User from '../objects/User.js';
import md5 from 'md5';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { email, password } = request.body;

	// Create return JSON structure
	const json = {
		'token': '',
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (email === undefined) undef.push('email');
	if (password === undefined) undef.push('password');

	// If undeclared field, return error
	if (undef.length > 0) {
		json.error = 'Invalid payload';
		json.message = `Missing the following field${undef.length === 1 ? '' : 's'}: ${undef.join(', ')}.`;
		return response.status(400).json(json);
	}

	// Retrieve user data
	const user = await User.fromLogin(email, password);

	// If user does not exist, return invalid credentials
	if (user === null) {
		json.error = 'Invalid credentials';
		json.message = 'No user exists with the given email and password.';
		return response.status(401).json(json);
	}

	// Create token and update user information, return token
	const token = md5(`token of ${user.user_id} at time ${new Date().getTime().toString()}`);
	await User.setLoginToken(user.user_id, token);
	json.token = token;
	return response.status(200).json(json);
};
