import User from '../objects/User.js';
import Article from '../objects/Article.js';
import Team from '../objects/Team.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token , team_id } = request.body;

	// Create return JSON structure
	const json = {
        'member_articles': [],
        'team_articles': [],
        'team_completed': [],
        'completion_rate': [],
		'error': '',
		'message': ''
	};

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (team_id === undefined) undef.push('team_id');

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
	if (!user.administrator) {
        json.error = 'Bad request';
		json.message = 'The user is not an admin and connot edit teams.';
		return response.status(403).json(json);
	}

    // Get user_ids of all team members
    const user_ids = await Team.getMembers(team_id);

    let all_articles = [];
    
    let i = 0;
    // Get articles for each team members
    for (const id in user_ids) {
        i = 0;
        const list = []
        const user_articles = Article.getOrderedArticlesFromUser(id);
        all_articles.push(user_articles)
        for (const article in user_articles) {
            list.push({
                'id': article.article_id,
                'article': article.article
            })
            i++;
            if(i === 5) break;
        }
        json.member_articles.push({
            'user': id,
            'articles': list
        });
    }

    // Filter all articles by start time and take the top 5
    // What if they don't have a start time?
    all_articles.sort(function(a, b) { return a.start_time - b.start_time;})
    //for (const item in all_articles) print(item.name);

    i = 0;
    for (const item in all_articles) {
        json.team_articles.push({
            'id': item.article_id,
            'article': article
        });
        i++;
        if(i === 5) break;
    }

    // Filter all articles by complete time and take the top 5
    // What if they don't have a complete time?
    all_articles.sort(function(a, b) { return a.complete_time - b.complete_time;})
    i = 0;
    for (const item in all_articles) {
        json.team_completed.push({
            'id': item.article_id,
            'article': article
        });
        i++;
        if(i === 5) break;
    }

    // Count of completed / count of all
    const complete = all_articles.filter (({complete_time}) => complete_time !== null).length
    json.completion_rate = complete / length(all_articles);

	return response.status(200).json(json);
};
