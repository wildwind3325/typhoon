import Vue from 'vue';
import VueRouter from 'vue-router';
import Login from './pages/Login';
import Master from './pages/Master';
import NotFound from './pages/NotFound';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'hash',
  routes: [{
    path: '/',
    component: Login
  }, {
    path: '/home',
    component: Master
  }, {
    path: '*',
    component: NotFound
  }]
});

export default router;