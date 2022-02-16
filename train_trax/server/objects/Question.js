import DB from './DB.js';

export default class Question {
    
    static async addQuestion(user_id, question) {
		return await DB.query('INSERT INTO questions(user_id, question) VALUES($1, $2)', [user_id, question]);
    }
    
    static async addAnswer(question_id, user_id, answer) {
		return await DB.query('INSERT INTO answers(question_id, user_id, question) VALUES($1, $2, $3)', [question_id, user_id, answer]);
	}
}
