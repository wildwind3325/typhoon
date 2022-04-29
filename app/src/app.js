var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var session = require('express-session');
var log4js = require('log4js');
require('./api/enhance');

var config = require('./config');
var router = require('./router');

var app = express();
app.disable('x-powered-by');

if (!process.env.NODE_ENV) {
  log4js.configure({
    appenders: {
      all: { type: 'stdout' }
    },
    categories: {
      default: { appenders: ['all'], level: 'info' }
    }
  });
  app.use(log4js.connectLogger(log4js.getLogger(), { level: 'info' }));
} else {
  log4js.configure({
    appenders: {
      access: {
        type: 'dateFile',
        filename: path.join(__dirname, '../logs/access.log'),
        pattern: '-yyyy-MM-dd',
        category: 'access',
        keepFileExt: true
      },
      info: {
        type: 'dateFile',
        filename: path.join(__dirname, '../logs/info.log'),
        pattern: '-yyyy-MM-dd',
        category: 'info',
        keepFileExt: true
      },
      info_filter: {
        type: 'logLevelFilter',
        level: 'info',
        appender: 'info'
      },
      error: {
        type: 'dateFile',
        filename: path.join(__dirname, '../logs/error.log'),
        pattern: '-yyyy-MM-dd',
        category: 'error',
        keepFileExt: true
      },
      error_filter: {
        type: 'logLevelFilter',
        level: 'error',
        appender: 'error'
      },
    },
    categories: {
      default: { appenders: ['info_filter', 'error_filter'], level: 'info' },
      access: { appenders: ['access'], level: 'info' }
    }
  });
  app.use(log4js.connectLogger(log4js.getLogger('access'), { level: 'info' }));
}

app.use(express.json({ limit: '100mb' }));
app.use(express.urlencoded({ limit: '100mb', extended: false }));
app.use(cookieParser());
app.use(session({
  name: config.cookie_name,
  secret: config.secret,
  resave: false,
  rolling: true,
  saveUninitialized: false,
  cookie: {
    maxAge: 1000 * 3600 * 24
  }
}));
app.use(express.static(path.join(__dirname, '../public')));
router(app);
app.use(function (req, res, next) {
  res.status(404).end();
});
app.use(function (err, req, res, next) {
  res.status(err.status || 500).send({
    success: false,
    message: err.message
  });
});

process.on('unhandledRejection', (error, promise) => {
  console.error('unhandledRejection', error);
});

process.on('uncaughtException', (error, origin) => {
  console.error('unhandledRejection', error);
});

module.exports = app;