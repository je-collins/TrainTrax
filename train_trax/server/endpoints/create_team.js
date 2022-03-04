import { Json, Team, User } from '../objects/Objects.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token, team_name } = request.body;

	// Create return JSON structure
	const json = new Json(response);

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (team_name === undefined) undef.push('team_name');
	if (undef.length > 0) return json.badPayload(undef).send();

	// Retrieve user data
	const admin = await User.fromToken(token);
	if (admin === undefined) return json.badToken().send();
	if (!admin.administrator) return json.notAdmin().send();

	// Create team
	await Team.addTeam(admin.user_id, team_name);
	return json.send();
};