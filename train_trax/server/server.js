// Requires
import bodyParser from 'body-parser';
import 'dotenv/config';
import express from 'express';

// Create the app
const app = express();
const port = process.env.PORT || 3302;
app.set('port', port);

// Configure app
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
	extended: true
}));

// Have app listen on given port
app.listen(port, function() {
	console.log(`Server listening on port ${port}`)
});

// Login-related Endpoints
import login from './endpoints/login.js';
import register from './endpoints/register.js';
app.post('/api/login', login);
app.post('/api/register', register);

// Password-related endpoints
import forgot_password from './endpoints/forgot_password.js';
import reset_password from './endpoints/reset_password.js';
app.post('/api/forgot_password', forgot_password);
app.post('/api/reset_password', reset_password);

// Get Articles/Domains endpoints
import get_articles from './endpoints/get_articles.js';
import get_favorites from './endpoints/get_favorites.js';
import get_starred from './endpoints/get_starred.js';
app.post('/api/get_articles', get_articles);
app.post('/api/get_favorites', get_favorites);
app.post('/api/get_starred_articles', get_starred(false));
app.post('/api/get_starred_domains', get_starred(true));

// Modify User Articles endpoints
import add_article from './endpoints/add_article.js';
import set_article_time from './endpoints/set_article_time.js';
import set_favorite from './endpoints/set_favorite.js';
app.post('/api/add_article', add_article);
app.post('/api/set_article_start_time', set_article_time(true));
app.post('/api/set_article_end_time', set_article_time(false));
app.post('/api/add_favorite', set_favorite(true));
app.post('/api/remove_favorite', set_favorite(false));

// Modify Starred Articles/Domains endpoints
import add_starred from './endpoints/add_starred.js';
app.post('/api/add_starred_article', add_starred(false));
app.post('/api/add_starred_domain', add_starred(true));

// Stats-related endpoints
import get_user_stats from './endpoints/get_user_stats.js';
import get_team_stats from './endpoints/get_team_stats.js';
import get_all_stats from './endpoints/get_all_stats.js';
app.post('/api/get_user_stats', get_user_stats);
app.post('/api/get_team_stats', get_team_stats);
app.post('/api/get_all_stats', get_all_stats);

// Team-related endpoints
import create_team from './endpoints/create_team.js';
import delete_team from './endpoints/delete_team.js';
import add_member from './endpoints/add_member.js';
import delete_member from './endpoints/delete_member.js';
app.post('/api/create_team', create_team);
app.post('/api/delete_team', delete_team);
app.post('/api/add_member', add_member);
app.post('/api/delete_member', delete_member);

// Question and Answer endpoints
import ask_question from './endpoints/ask_question.js';
import answer_question from './endpoints/answer_question.js';
import get_questions_answers from './endpoints/get_questions_answers.js';
app.post('/api/ask_question', ask_question);
app.post('/api/answer_question', answer_question);
app.post('/api/get_questions_answers', get_questions_answers);