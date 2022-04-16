import { listen } from 'express/lib/application';
import supertest from 'supertest';
import { app } from '../../server/app.js';
import { Json, User } from '../../server/objects/Objects.js';

const true_payload = {
    'email': 'test@gmail.com',
    'password': 'Password',
    'name': 'Tester',
    'phone_number': '0123456789'
}

describe('Train Trax API', () => {
    describe('check .env', () => {
        it('should not be undefined', () => {
            expect(process.env.DATABASE_URL).not.toBe(undefined);
        });
    });

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

    // TODO: Add add_article

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
                console.log(true_payload.token)
                const res = await supertest(app).post('/api/get_articles').send(payload);
                expect(res.statusCode).toBe(Json.STATUS_SUCCESS);
                expect(res.body).toBeDefined();
                expect(res.body).toBeInstanceOf(Array);
            });
        });
    });
});
