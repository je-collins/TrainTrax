import supertest from 'supertest';
import { app } from '../../server/app.js';
import { Json } from '../../server/objects/Objects.js';

const true_payload = {}

describe('Train Trax API', () => {
    describe('check .env', () => {
        it('should not be undefined', () => {
            expect(process.env.DATABASE_URL).not.toBe(undefined);
        });
    });

    describe('test register endpoint', () => {

    });

    describe('test login user endpoint', () => {
        describe('given the user does not exists', () => {
            it('should return a 404', async () => {
                const payload = {
                    'email': 'fake@email.com',
                    'password': 'badPassword'
                };
                await supertest(app).post('/api/login').send(payload).expect(Json.STATUS_BAD_CREDENTIALS)
            });
        });


    });
  });
