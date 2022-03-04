import { Article, Json, Team, User } from '../objects/Objects.js';

export default async (request, response) => {
	// Destructure request body into relevant variables
	const { token , team_id } = request.body;

	// Create return JSON structure
	const json = new Json('member_articles', 'team_articles', 'team_completed', 'completion_rate', response);
	json.put('member_articles', []);
	json.put('team_articles', []);
	json.put('team_completed', []);

	// Check if one or more fields is not declared
	const undef = [];
	if (token === undefined) undef.push('token');
	if (team_id === undefined) undef.push('team_id');
	if (undef.length > 0) return json.badPayload(undef).send();

	// Retrieve user data
	const user = await User.fromToken(token);
	if (user === undefined) return json.badToken().send();
	if (!user.administrator) return json.notAdmin().send();

    // Get user_ids of all team members
    const user_ids = await Team.getMembersFromTeam(team_id);

    let i = 0;
    let team_articles = await Article.getArticlesFromUsers(user_ids);

    // Filter all articles by start time
    team_articles.sort(function(a, b) { return a.start_time - b.start_time;})
    //for (const item in all_articles) print(item.name);

    // Get articles for each team member
    for (const id of user_ids) {
        i = 0;
        const list = [];
        for (const article in team_articles){
            if(article.user_id === id){
                console.log(id);
                list.push({
                    'id': article.article_id,
                    'article': article.article
                });
                i++;
            }
            if (list.length === 5) break;
        }
        json.get('member_articles').push({
            'user': id,
            'articles': list
        });        
    }

    // Take top 5 most recently started articles
    for (const item in team_articles.slice(0, 5)) {
        json.get('team_articles').push({
            'id': item.article_id,
            'article': item.article
        });
    }

    // Filter all articles by complete time and take the top 5
    // What if they don't have a complete time?
    team_articles.sort(function(a, b) { return a.complete_time - b.complete_time;})
    for (const item of team_articles.slice(0, 5)) 
        if(item.complete_time !== null) {
            json.team_completed.push({
                'id': item.article_id,
                'article': article
            });
        }
    }

    // Count of completed / count of all
    const complete = team_articles.filter (({complete_time}) => complete_time !== null).length
    json.set('completion_rate') = complete / team_articles.length;

	return json.send();
};
