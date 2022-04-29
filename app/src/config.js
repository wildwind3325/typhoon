var config = {
  secret: 'b7f8e7177c6a4222',
  cookie_name: 'sid.typhoon',
  db: {
    host: '127.0.0.1',
    port: 3306,
    schema: 'typhoon',
    account: 'admin',
    password: 'admin'
  },
  copyright: 'TEAM 5'
};

if (process.env.NODE_ENV === 'PRD') {
}

module.exports = config;