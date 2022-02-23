var express = require('express');
var jwt = require('jsonwebtoken');

var config = require('../config');

var router = express.Router();

router.post('/login', function (req, res, next) {
  let token = jwt.sign({
    account: 'admin',
    email: 'admin@company.com'
  }, config.secret, { expiresIn: '24h' });
  res.cookie('token', token, {
    httpOnly: true,
    maxAge: 1000 * 3600 * 24
  });
  res.send({
    success: true
  });
});

module.exports = router;