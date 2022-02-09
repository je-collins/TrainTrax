import DB from './DB.js';

export default class Article {
    
    static async fromToken(token) {
        const res = await DB.query('SELECT * FROM users WHERE (user_token = $1 AND token_expire_time > $2) OR (validation_token = $1 AND validation_expire_time > $2);', [token, new Date().toISOString()]);
        return res.length === 0 ? null : res[0];
    }

	static async fromId(user_id) {
		const res = await DB.query('SELECT * FROM articles WHERE user_id = $1;', [user_id]);
		return res.length === 0 ? null : res[0];
	}

	static async setFavorite(user_id, article_id, favorite) {
		return await DB.query('UPDATE users SET is_favorite = $1 WHERE user_id = $2 AND article_id = $3;', [favorite, user_id, article_id]);
	}

	static async add(user_id, article) {
		return await DB.query('INSERT INTO articles(user_id, article, is_favorite) VALUES($1, $2, FALSE);', [user_id, article]);
    }
    
    static async setStart(article_id, start_time) {
        return await DB.query('UPDATE articles SET start_time = $1 WHERE article_id = $2;', [start_time, article_id]);
    }

    static async setEnd(article_id, end_time) {
        return await DB.query('UPDATE articles SET end_time = $1 WHERE article_id = $2;', [end_time, article_id]);
    }
}
