// Requires
import bodyParser from 'body-parser';
import 'dotenv/config';
import express from 'express';
import pg from 'pg';

// Endpoints
import login from './endpoints/login.js';
import register from './endpoints/register.js';
import get_starred_domains from './endpoints/get_starred_domains.js';

// Create the app
const app = express();
const port = process.env.PORT || 3302;
app.set('port', port);

// Configure app
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
	extended: true
}));

// Connect to the database
const pool = new pg.Client({
	connectionString: process.env.DATABASE_URL,
	ssl: {
		rejectUnauthorized: false
	}
});
pool.connect();
export default pool;

// Have app listen on given port
app.listen(port, function() {
	console.log(`Server listening on port ${port}`)
});

// POST endpoints
app.post('/api/login', login);
app.post('/api/register', register);
app.post('/api/get_starred_domains', get_starred_domains);