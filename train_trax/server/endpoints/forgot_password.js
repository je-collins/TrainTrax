import Mailer from '../objects/Mailer.js';
import User from '../objects/User.js';
import md5 from 'md5';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { email } = request.body;

	// Create return JSON structure
	const json = {
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (email === undefined) undef.push('email');

	// If undeclared field, return error
	if (undef.length > 0) {
		json.error = 'Invalid payload';
		json.message = `Missing the following field${undef.length === 1 ? '' : 's'}: ${undef.join(', ')}.`;
		return response.status(400).json(json);
	}

	// Retrieve user data
	const user = await User.fromEmail(email);

	// If user does not exist, return invalid credentials
	if (user === null) {
		json.error = 'Invalid credentials';
		json.message = 'No user exists with the given email.';
		return response.status(401).json(json);
	}

	// Create token and update user information
	const token = md5(`token of ${user.user_id} at time ${new Date().getTime().toString()}`);
	await User.setValidationToken(user.user_id, token);

	// Send email
	await Mailer.sendEmail(user.email, 'Train Trax Password Reset', `Hello, ${user.name}! Please enter the following code into the webpage to reset your password. This code expires in 1 hour.\nCode: ${token}\n\nIf you did not request a password reset or do not wish to change your password, please ignore this email.`);
	return response.status(200).json(json);
};
