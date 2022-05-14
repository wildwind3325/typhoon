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

log4js.configure('./src/log4js.json');
if (!process.env.NODE_ENV) {
  app.use(log4js.connectLogger(log4js.getLogger(), { level: 'info' }));
} else {
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
    code: 1,
    msg: err.message
  });
});

process.on('unhandledRejection', (error, promise) => {
  console.error('unhandledRejection', error);
});

process.on('uncaughtException', (error, origin) => {
  console.error('unhandledRejection', error);
});

module.exports = app;