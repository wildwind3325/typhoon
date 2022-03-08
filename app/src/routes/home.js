var express = require('express');

var router = express.Router();

router.post('/status', function (req, res, next) {
  res.send({ success: true });
});

module.exports = router;