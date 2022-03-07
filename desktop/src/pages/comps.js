export default {
  home: () => import('./Home'),
  c1: resolve => require(['./C1'], resolve),
  c2: resolve => require(['./C2'], resolve)
};