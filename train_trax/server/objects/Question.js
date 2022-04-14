import DB from './DB.js';

export default class Question {
    
	// Insert
    static async addQuestion(user_id, question) {
		return DB.query('INSERT INTO questions(user_id, question) VALUES($1, $2)', [user_id, question]);
    }
    
    static async addAnswer(question_id, user_id, answer) {
		return DB.query('INSERT INTO answers(question_id, user_id, answer) VALUES($1, $2, $3)', [question_id, user_id, answer]);
	}

	// Select
	static async getQuestions() {
		return DB.query('SELECT * FROM questions;');
	}

	static async getAnswers() {
		return DB.query('SELECT * FROM answers;');
	}
}
