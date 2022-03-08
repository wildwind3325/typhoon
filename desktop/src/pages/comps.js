export default {
  home: () => import('./Home'),
  menu: resolve => require(['./System/Menu'], resolve)
};