import User from '../objects/User.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { validation_token, password } = request.body;

	// Create return JSON structure
	const json = {
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (validation_token === undefined) undef.push('validation_token');
	if (password === undefined) undef.push('password');

	// If undeclared field, return error
	if (undef.length > 0) {
		json.error = 'Invalid payload';
		json.message = `Missing the following field${undef.length === 1 ? '' : 's'}: ${undef.join(', ')}.`;
		return response.status(400).json(json);
	}

	// Retrieve user data
	const user = await User.fromToken(validation_token);

	// If user does not exist, return invalid credentials
	if (user === null) {
		json.error = 'Invalid credentials';
		json.message = 'The token provided is either invalid or expired.';
		return response.status(401).json(json);
	}

	// Update the user's password
	await User.setPassword(user.user_id, password);
	await User.setValidationToken(user.user_id, null, null);
	return response.status(200).json(json);
};
