import { listen } from 'express/lib/application';
import supertest from 'supertest';
import { app } from '../../server/app.js';
import { Json, User, Team, DB, Question } from '../../server/objects/Objects.js';

const true_payload = {
    'email': 'test@gmail.com',
    'password': 'Password',
    'name': 'Tester',
    'phone_number': '0123456789',
    'article_id': -1,
    'team_id': []
}

describe('Train Trax API', () => {
    describe('check .env', () => {
        it('should not be undefined', () => {
            expect(process.env.DATABASE_URL).not.toBe(undefined);
        });
    });

    // Login and Password related endpoints
    describe('test register endpoint', () => {
        describe('given no email is not provided', () => {
            it('should return bad payload', async () => 
            {
                const payload = {
                    'password': 'badPassword',
                    'name': 'John',
                    'phone_number': '0123456789'
                };
                await supertest(app).post('/api/register').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given no password is not provided', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'email': 'fake@email.com',
                    'name': 'John',
                    'phone_number': '0123456789'
                };
                await supertest(app).post('/api/register').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the name is not provided', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'email': 'fake@email.com',
                    'password': 'badPassword',
                    'phone_number': '0123456789'
                };
                await supertest(app).post('/api/register').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the phone number is not provided', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'email': 'fake@email.com',
                    'password': 'badPassword',
                    'name': 'John'
                };
                await supertest(app).post('/api/register').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        // describe('given good info', () => {
        //     it('should return bad payload', async () => {
        //         const payload = {
        //             'email': true_payload.email,
        //             'password': true_payload.password,
        //             'name': true_payload.name,
        //             'phone_number': true_payload.phone_number
        //         };
        //         await supertest(app).post('/api/register').send(payload).expect(Json.STATUS_SUCCESS);
        //     });
        // });

        describe('given existing email', () => {
            it('should return bad info', async () => {
                const payload = {
                    'email': true_payload.email,
                    'password': true_payload.password,
                    'name': true_payload.name,
                    'phone_number': true_payload.phone_number
                };
                await supertest(app).post('/api/register').send(payload).expect(Json.STATUS_BAD_INFO);
            });
        });
    });

    describe('test login user endpoint', () => {
        describe('given the user does not exists', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'email': 'fake@email.com',
                    'password': 'badPassword'
                };
                await supertest(app).post('/api/login').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given the email is not provided', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'password': 'badPassword'
                };
                await supertest(app).post('/api/login').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the password is not provided', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'email': 'fake@email.com'
                };
                await supertest(app).post('/api/login').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given good info', () => {
            it('should return success', async () => {
                const payload = {
                    'email': true_payload.email,
                    'password': true_payload.password,
                };
                const res = await supertest(app).post('/api/login').send(payload);
                true_payload['token'] = res.body.token;
                expect(res.body.token).toBeDefined();
                expect(res.body.token.length).toEqual(32);
                expect(res.status).toBe(Json.STATUS_SUCCESS);
            });
        });
    });

    describe('test forgot password endpoint', () => {
        describe('given the email is not provided', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/forgot_password').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the email does not exist', () => {
            it('should return bad credetials', async () => {
                const payload = {
                    'email':'bademail'
                };
                await supertest(app).post('/api/forgot_password').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given good info', () => {
            it('should return success', async () => {
                const payload = {
                    'email': true_payload.email
                };
                await supertest(app).post('/api/forgot_password').send(payload).expect(Json.STATUS_SUCCESS);
                const user = await User.fromEmail(payload.email)
                true_payload['validation_token'] = user.validation_token
                true_payload['user_id'] = user.user_id
                true_payload['token'] = user.user_token
            });
        });
    });

    describe('test reset password endpoint', () => {
        describe('given the validation token is not provided', () => {
            it('should return bad payload', async () => {
                const payload = {
                    "password": 'notset'
                };
                await supertest(app).post('/api/reset_password').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the password is not provided', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'validation_token':true_payload.validation_token
                };
                await supertest(app).post('/api/reset_password').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the validation code provided is bad', () => {
            it('should return bad credetials', async () => {
                const payload = {
                    'validation_token':'bad',
                    'password': 'Password'
                };
                await supertest(app).post('/api/reset_password').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given good info', () => {
            it('should return success', async () => {
                const payload = {
                    'validation_token':true_payload.validation_token,
                    'password': true_payload.password
                };
                await supertest(app).post('/api/reset_password').send(payload).expect(Json.STATUS_SUCCESS);
            });
        });
    });

    // Add Articles
    describe('test add articles endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'article': 'test'
                };
                await supertest(app).post('/api/add_article').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the article is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'bad'
                };
                await supertest(app).post('/api/add_article').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'article': 'test'
                };
                await supertest(app).post('/api/add_article').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        // describe('given got info', () => {
        //     it('should return succes message', async () => {
        //         const payload = {
        //             'token': true_payload.token,
        //             'article': 'https://en.wikipedia.org/wiki/The_Minute_Man'
        //         };
        //         await supertest(app).post('/api/add_article').send(payload).expect(Json.STATUS_SUCCESS);
        //     });
        // });
    });
    
    // Get Articles/Domains endpoints 
    describe('test get articles endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/get_articles').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad'
                };
                await supertest(app).post('/api/get_articles').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info', () => {
            it('should return a list of articles', async () => {
                const payload = {
                    'token': true_payload.token
                };
                const res = await supertest(app).post('/api/get_articles').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.results).toBeInstanceOf(Array);
                for (const article of res.body.results) {
                    true_payload.article_id = article.article_id;
                    break;
                }
            });
        });
    });

    describe('test get favorites endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/get_favorites').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad'
                };
                await supertest(app).post('/api/get_favorites').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info', () => {
            it('should return a list of articles', async () => {
                const payload = {
                    'token': true_payload.token
                };
                const res = await supertest(app).post('/api/get_favorites').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.results).toBeInstanceOf(Array);
            });
        });
    });

    describe('test starred articles endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/get_starred_articles').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad'
                };
                await supertest(app).post('/api/get_starred_articles').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info', () => {
            it('should return a list of articles', async () => {
                const payload = {
                    'token': true_payload.token
                };
                const res = await supertest(app).post('/api/get_starred_articles').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.results).toBeInstanceOf(Array);
            });
        });
    });

    describe('test starred domains endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/get_starred_domains').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad'
                };
                await supertest(app).post('/api/get_starred_domains').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info', () => {
            it('should return a list of articles', async () => {
                const payload = {
                    'token': true_payload.token
                };
                const res = await supertest(app).post('/api/get_starred_domains').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.results).toBeInstanceOf(Array);
            });
        });
    });
    
    describe('test get all articles endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/get_all_articles').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad'
                };
                await supertest(app).post('/api/get_all_articles').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info', () => {
            it('should return a list of articles', async () => {
                const payload = {
                    'token': true_payload.token
                };
                const res = await supertest(app).post('/api/get_all_articles').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.results).toBeInstanceOf(Array);
            });
        });
    });

    // Modify User Articles endpoints
    describe('test set article start time endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'article_id': 1,
                    'time': 'test'
                };
                await supertest(app).post('/api/set_article_start_time').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the article is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'test',
                    'time': 'test'
                };
                await supertest(app).post('/api/set_article_start_time').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the time is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'test',
                    'article_id': 1
                };
                await supertest(app).post('/api/set_article_start_time').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'article_id': 1,
                    'time': 'test'
                };
                await supertest(app).post('/api/set_article_start_time').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad article', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': 1,
                    'time': 'test'
                };
                await supertest(app).post('/api/set_article_start_time').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given an article that does not match the user', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': 1,
                    'time': 'test'
                };
                await supertest(app).post('/api/set_article_start_time').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given good info', () => {
            it('should return success message', async () => {
                const time = new Date().toISOString()
                const payload = {
                    'token': true_payload.token,
                    'article_id': true_payload.article_id,
                    'time': time
                };
                await supertest(app).post('/api/set_article_start_time').send(payload).expect(Json.STATUS_SUCCESS);
            });
        });
    });

    describe('test set article end time endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'article_id': 1,
                    'time': 'test'
                };
                await supertest(app).post('/api/set_article_end_time').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the article is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'test',
                    'time': 'test'
                };
                await supertest(app).post('/api/set_article_end_time').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'article_id': 1,
                    'time': 'test'
                };
                await supertest(app).post('/api/set_article_end_time').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad article', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': 1,
                    'time': 'test'
                };
                await supertest(app).post('/api/set_article_end_time').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given an article that does not match the user', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': 1,
                    'time': 'test'
                };
                await supertest(app).post('/api/set_article_end_time').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info with no time', () => {
            it('should return success message', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': true_payload.article_id
                };
                await supertest(app).post('/api/set_article_end_time').send(payload).expect(Json.STATUS_SUCCESS);
            });
        });

        describe('given got info with time', () => {
            it('should return success message', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': true_payload.article_id,
                    'time': Date.now
                };
                await supertest(app).post('/api/set_article_end_time').send(payload).expect(Json.STATUS_SUCCESS);
            });
        });
    });

    describe('test add favorite endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'article_id': 1,
                };
                await supertest(app).post('/api/add_favorite').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the article is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'test'
                };
                await supertest(app).post('/api/add_favorite').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'article_id': 1
                };
                await supertest(app).post('/api/add_favorite').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad article', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': -1
                };
                await supertest(app).post('/api/add_favorite').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given an article that does not match the user', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': 1
                };
                await supertest(app).post('/api/add_favorite').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given good info', () => {
            it('should return success message', async () => {
                const time = new Date().toISOString()
                const payload = {
                    'token': true_payload.token,
                    'article_id': true_payload.article_id
                };
                await supertest(app).post('/api/add_favorite').send(payload).expect(Json.STATUS_SUCCESS);
            });
        });
    });

    describe('test remove favorite endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'article_id': 1,
                };
                await supertest(app).post('/api/remove_favorite').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the article is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'test'
                };
                await supertest(app).post('/api/remove_favorite').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'article_id': 1
                };
                await supertest(app).post('/api/remove_favorite').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad article', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': -1
                };
                await supertest(app).post('/api/remove_favorite').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given an article that does not match the user', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': 1
                };
                await supertest(app).post('/api/remove_favorite').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given good info', () => {
            it('should return success message', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article_id': true_payload.article_id
                };
                await supertest(app).post('/api/remove_favorite').send(payload).expect(Json.STATUS_SUCCESS);
            });
        });
    });

    // Modify Starred Articles/Domains endpoints
    describe('test add starred article endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'article': '',
                };
                await supertest(app).post('/api/add_starred_article').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the article is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'test'
                };
                await supertest(app).post('/api/add_starred_article').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'article': ''
                };
                await supertest(app).post('/api/add_starred_article').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given the user is not an admin', () => {
            it('should return bad permission', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article': 'https://en.wikipedia.org/wiki/Wikimedia_Foundation'
                };
                await supertest(app).post('/api/add_starred_article').send(payload).expect(Json.STATUS_BAD_PERMISSION);
            });
        });

        describe('given good info', () => {
            it('should return success message', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'article': 'https://en.wikipedia.org/wiki/Wikimedia_Foundation'
                };
                await supertest(app).post('/api/add_starred_article').send(payload).expect(Json.STATUS_SUCCESS);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });
    });

    describe('test add starred domain endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'article': '',
                };
                await supertest(app).post('/api/add_starred_domain').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the article is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'test'
                };
                await supertest(app).post('/api/add_starred_domain').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'article': ''
                };
                await supertest(app).post('/api/add_starred_domain').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given the user is not an admin', () => {
            it('should return bad permission', async () => {
                const payload = {
                    'token': true_payload.token,
                    'article': 'https://en.wikipedia.org'
                };
                await supertest(app).post('/api/add_starred_domain').send(payload).expect(Json.STATUS_BAD_PERMISSION);
            });
        });

        describe('given good info', () => {
            it('should return success message', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'article': 'https://en.wikipedia.org'
                };
                await supertest(app).post('/api/add_starred_domain').send(payload).expect(Json.STATUS_SUCCESS);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });
    });

    // Create Team
    describe('test create team endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'team_name': '',
                };
                await supertest(app).post('/api/create_team').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the team name is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'test'
                };
                await supertest(app).post('/api/create_team').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_name': ''
                };
                await supertest(app).post('/api/create_team').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        // describe('given the user is not an admin', () => {
        //     it('should return bad permission', async () => {
        //         const payload = {
        //             'token': true_payload.token,
        //             'team_name': 'test team'
        //         };
        //         await supertest(app).post('/api/create_team').send(payload).expect(Json.STATUS_BAD_PERMISSION);
        //     });
        // });

        // describe('given good info', () => {
        //     it('should return success message', async () => {
        //         await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
        //         const payload = {
        //             'token': true_payload.token,
        //             'team_name': 'test team'
        //         };
        //         await supertest(app).post('/api/create_team').send(payload).expect(Json.STATUS_SUCCESS);
        //         await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
        //     });
        // });
    });
    
    // Info endpoints
    describe('test get user info endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/get_user_info').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad'
                };
                await supertest(app).post('/api/get_user_info').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info', () => {
            it('should return an object containing user info', async () => {
                const payload = {
                    'token': true_payload.token
                };
                const res = await supertest(app).post('/api/get_user_info').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.user_id).toEqual(true_payload.user_id);
                expect(res.body.email).toEqual(true_payload.email);
                expect(res.body.name).toEqual(true_payload.name);
                expect(res.body.phone_number).toEqual(true_payload.phone_number);
                expect(`${res.body.administrator}`).toMatch(/[true|false]/);
                expect(res.body.teams_admin).toBeInstanceOf(Array);
                expect(res.body.teams_user).toBeInstanceOf(Array);
            });
        });
    });

    describe('test get users endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/get_users').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad'
                };
                await supertest(app).post('/api/get_users').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info', () => {
            it('should return a list of users', async () => {
                const payload = {
                    'token': true_payload.token
                };
                const res = await supertest(app).post('/api/get_users').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.users).toBeInstanceOf(Array);
            });
        });
    });

    describe('test get team info endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'team_id': -1,
                };
                await supertest(app).post('/api/get_team_info').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the team id is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'bad',
                };
                await supertest(app).post('/api/get_team_info').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_id': -1
                };
                await supertest(app).post('/api/get_team_info').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given the user is not an admin', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_id': -1
                };
                await supertest(app).post('/api/get_team_info').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info', () => {
            it('should return an object containing team info', async () => {
                const teams = await Team.getTeamsFromAdministrator(true_payload.user_id);
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                for (const team of teams) {
                    true_payload.team_id = team.team_id;
                    break;
                }
                const payload = {
                    'token': true_payload.token,
                    'team_id': true_payload.team_id
                };
                const res = await supertest(app).post('/api/get_team_info').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.member_articles).toBeInstanceOf(Array);
                expect(res.body.team_articles).toBeInstanceOf(Array);
                expect(res.body.team_completed).toBeInstanceOf(Array);
                expect(res.body.completion_rate).toBeGreaterThanOrEqual(0.0);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });
    });

    // Stats-related endpoints
    describe('test get user stats endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/get_user_stats').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad'
                };
                await supertest(app).post('/api/get_user_stats').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info', () => {
            it('should return stats for user', async () => {
                const payload = {
                    'token': true_payload.token
                };
                const res = await supertest(app).post('/api/get_user_stats').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.stats.total_articles_started).toBeGreaterThanOrEqual(0);
                expect(res.body.stats.total_articles_completed).toBeGreaterThanOrEqual(0);
                expect(res.body.stats.average_articles_started).toBeGreaterThanOrEqual(0);
                expect(res.body.stats.average_articles_completed).toBeGreaterThanOrEqual(0);
            });
        });
    });

    describe('test get team stats endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'team_id':-1
                };
                await supertest(app).post('/api/get_team_stats').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the team id is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token':'bad'
                };
                await supertest(app).post('/api/get_team_stats').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_id': -1
                };
                await supertest(app).post('/api/get_team_stats').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad team_id', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token':'bad',
                    'team_id': -1
                };
                await supertest(app).post('/api/get_team_stats').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given the user is not an admin', () => {
            it('should return bad permission', async () => {
                const payload = {
                    'token': true_payload.token,
                    'team_id': true_payload.team_id
                };
                await supertest(app).post('/api/get_team_stats').send(payload).expect(Json.STATUS_BAD_PERMISSION);
            });
        });

        describe('given the user is not the team admin', () => {
            it('should return bad permission', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'team_id': 11 // permAdmin team
                };
                await supertest(app).post('/api/get_team_stats').send(payload).expect(Json.STATUS_BAD_PERMISSION);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });

        describe('given good info', () => {
            it('should return stats for all users', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'team_id': true_payload.team_id
                };
                const res = await supertest(app).post('/api/get_team_stats').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.stats.total_articles_started).toBeGreaterThanOrEqual(0);
                expect(res.body.stats.total_articles_completed).toBeGreaterThanOrEqual(0);
                expect(res.body.stats.average_articles_started).toBeGreaterThanOrEqual(0);
                expect(res.body.stats.average_articles_completed).toBeGreaterThanOrEqual(0);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });
    });

    describe('test get all stats endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/get_all_stats').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad'
                };
                await supertest(app).post('/api/get_all_stats').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given got info', () => {
            it('should return stats for all users', async () => {
                const payload = {
                    'token': true_payload.token
                };
                const res = await supertest(app).post('/api/get_all_stats').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body.stats.total_articles_started).toBeGreaterThanOrEqual(0);
                expect(res.body.stats.total_articles_completed).toBeGreaterThanOrEqual(0);
                expect(res.body.stats.average_articles_started).toBeGreaterThanOrEqual(0);
                expect(res.body.stats.average_articles_completed).toBeGreaterThanOrEqual(0);
            });
        });
    });

    // Team-related endpoints
    describe('test delete team endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'team_id':-1
                };
                await supertest(app).post('/api/delete_team').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the team id is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token':'bad'
                };
                await supertest(app).post('/api/delete_team').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_id': -1
                };
                await supertest(app).post('/api/delete_team').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad team_id', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token':'bad',
                    'team_id': -1
                };
                await supertest(app).post('/api/delete_team').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given the user is not an admin', () => {
            it('should return bad permission', async () => {
                const payload = {
                    'token': true_payload.token,
                    'team_id': true_payload.team_id
                };
                await supertest(app).post('/api/delete_team').send(payload).expect(Json.STATUS_BAD_PERMISSION);
            });
        });

        describe('given the user is not the team admin', () => {
            it('should return bad permission', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'team_id': 11 // permAdmin team
                };
                await supertest(app).post('/api/delete_team').send(payload).expect(Json.STATUS_BAD_PERMISSION);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });

        describe('given good info', () => {
            it('should return stats for all users', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const newteam = {
                    'token': true_payload.token,
                    'team_name': 'test team'
                };
                await supertest(app).post('/api/create_team').send(newteam);

                const teams = await Team.getTeamsFromAdministrator(true_payload.user_id);
                let new_id = 0;
                for (const team of teams) {
                    new_id = team.team_id;
                }

                const payload = {
                    'token': true_payload.token,
                    'team_id': new_id
                };
                await supertest(app).post('/api/delete_team').send(payload).expect(Json.STATUS_SUCCESS);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });
    });

    describe('test add team member endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'team_id':-1,
                    'member_id': -1
                };
                await supertest(app).post('/api/add_member').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the team id is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token':'bad',
                    'member_id': -1
                };
                await supertest(app).post('/api/add_member').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the member id is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token':'bad',
                    'team_id':-1
                };
                await supertest(app).post('/api/add_member').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_id': -1,
                    'member_id': -1
                };
                await supertest(app).post('/api/add_member').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad team_id', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_id': -1,
                    'member_id': -1
                };
                await supertest(app).post('/api/add_member').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad member_id', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_id': -1,
                    'member_id': -1
                };
                await supertest(app).post('/api/add_member').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given the user is not an admin', () => {
            it('should return bad permission', async () => {
                const payload = {
                    'token': true_payload.token,
                    'team_id': true_payload.team_id,
                    'member_id': 1
                };
                await supertest(app).post('/api/add_member').send(payload).expect(Json.STATUS_BAD_PERMISSION);
            });
        });

        describe('given the user is not the team admin', () => {
            it('should return bad permission', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'team_id': 11, // permAdmin team
                    'member_id': 1
                };
                await supertest(app).post('/api/add_member').send(payload).expect(Json.STATUS_BAD_PERMISSION);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });

        describe('given good info', () => {
            it('should add user to team', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'team_id': true_payload.team_id,
                    'member_id': 1
                };
                const res = await supertest(app).post('/api/add_member').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });

        describe('given member already exists', () => {
            it('should return bad info', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'team_id': true_payload.team_id,
                    'member_id': 1
                };
                await supertest(app).post('/api/add_member').send(payload).expect(Json.STATUS_BAD_INFO);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });
    });

    describe('test delete team member endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'team_id':-1,
                    'member_id': -1
                };
                await supertest(app).post('/api/delete_member').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the team id is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token':'bad',
                    'member_id': -1
                };
                await supertest(app).post('/api/delete_member').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the member id is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token':'bad',
                    'team_id':-1
                };
                await supertest(app).post('/api/delete_member').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_id': -1,
                    'member_id': -1
                };
                await supertest(app).post('/api/delete_member').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad team_id', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_id': -1,
                    'member_id': -1
                };
                await supertest(app).post('/api/delete_member').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad member_id', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'team_id': -1,
                    'member_id': -1
                };
                await supertest(app).post('/api/delete_member').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given the user is not an admin', () => {
            it('should return bad permission', async () => {
                const payload = {
                    'token': true_payload.token,
                    'team_id': true_payload.team_id,
                    'member_id': 1
                };
                await supertest(app).post('/api/delete_member').send(payload).expect(Json.STATUS_BAD_PERMISSION);
            });
        });

        describe('given the user is not the team admin', () => {
            it('should return bad permission', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'team_id': 11, // permAdmin team
                    'member_id': 1
                };
                await supertest(app).post('/api/delete_member').send(payload).expect(Json.STATUS_BAD_PERMISSION);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });

        describe('given good info', () => {
            it('should delete user from team', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'team_id': true_payload.team_id,
                    'member_id': 1
                };
                const res = await supertest(app).post('/api/delete_member').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });

        describe('given member does not exist', () => {
            it('should return bad info', async () => {
                await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
                const payload = {
                    'token': true_payload.token,
                    'team_id': true_payload.team_id,
                    'member_id': 1
                };
                await supertest(app).post('/api/delete_member').send(payload).expect(Json.STATUS_BAD_INFO);
                await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
            });
        });
    });

    // Question and Answer endpoints
    describe('test ask question endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'question_text': ''
                };
                await supertest(app).post('/api/ask_question').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the question text is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token':'bad'
                };
                await supertest(app).post('/api/ask_question').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the token is bad', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token':'bad',
                    'question_text': ''
                };
                await supertest(app).post('/api/ask_question').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        // describe('given good info', () => {
        //     it('should question is asked', async () => {
        //         const payload = {
        //             'token': true_payload.token,
        //             'question_text': 'test question'
        //         };
        //         const res = await supertest(app).post('/api/ask_question').send(payload);
        //         expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
        //     });
        // });
    });

    describe('test answer question endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'question_id':-1,
                    'answer_text': -1
                };
                await supertest(app).post('/api/answer_question').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the question id is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'bad',
                    'answer_text': -1
                };
                await supertest(app).post('/api/answer_question').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the answer text is missing', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token': 'bad',
                    'question_id': -1
                };
                await supertest(app).post('/api/answer_question').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given a bad token', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'question_id': -1,
                    'answer_text': ''
                };
                await supertest(app).post('/api/answer_question').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given a bad question_id', () => {
            it('should return bad credentials', async () => {
                const payload = {
                    'token': 'bad',
                    'question_id': -1,
                    'answer_text': ''
                };
                await supertest(app).post('/api/answer_question').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given the user is not an admin', () => {
            it('should return bad permission', async () => {
                const payload = {
                    'token': true_payload.token,
                    'question_id': true_payload.team_id,
                    'answer_text': ''
                };
                await supertest(app).post('/api/answer_question').send(payload).expect(Json.STATUS_BAD_PERMISSION);
            });
        });

        // describe('given good info', () => {
        //     it('should answer a question', async () => {
        //         await DB.query('UPDATE users SET administrator = true WHERE user_id = $1', [true_payload.user_id]);
        //         const question = await Question.getQuestionsFromId(true_payload.user_id);
        //         true_payload.question_id = question[0].question_id;
        //         const payload = {
        //             'token': true_payload.token,
        //             'question_id': true_payload.question_id,
        //             'answer_text': 'test answer'
        //         };
        //         const res = await supertest(app).post('/api/answer_question').send(payload);
        //         expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
        //         await DB.query('UPDATE users SET administrator = false WHERE user_id = $1', [true_payload.user_id]);
        //     });
        // });
    });

    describe('test get question and endpoint', () => {
        describe('given the token is missing', () => {
            it('should return bad payload', async () => {
                const payload = {};
                await supertest(app).post('/api/get_questions_answers').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
            });
        });

        describe('given the token is bad', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'token':'bad'
                };
                await supertest(app).post('/api/get_questions_answers').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
            });
        });

        describe('given good info', () => {
            it('should return a list of questions and answers', async () => {
                const payload = {
                    'token': true_payload.token
                };
                const res = await supertest(app).post('/api/get_questions_answers').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body.questions).toBeInstanceOf(Array);
            });
        });
    })
});
