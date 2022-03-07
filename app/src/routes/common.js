var express = require('express');
var jwt = require('jsonwebtoken');

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
      return;
    }
    let token = jwt.sign({
      in: rows[0].id,
      account: rows[0].account,
      code: rows[0].code,
      name: rows[0].name,
      gender: rows[0].gender,
      email: rows[0].email,
      mobile: rows[0].mobile
    }, config.secret, { expiresIn: '24h' });
    res.cookie('token', token, {
      maxAge: 1000 * 3600 * 24
    });
    res.send({
      success: true
    });
  } catch (err) {
    res.send({
      success: false,
      message: err.message
    });
  }
});

module.exports = router;