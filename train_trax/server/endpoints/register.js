import { Json, Mailer, User } from '../objects/Objects.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { email, password, name, phone_number } = request.body;
	
	// Create return JSON structure
	const json = new Json();

	// Check if one or more fields is not declared
	const undef = [];
	if (email === undefined) undef.push('email');
	if (password === undefined) undef.push('password');
	if (name === undefined) undef.push('name');
	if (phone_number === undefined) undef.push('phone_number');
	if (undef.length > 0) return json.badPayload(undef).send(response);

	// If email exists, return duplicate email
	if (await User.fromEmail(email) !== null) return json.error(401, 'Duplicate email', 'A user with the given email already exists.').send(response);

	// If user does not exist, add them and send an email
	await User.create(email, password, name, phone_number);
	await Mailer.sendEmail(email, 'Welcome to Train Trax!', `Welcome ${name} to Train Trax!`);
	return json.send(response);
};
