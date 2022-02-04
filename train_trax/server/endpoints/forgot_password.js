import server from '../server.js';
import md5 from 'md5';
import nodeMailer from 'nodemailer'

const endpoint = (request, response) => {
    // Unpacking the request body object
    const { email } = request.body;
    console.log('We are currently in the forgot password API');
    
    const randomCode = md5(new Date().getTime().toString());
    console.log('Code generated: ' + randomCode);
    
    // Check if one or more fields is not declared
	const undef = [];
	if (email === undefined) undef.push('email');

    // If undeclared field, return error
	if (undef.length > 0) {
		return response.status(200).json({
			'error': 'Invalid payload',
			'message': 'Missing the following field(s): ' + undef.join(', ')
		});
	}

    // Check if a user with the given email exists
	server.query('SELECT * FROM users WHERE email = $1;', [email], (error, res) => {
		if (error) throw error;
		if (res.rows.length === 0) return response.status(200).json({
			'error': 'Duplicate email',
			'message': 'A user with the given email already exists'
		});

        const data = res.rows[0];

        // TODO: Insert validation code into database
		server.query('UPDATE users SET validation_token = $2, validation_expire_time = $3 WHERE user_id = $1;', [data.user_id, randomCode, new Date().toISOString()], (error, res) => {
			if(error) throw error;
		});

		// If a user does exist, send the code email
		var transporter = nodeMailer.createTransport({
            service: 'gmail',
            secure: true,
            auth: {
                user: process.env.GMAIL_USERNAME,
                pass: process.env.GMAIL_PASSWORD
            }
        });
        var mailOPtions = {
            from: 'traintraxexperience@gmail.com',
            to: email,
            subject: 'Password Reset for Train Trax',
            text: 'Hello ' + data.name + ', \nPlease enter the following code into the web page to reset your password. \nThis is your code : ' 
                + randomCode + ' \n If you did not wish to reset your password for TriviaCrevice you should reset your password from within your account.'
        }
        transporter.sendMail(mailOPtions, function (err, info) {
            if (err) {
                return response.status(200).json({
                    'error': 'Failed to Send Email',
                    'message': 'The email was not sent.'
                });
            }
            return response.status(200).json({
                'error': '',
                'message': 'Success.'
            });
        });
	});
};

export default endpoint;