import { Json, Team, User } from '../objects/Objects.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token, team_id } = request.body;

	// Create return JSON structure
	const json = new Json(response);

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (team_id === undefined) undef.push('team_id');
	if (undef.length > 0) return json.badPayload(undef).send();

	// Retrieve user data
	const admin = await User.fromToken(token);
	if (admin === undefined) return json.badToken().send();
	if (!admin.administrator) return json.notAdmin().send();

	// Get team info
	const team = await Team.getTeam(team_id);
	if (team === undefined) return json.error(Json.STATUS_BAD_INFO, 'Invalid Team', 'The given team does not exist.').send();
	if (admin.user_id !== team.administrator) return json.notAdmin().send();

	// Create team
	await Team.removeTeam(team_id);
	return json.send();
};
