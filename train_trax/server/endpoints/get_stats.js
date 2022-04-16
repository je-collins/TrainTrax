import { Article, User } from '../objects/Objects.js';

export default async (users, sendNames) => {
	
	// Get list of user ids
	const user_ids = users.map(u => u.user_id);

	// Get article statistics
	let articles_started = 0;
	let articles_completed = 0;
	for (const article of await Article.getUserArticles()) {
		if (user_ids.includes(article.user_id)) {
			if (article.start_time !== null) articles_started++;
			if (article.complete_time !== null) articles_completed++;
		}
	}

	const user_list = [];
	for (const user of users) {
		user_list.push({
			user_id: user.user_id,
			name: user.name
		});
	}

	// Return statistics
	return {
		'users': sendNames ? user_list : [],
		'total_articles_started': articles_started,
		'total_articles_completed': articles_completed,
		'average_articles_started': articles_started / users.length,
		'average_articles_completed': articles_completed / users.length
	};
}