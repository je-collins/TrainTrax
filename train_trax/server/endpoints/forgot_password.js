import { Json, Mailer, User } from '../objects/Objects.js';
import md5 from 'md5';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { email } = request.body;

	// Create return JSON structure
	const json = new Json(response);

	// Check if one or more fields is not declared
	const undef = [];
	if (email === undefined) undef.push('email');
	if (undef.length > 0) return json.badPayload(undef).send();

	// Retrieve user data
	const user = await User.fromEmail(email);
	if (user === null) return json.badCredentials().send();

	// Create token and update user information
	const token = md5(`token of ${user.user_id} at time ${new Date().getTime().toString()}`);
	await User.setValidationToken(user.user_id, token);

	// Send email
	await Mailer.sendEmail(user.email, 'Train Trax Password Reset', `Hello, ${user.name}! Please enter the following code into the webpage to reset your password. This code expires in 1 hour.\nCode: ${token}\n\nIf you did not request a password reset or do not wish to change your password, please ignore this email.`);
	return json.send();
};
