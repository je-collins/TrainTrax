import supertest from 'supertest';
import { app } from '../../server/app.js';
import { Json, User } from '../../server/objects/Objects.js';

const true_payload = {
    'email': 'test@gmail.com',
    'password': 'testPassword',
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

        // describe('given existing email', () => {
        //     it('should return bad info', async () => {
        //         const payload = {
        //             'email': true_payload.email,
        //             'password': true_payload.password,
        //             'name': true_payload.name,
        //             'phone_number': true_payload.phone_number
        //         };
        //         await supertest(app).post('/api/register').send(payload).expect(Json.STATUS_BAD_INFO);
        //     });
        // });
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

        // TODO: Change payload
        describe('given good info', () => {
            it('should return bad payload', async () => {
                const payload = {
                    'email': 'jojoTest@gmail.com',
                    'password': 'password'
                };
                const res = await supertest(app).post('/api/login').send(payload);
                true_payload['token'] = res.body.token;
                expect(res.body.token).toBeDefined();
                expect(res.body.token.length).toBeGreaterThanOrEqual(32);
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
                    'email': 'jojoTest@gmail.com'
                };
                await supertest(app).post('/api/forgot_password').send(payload).expect(Json.STATUS_SUCCESS);
                true_payload['validation_token'] = await User.fromEmail(payload.email)
                console.log(true_payload.validation_token)
            });
        });
    });

    // describe('test reset password endpoint', () => {
    //     describe('given the email is not provided', () => {
    //         it('should return bad payload', async () => {
    //             const payload = {};
    //             await supertest(app).post('/api/forgot_password').send(payload).expect(Json.STATUS_BAD_PAYLOAD);
    //         });
    //     });

    //     describe('given the email does not exist', () => {
    //         it('should return bad credetials', async () => {
    //             const payload = {
    //                 'email':'bademail'
    //             };
    //             await supertest(app).post('/api/forgot_password').send(payload).expect(Json.STATUS_BAD_CREDENTIALS);
    //         });
    //     });

    //     describe('given good info', () => {
    //         it('should return success', async () => {
    //             const payload = {
    //                 'email': 'jojoTest@gmail.com'
    //             };
    //             await supertest(app).post('/api/forgot_password').send(payload).expect(Json.STATUS_SUCCESS);
    //         });
    //     });
    // });
  });
