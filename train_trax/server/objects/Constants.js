import md5 from 'md5';

export default class Constants {

	static get MAX_ARTICLES() {
		return 5;
	}

	static generateToken(user_id) {
		return md5(`token of ${user_id} at time ${new Date().getTime().toString()}`);
	}
}