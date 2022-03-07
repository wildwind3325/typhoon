var Sequelize = require('sequelize');

var config = require('../config');

class CM {
  constructor() {
    this.conns = {};
    this.conns['default'] = new Sequelize(config.db.schema, config.db.account, config.db.password, {
      host: config.db.host,
      port: config.db.port,
      dialect: 'mysql',
      timezone: '+08:00',
      logging: false,
      define: {
        charset: 'utf8'
      },
      pool: {
        max: 50,
        min: 0,
        acquire: 30000,
        idle: 10000
      }
    });
  }

  set(name, conn) {
    this.conns[name] = conn;
  }

  exist(name) {
    if (this.conns[name]) return true;
    return false;
  }

  get(name) {
    return this.conns[name || 'default'];
  }
}

module.exports = new CM();