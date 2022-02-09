import DB from './DB.js';

export default class Article {
	
	// static async fromId(user_id) {
	// 	const res = await DB.query('SELECT * FROM users WHERE user_id = $1;', [user_id]);
	// 	return res.length === 0 ? null : res[0];
	// }

	// static async fromToken(token) {
	// 	const res = await DB.query('SELECT * FROM users WHERE (user_token = $1 AND token_expire_time > $2) OR (validation_token = $1 AND validation_expire_time > $2);', [token, new Date().toISOString()]);
	// 	return res.length === 0 ? null : res[0];
	// }

	// static async setPassword(user_id, password) {
	// 	return await DB.query('UPDATE users SET password = $1 WHERE user_id = $2;', [md5(password), user_id]);
	// }

	// static async create(email, password, name, phone_number) {
	// 	return await DB.query('INSERT INTO users(email, password, name, phone_number) VALUES($1, $2, $3, $4);', [email, md5(password), name, phone_number]);
	// }
}
