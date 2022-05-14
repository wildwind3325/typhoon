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
        code: 1,
        msg: '请输入账号和密码'
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
        code: 1,
        msg: '错误的用户名或密码'
      });
    } else {
      req.session.user = rows[0];
      res.send({ code: 0 });
    }
  } catch (err) {
    res.send({
      code: 1,
      msg: err.message
    });
  }
});

router.post('/logout', function (req, res, next) {
  req.session.destroy(err => { });
  res.clearCookie(config.cookie_name);
  res.send({ code: 0 });
});

router.post('/status', function (req, res, next) {
  if (req.session.user) {
    res.send({ code: 0 });
  } else {
    res.send({ code: -1 });
  }
});

module.exports = router;