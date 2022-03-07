var config = {
  secret: 'b7f8e7177c6a4222',
  db: {
    host: '127.0.0.1',
    port: 3306,
    schema: 'typhoon',
    account: 'admin',
    password: 'admin'
  }
};

if (process.env.NODE_ENV === 'PRD') {
  config.db = {
    host: '127.0.0.1',
    port: 3306,
    schema: 'typhoon',
    account: 'admin',
    password: 'admin'
  };
}

module.exports = config;