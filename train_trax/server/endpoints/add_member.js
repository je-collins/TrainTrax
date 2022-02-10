import User from '../objects/User.js';
import Team from '../objects/Team.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token , team_id , member_id} = request.body;

	// Create return JSON structure
	const json = {
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (team_id === undefined) undef.push('team_id');
    if (member_id === undefined) undef.push('member_id');

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
	if (user.administrator) {
        json.error = 'Bad request';
		json.message = 'The user is not an admin and connot edit teams.';
		return response.status(400).json(json);
	}

    // Check if the user exists in the team
    const member = await Team.fromId(team_id, member_id);

    // If user exists in the team, return invalid credentials
	if (member !== null) {
        json.error = 'Bad request';
		json.message = 'The user already exists in the team.';
		return response.status(401).json(json);
	}
    
	// Update team information
	await Team.addMember(member_id, team_id);
	return response.status(200).json(json);
};
