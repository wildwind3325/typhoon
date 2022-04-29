var express = require('express');

var config = require('../config');
var DB = require('../data/db');
var util = require('../api/util');

var router = express.Router();

router.post('/login', async function (req, res, next) {
  try {
    let account = req.body.account;
    let password = req.body.password;
    if (!account || !password) {
      res.send({
        success: false,
        message: '请输入账号和密码'
      });
      return;
    }
    let db = new DB();
    let rows = await db.find('select * from `base_user` where `status` = 0 and `account` = :account and `password` = :password', {
      account: account,
      password: util.md5(password)
    });
    if (rows.length === 0) {
      res.send({
        success: false,
        message: '错误的用户名或密码'
      });
    } else {
      req.session.user = rows[0];
      res.send({ success: true });
    }
  } catch (err) {
    res.send({
      success: false,
      message: err.message
    });
  }
});

router.post('/logout', function (req, res, next) {
  req.session.destroy(err => { });
  res.clearCookie(config.cookie_name);
  res.send({ success: true });
});

router.post('/status', function (req, res, next) {
  if (req.session.user) {
    res.send({ success: true });
  } else {
    res.send({ success: false });
  }
});

module.exports = router;