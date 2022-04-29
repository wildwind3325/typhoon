var fs = require('fs');
var path = require('path');

var config = require('./config');

var addRoutes = (app, root, dir) => {
  let list = fs.readdirSync(dir, { withFileTypes: true });
  for (let i = 0; i < list.length; i++) {
    if (list[i].isFile() && list[i].name.toLowerCase().endsWith('.js')) {
      let file = path.join(dir, list[i].name);
      file = file.substring(root.length + 1, file.lastIndexOf('.js')).split(path.sep).join('/');
      app.use('/api/' + file, require('./routes/' + file));
    } else if (list[i].isDirectory()) {
      addRoutes(app, root, path.join(dir, list[i].name));
    }
  }
};

var router = app => {
  let safeRoutes = /^\/api\/common\/.+$/;
  app.all('/api/*', (req, res, next) => {
    res.setHeader('X-Powered-By', config.copyright);
    if (!safeRoutes.test(req.url) && !req.session.user) {
      res.send({
        success: false,
        redirect: true,
        message: '尚未登录或登录已超时'
      });
    } else {
      next();
    }
  });

  let root = path.join(__dirname, 'routes');
  addRoutes(app, root, root);
};

module.exports = router;