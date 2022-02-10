import DB from './DB.js';

export default class Team {
	
	// create team
	static async createTeam(user_id, name) {
		return await DB.query('INSERT INTO teams(administrator, team_name) VALUES($1, $2);', [user_id, name]);
	}

	// add to team
	static async addMember(user_id, team_id) {
		return await DB.query('INSERT INTO team_users(user_id, team_id) VALUES($1, $2);', [user_id, team_id]);
    }

	// delete from team
	static async deleteMember(user_id, team_id) {
		return await DB.query('DELETE FROM team_users WHERE team_id = $2 AND user_id = $1;', [user_id, team_id]);
    }

	// delete team
	static async deleteTeam(team_id) {
		return await DB.query('DELETE FROM teams WHERE team_id = $1;', [team_id]);
    }

	// get team info
	static async getMembers(team_id) {
		const res = await DB.query('SELECT user_id FROM team_users WHERE team_id = $1;', [team_id]);
		return res.length === 0 ? null : res[0];
    }
}
