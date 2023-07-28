const http = require('http');
const fs = require("fs");

const options = {
    // cert: fs.readFileSync('../gateway/certs/example.com.pem'),
    // key: fs.readFileSync('../gateway/certs/example.com-key.pem'),
    host: 'http://example.com:433/health',
    method: 'GET'
}

describe('Health of server', () => {
    test('root', () => {
        http.get('http://example.com:433/health', res => {
            expect(res.statusCode).toBe(403);
        });
    });
});
