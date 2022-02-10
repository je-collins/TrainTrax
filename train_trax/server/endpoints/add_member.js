import User from '../objects/User.js';
import Teams from '../objects/Teams.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token , team_id , user_id} = request.body;

	// Create return JSON structure
	const json = {
		'token': '',
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (team_id === undefined) undef.push('team_id');
    if (user_id === undefined) undef.push('user_id');

	// If undeclared field, return error
	if (undef.length > 0) {
		json.error = 'Invalid payload';
		json.message = `Missing the following field${undef.length === 1 ? '' : 's'}: ${undef.join(', ')}.`;
		return response.status(400).json(json);
	}

	// Retrieve user data
	const user = await User.fromToken(token);
    
	// If user does not exist, return invalid credentials
	if (user === null) {
        json.error = 'Bad request';
		json.message = 'The given user does not exist.';
		return response.status(400).json(json);
	}

    // Check if the user exists in the team
    const member = await Teams.fromId(team_id, user.user_id);

    // If user exists in the team, return invalid credentials
	if (member != null) {
        json.error = 'Bad request';
		json.message = 'The user already exists in the team.';
		return response.status(401).json(json);
	}
    
	// Update team information
	await Teams.addMember(user.user_id, team_id);
	json.token = token;
	return response.status(200).json(json);
};
