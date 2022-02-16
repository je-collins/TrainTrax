import Question from '../objects/Question.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token , question_id , answer_text} = request.body;

	// Create return JSON structure
	const json = {
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (question_id === undefined) undef.push('question_id');
	if (answer_text === undefined) undef.push('answer_text');

	// If undeclared field, return error
	if (undef.length > 0) {
		json.error = 'Invalid payload';
		json.message = `Missing the following field${undef.length === 1 ? '' : 's'}: ${undef.join(', ')}.`;
		return response.status(400).json(json);
	}

	// Retrieve user data
	const user = await User.fromToken(token);
    
	// If user token is not valid, return bad request
	if (user === null) {
        json.error = 'Bad request';
		json.message = 'The user session has expired.';
		return response.status(400).json(json);
	}

	// If user is not an admin, return bad request
	if (!user.administrator) {
        json.error = 'Bad request';
		json.message = 'The user is not an admin and connot edit teams.';
		return response.status(403).json(json);
	}
    
	// Update team information
	await Question.addAnswer(question_id, user.user_id, answer_text);
	return response.status(200).json(json);
};
