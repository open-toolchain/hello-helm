const message = require('../utils');
const axios = require("axios");

const testurl = "http://localhost:80"
describe('Test', () => {
    it('Check application URL', async () => {
        const result = await axios.get(`${testurl}`, {});
        expect(result.status).toEqual(200);
    });
    it('Check application response data', async () => {
        const result = await axios.get(`${testurl}`, {});
        expect(result.data).toEqual(message.getWelcomeMessage());
    });
});