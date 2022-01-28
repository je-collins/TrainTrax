import server from '../server.js';

const endpoint = (request, response) => {
	const { email, password } = request.body;

	if (email === undefined || password === undefined) {
		response.status(200).json({
			'info': 'Invalid payload, missing either email or password'
		});
	} else {
		server.query('SELECT * FROM users where email = $1 and password = $2;', [email, password], (error, results) => {
			if (error) throw error;
			if (results.rows.length === 0) response.status(200).json({ 'info': 'Incorrect email or password' });
			else response.status(200).json(results.rows[0]);
		});
	}
};

export default endpoint;