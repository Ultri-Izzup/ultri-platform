const http = require('https');
const fs = require("fs");

const options = {
    // cert: fs.readFileSync('../gateway/certs/example.com.pem'),
    // key: fs.readFileSync('../gateway/certs/example.com-key.pem'),
    host: 'https://example.com/health',
    method: 'GET'
}

describe('Health of server', () => {
    test('root', () => {
        http.get('https://example.com/health', res => {
            expect(res.statusCode).toBe(200);
        });
    });
});
