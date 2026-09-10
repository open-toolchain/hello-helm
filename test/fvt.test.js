const message = require('../utils');
const axios = require("axios");

var PORT;
if (process.env.PORT) {
  PORT = process.env.PORT;
} else {
  PORT = 80;
}
const testurl = `http://localhost:${PORT}`
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