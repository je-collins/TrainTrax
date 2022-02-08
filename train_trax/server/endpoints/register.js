import Mailer from '../objects/Mailer.js';
import User from '../objects/User.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { email, password, name, phone_number } = request.body;
	
	// Create return JSON structure
	const json = {
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (email === undefined) undef.push('email');
	if (password === undefined) undef.push('password');
	if (name === undefined) undef.push('name');
	if (phone_number === undefined) undef.push('phone_number');

	// If undeclared field, return error
	if (undef.length > 0) {
		json.error = 'Invalid payload';
		json.message = `Missing the following field${undef.length === 1 ? '' : 's'}: ${undef.join(', ')}.`;
		return response.status(400).json(json);
	}

	// If email exists, return duplicate email
	if (await User.fromEmail(email) !== null) {
		json.error = 'Duplicate email',
		json.message = 'A user with the given email already exists.';
		return response.status(401).json(json);
	}

	// If user does not exist, add them and send an email
	await User.create(email, password, name, phone_number);
	await Mailer.sendEmail(email, 'Welcome to Train Trax!', `Welcome ${name} to Train Trax!`);
	return response.status(200).json(json);
};
