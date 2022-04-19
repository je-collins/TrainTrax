// Requires
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import express from 'express';
import path from 'path';

dotenv.config({
    path: path.resolve(__dirname, './.env')
});

// Create the app
const app = express();
const port = process.env.PORT || 3302;
app.set('port', port);

// Configure app
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
	extended: true
}));

// Login-related Endpoints
import login from './endpoints/login.js'; 
import register from './endpoints/register.js'; 
app.post('/api/login', login); // tested
app.post('/api/register', register); // tested

// Password-related endpoints
import forgot_password from './endpoints/forgot_password.js'; 
import reset_password from './endpoints/reset_password.js'; 
app.post('/api/forgot_password', forgot_password); // tested
app.post('/api/reset_password', reset_password); // tested

// Get Articles/Domains endpoints
import get_articles from './endpoints/get_articles.js'; 
import get_favorites from './endpoints/get_favorites.js';
import get_starred from './endpoints/get_starred.js';
import get_all_articles from './endpoints/get_all_articles.js'; 
app.post('/api/get_articles', get_articles); // tested
app.post('/api/get_favorites', get_favorites); // tested
app.post('/api/get_starred_articles', get_starred(false)); // tested
app.post('/api/get_starred_domains', get_starred(true)); // tested
app.post('/api/get_all_articles', get_all_articles); // tested

// Modify User Articles endpoints
import add_article from './endpoints/add_article.js';
import set_article_time from './endpoints/set_article_time.js';
import set_favorite from './endpoints/set_favorite.js';
app.post('/api/add_article', add_article); // tested
app.post('/api/set_article_start_time', set_article_time(true)); // tested
app.post('/api/set_article_end_time', set_article_time(false)); // tested
app.post('/api/add_favorite', set_favorite(true)); // tested
app.post('/api/remove_favorite', set_favorite(false)); // tested

// Modify Starred Articles/Domains endpoints
import add_starred from './endpoints/add_starred.js';
app.post('/api/add_starred_article', add_starred(false)); // tested
app.post('/api/add_starred_domain', add_starred(true)); // tested

// Info endpoints
import get_users from './endpoints/get_users.js';
import get_user_info from './endpoints/get_user_info.js';
import get_team_info from './endpoints/get_team_info.js';
app.post('/api/get_users', get_users); // tested
app.post('/api/get_user_info', get_user_info); // tested
app.post('/api/get_team_info', get_team_info); // tested

// Stats-related endpoints
import get_user_stats from './endpoints/get_user_stats.js';
import get_team_stats from './endpoints/get_team_stats.js';
import get_all_stats from './endpoints/get_all_stats.js';
app.post('/api/get_user_stats', get_user_stats); // tested
app.post('/api/get_team_stats', get_team_stats); // tested
app.post('/api/get_all_stats', get_all_stats); // tested

// Team-related endpoints
import create_team from './endpoints/create_team.js';
import delete_team from './endpoints/delete_team.js';
import add_member from './endpoints/add_member.js';
import delete_member from './endpoints/delete_member.js';
app.post('/api/create_team', create_team); // tested
app.post('/api/delete_team', delete_team); // tested
app.post('/api/add_member', add_member); // tested
app.post('/api/delete_member', delete_member); // tested

// Question and Answer endpoints
import ask_question from './endpoints/ask_question.js';
import answer_question from './endpoints/answer_question.js';
import get_questions_answers from './endpoints/get_questions_answers.js';
app.post('/api/ask_question', ask_question);
app.post('/api/answer_question', answer_question);
app.post('/api/get_questions_answers', get_questions_answers);

export { 
	app,
	port
}