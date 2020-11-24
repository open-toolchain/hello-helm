const expect  = require('chai').expect;
const request = require('request');
const message = require('../utils');


it('Main page content', function(done) {
    request('http://localhost:80' , function(error, response, body) {
        expect(body).to.equal(message.getWelcomeMessage());
        done();
    });
});