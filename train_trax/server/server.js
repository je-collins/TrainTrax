// Requires
import bodyParser from 'body-parser';
import 'dotenv/config';
import express from 'express';

// Endpoints
import login from './endpoints/login.js';
import register from './endpoints/register.js';
import forgot_password from './endpoints/forgot_password.js';
import reset_password from './endpoints/reset_password.js';
import get_starred from './endpoints/get_starred.js';
import get_favorites from './endpoints/get_favorites.js';
import add_member from './endpoints/add_members.js';
import delete_member from './endpoints/delete_member.js';
import get_articles from './endpoints/get_articles.js';
import set_favorite from './endpoints/set_favorite.js';

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

// POST endpoints
app.post('/api/login', login);
app.post('/api/register', register);
app.post('/api/forgot_password', forgot_password);
app.post('/api/reset_password', reset_password);
app.post('/api/get_starred_articles', get_starred(false));
app.post('/api/get_starred_domains', get_starred(true));
app.post('/api/get_favorites', get_favorites);
app.post('/api/add_member', add_member);
app.post('/api/delete_member', delete_member);
app.post('/api/delete_member', get_articles);
app.post('/api/add_favorite', set_favorite(true));
app.post('/api/remove_favorite', set_favorite(false));
app.post('/api/add_starred_article', add_starred(false));
app.post('/api/add_starred_domain', add_starred(true));
