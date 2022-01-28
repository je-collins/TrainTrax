// Requires
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import express from 'express';
import pg from 'pg';
// import path from 'path';
// import router from './routes/index';
import login from './endpoints/login.js';
// import endpoints from './endpoints';

dotenv.config({
	path: './private/private.env'
});

// const {
// 	schema
// } = require('./models/users');

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
	connectionString: process.env.DB_URI,
	ssl: {
		rejectUnauthorized: false
	}
});
pool.connect();
export default pool;

app.listen(port, function() {
	console.log(`Server listening on port ${port}`)
});

app.get('/login', login);