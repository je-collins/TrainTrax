import DB from './DB.js';

export default class Article {
    
	// Starred Articles
	static async addStarred(user_id, article, is_domain) {
		return DB.query('INSERT INTO starred_articles(user_id, article, is_domain) VALUES($1, $2, $3);', user_id, article, is_domain);
	}

    static async getArticlesFromUser(user_id) {
		const res = await DB.query('SELECT * FROM articles WHERE user_id = $1;', [user_id]);
		return res.length === 0 ? [] : res;
	}

	static async getArticlesFromTeamMembers(team) {
		const res = await DB.query('SELECT * FROM articles WHERE user_id = ANY ($1);', [user_id]);
		return res.length === 0 ? [] : res;
	}

	static async getArticleFromId(article_id) {
		const res = await DB.query('SELECT * FROM articles WHERE article_id = $1;', [article_id]);
		return res.length === 0 ? [] : res;
	}

    static async getFavoritesFromUser(user_id) {
		const res = await DB.query('SELECT * FROM articles WHERE user_id = $1 AND is_favorite = TRUE;', [user_id]);
		return res.length === 0 ? [] : res;
	}

	static async getArticles() {
		const res = await DB.query('SELECT DISTINCT article FROM articles;');
		return res.length === 0 ? [] : res;
	}

    static async getStarredArticlesFromUser(user_id) {
		const res = await DB.query('SELECT * FROM starred_articles WHERE user_id = $1 AND is_domain = FALSE;', [user_id]);
		return res.length === 0 ? [] : res;
	}

    static async getStarredArticles() {
		const res = await DB.query('SELECT DISTINCT article, starred_article_id, user_id FROM starred_articles WHERE is_domain = FALSE;');
		return res.length === 0 ? [] : res;
	}

    static async getStarredDomainsFromUser(user_id) {
		const res = await DB.query('SELECT * FROM starred_articles WHERE user_id = $1 AND is_domain = TRUE;', [user_id]);
		return res.length === 0 ? [] : res;
	}

    static async getStarredDomains() {
		const res = await DB.query('SELECT DISTINCT article, starred_article_id, user_id FROM starred_articles WHERE is_domain = TRUE;');
		return res.length === 0 ? [] : res;
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
        return await DB.query('UPDATE articles SET complete_time = $1 WHERE article_id = $2;', [end_time, article_id]);
    }

    static async getStarted(user_id) {
		const res = await DB.query('SELECT * FROM articles WHERE user_id = $1 AND complete_time IS NULL;', [user_id]);
		return res.length === 0 ? [] : res;
	}

    static async getCompleted(user_id) {
		const res = await DB.query('SELECT * FROM articles WHERE user_id = $1 AND complete_time IS NOT NULL;', [user_id]);
		return res.length === 0 ? [] : res;
	}
}
