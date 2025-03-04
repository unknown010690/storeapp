const test_stores_logic = require('./code/test-stores-logic');
const cds = require('@sap/cds/lib');
const {
  GET,
  POST,
  PATCH,
  DELETE,
  expect
} = cds.test(__dirname + '../../', '--with-mocks');
cds.env.requires.auth = {
  kind: "dummy"
};
describe('Service Testing', () => {
  it('test stores-logic', async () => {
    await test_stores_logic(GET, POST, PATCH, DELETE, expect);
  });
});