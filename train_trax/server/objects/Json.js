export default class Json {

	// Private class variables
	#replied = false;
	#status = 200;
	#json = {
		'error': '',
		'message': ''
	};

	// Constructor
	constructor(...parameters) {
		for (const name of parameters) {
			this.#json[name] = '';
		}
	}

	// Generic functions
	message(message) {
		this.#json['message'] = message;
		return this;
	}

	error(status, error, message) {
		this.#status = status;
		this.#json['error'] = error;
		this.#json['message'] = message;
		return this;
	}

	// Object getter and setters
	set(field, value) {
		this.#json[field] = value;
		return this;
	}

	get(field) {
		return this.#json[field];
	}

	// Helper functions
	badPayload(missing) {
		return this.error(400, 'Invalid payload', `Missing the following field${missing.length === 1 ? '' : 's'}: ${missing.join(', ')}.`);
	}

	badCredentials() {
		return this.error(401, 'Invalid credentials', 'No user exists with the given email and password.');
	}

	badToken() {
		return this.error(401, 'Invalid credentials', 'The token provided is either invalid or expired.')
	}

	// Send the json as the response
	send(response) {
		if (!this.#replied) {
			this.#replied = true;
			response.status(this.#status).json(this.#json);
		}

		return this;
	}
}