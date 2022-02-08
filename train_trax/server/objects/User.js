import DB from './DB.js';
import md5 from 'md5';

export default class User {
	
	static async fromId(user_id) {
		const res = await DB.query('SELECT * FROM users WHERE user_id = $1;', [user_id]);
		return res.length === 0 ? null : res[0];
	}

	static async fromToken(token) {
		const res = await DB.query('SELECT * FROM users WHERE (user_token = $1 AND token_expire_time < $2) OR (validation_token = $1 AND validation_expire_time < $2);', [token, new Date().toISOString()]);
		return res.length === 0 ? null : res[0];
	}

	static async fromLogin(email, password) {
		const res = await DB.query('SELECT * FROM users WHERE email = $1 AND password = $2;', [email, md5(password)]);
		return res.length === 0 ? null : res[0];
	}

	static async fromEmail(email) {
		const res = await DB.query('SELECT * FROM users WHERE email = $1;', [email]);
		return res.length === 0 ? null : res[0];
	}

	static async setLoginToken(user_id, token, expire_time = new Date(new Date().getTime() + 60 * 60 * 1000).toISOString()) {
		return await DB.query('UPDATE users SET user_token = $1, token_expire_time = $2 WHERE user_id = $3;', [token, expire_time, user_id]);
	}

	static async setValidationToken(user_id, token, expire_time = new Date(new Date().getTime() + 60 * 60 * 1000).toISOString()) {
		return await DB.query('UPDATE users SET validation_token = $1, validation_expire_time = $2 WHERE user_id = $3;', [token, expire_time, user_id]);
	}

	static async setPassword(user_id, password) {
		return await DB.query('UPDATE users SET password = $1 WHERE user_id = $2;', [md5(password), user_id]);
	}

	static async create(email, password, name, phone_number) {
		return await DB.query('INSERT INTO users(email, password, name, phone_number) VALUES($1, $2, $3, $4);', [email, md5(password), name, phone_number]);
	}
}
