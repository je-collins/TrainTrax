import { Json, Team, User } from '../objects/Objects.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token, team_id, member_id} = request.body;

	// Create return JSON structure
	const json = new Json(response);

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (team_id === undefined) undef.push('team_id');
	if (member_id === undefined) undef.push('member_id');
	if (undef.length > 0) return json.badPayload(undef).send();

	// Retrieve user data
	const user = await User.fromToken(token);
    if (user === null) return json.badToken().send();
	if (!user.administrator) return json.notAdmin().send();
    
    // Check if the user exists in the team
    const member = await Team.getMemberFromTeamAndId(team_id, member_id);
	if (member !== undefined) return json.error(Json.STATUS_BAD_INFO, 'Invalid member', 'The user does not exist in this team.').send();
    
	// Update team information
	await Team.removeMemberFromTeam(team_id, member_id);
	return json.send();
};
