const expect  = require('chai').expect;
const message = require('../utils');
const http = require('http');


it('Main page content', function (done) {
    const options = {
        host: 'localhost',
        path: '/',
        port: '80'
    };
    const request = http.request(options, (response) => {
        let str = ''
        response.on('data', function (chunk) {
            str += chunk;
        });

        response.on('end', function () {
            console.log(str);
            expect(str).to.equal(message.getWelcomeMessage());
            done();
        });
    });
    request.end();
});