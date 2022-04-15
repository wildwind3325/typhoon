var express = require('express');

var DB = require('../../data/db');

var router = express.Router();

router.post('/list', async function (req, res, next) {
  try {
    let db = new DB();
    let modules = await db.find('select * from `base_auth` where `type` = 0 order by `order`');
    let pages = await db.find('select * from `base_auth` where `type` = 1 order by `order` desc');
    let funcs = await db.find('select * from `base_auth` where `type` = 2 order by `order` desc');
    for (let i = 0; i < modules.length; i++) {
      let module = modules[i];
      module.children = [];
      for (let j = pages.length - 1; j >= 0; j--) {
        let page = pages[j];
        if (page.parent_id !== module.id) continue;
        page.children = [];
        for (let k = funcs.length - 1; k >= 0; k--) {
          let func = funcs[k];
          if (func.parent_id !== page.id) continue;
          page.children.push(func);
          funcs.splice(k, 1);
        }
        module.children.push(page);
        pages.splice(j, 1);
      }
    }
    res.send({
      success: true,
      data: modules
    });
  } catch (err) {
    res.send({
      success: false,
      message: err.message
    });
  }
});

router.post('/create', async function (req, res, next) {
  try {
    let db = new DB();
    let item = Object.assign({
      created_by: req.user.account,
      updated_by: req.user.account
    }, req.body);
    await db.insert('base_auth', item);
    res.send({
      success: true,
      data: item
    });
  } catch (err) {
    res.send({
      success: false,
      message: err.message
    });
  }
});

router.post('/edit', async function (req, res, next) {
  try {
    let db = new DB();
    await db.update('base_auth', Object.assign({ updated_by: req.user.account }, req.body));
    res.send({ success: true });
  } catch (err) {
    res.send({
      success: false,
      message: err.message
    });
  }
});

router.post('/delete', async function (req, res, next) {
  try {
    let db = new DB();
    let count = await db.find('select count(*) total from `base_auth` where `parent_id` = :id', {
      id: req.body.id
    });
    if (count[0].total > 0) {
      res.send({
        success: false,
        message: '该项目存在子集，不能删除。'
      });
      return;
    }
    await db.delete('base_auth', { id: req.body.id });
    res.send({ success: true });
  } catch (err) {
    res.send({
      success: false,
      message: err.message
    });
  }
});

module.exports = router;