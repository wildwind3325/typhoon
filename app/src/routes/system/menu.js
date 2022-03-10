var express = require('express');

var DB = require('../../data/db');

var router = express.Router();

router.post('/module/create', async function (req, res, next) {
  try {
    let db = new DB();
    let row = {
      name: req.body.name || '',
      code: req.body.code || '',
      order: req.body.order || 1,
      icon: req.body.icon || '',
      created_by: req.user.account,
      updated_by: req.user.account
    };
    await db.insert('base_auth_module', row);
    res.send({
      success: true,
      row: row
    });
  } catch (err) {
    res.send({
      success: false,
      exception: err.message
    });
  }
});

router.post('/module/edit', async function (req, res, next) {
  try {
    let db = new DB();
    let row = Object.assign({
      created_by: req.user.account,
      updated_by: req.user.account
    }, req.body);
    if (row.code) delete row.code;
    await db.update('base_auth_module', row);
    res.send({ success: true });
  } catch (err) {
    res.send({
      success: false,
      exception: err.message
    });
  }
});

router.post('/module/delete', async function (req, res, next) {
  try {
    let db = new DB();
    let count = await db.find('select count(*) total from `base_auth_page` where `module_id` = :module_id', {
      module_id: req.body.id
    });
    if (count[0].total > 0) {
      res.send({
        success: false,
        message: '该模块不为空'
      });
      return;
    }
    await db.delete('base_auth_module', { id: req.body.id });
    res.send({ success: true });
  } catch (err) {
    res.send({
      success: false,
      exception: err.message
    });
  }
});

module.exports = router;