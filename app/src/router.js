var fs = require('fs');
var path = require('path');
var expressJwt = require('express-jwt');

var config = require('./config');

var addRoutes = (app, root, dir) => {
  let list = fs.readdirSync(dir, { withFileTypes: true });
  for (let i = 0; i < list.length; i++) {
    if (list[i].isFile() && list[i].name.toLowerCase().endsWith('.js')) {
      let file = path.join(dir, list[i].name);
      file = file.substr(root.length + 1, file.length - root.length - 4).split(path.sep).join('/');
      app.use('/api/' + file, require('./routes/' + file));
    } else if (list[i].isDirectory()) {
      addRoutes(app, root, path.join(dir, list[i].name));
    }
  }
};

var router = app => {
  app.use(expressJwt({
    secret: config.secret,
    algorithms: ['HS256'],
    getToken: function fromHeaderOrQuerystring(req) {
      return req.cookies.token;
    },
    isRevoked: function (req, user, done) {
      done(null, false);
    }
  }).unless({
    path: [/^\/api\/common\/.+$/]
  }));

  app.all('/*', async (req, res, next) => {
    if (/^\/api\/common\/.+$/.test(req.url)) {
      next();
      return;
    }
    console.log(req.user);
    next();
  });

  let root = path.join(__dirname, 'routes');
  addRoutes(app, root, root);
};

module.exports = router;