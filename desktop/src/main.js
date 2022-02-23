import Vue from 'vue';
import App from './App';
import router from './router';
import axios from 'axios';
import './api/enhance';
import ViewUI from 'view-design';
import 'view-design/dist/styles/iview.css';
import './main.css';

axios.interceptors.request.use(function (config) {
  ViewUI.Spin.show();
  return config;
}, function (error) {
  ViewUI.Spin.hide();
  return Promise.reject(error);
});

axios.interceptors.response.use(function (response) {
  ViewUI.Spin.hide();
  return response;
}, function (error) {
  ViewUI.Spin.hide();
  if (error.response && error.response.status === 401) {
    localStorage.setItem('target_uri', router.currentRoute.path);
    router.replace('/');
    return error.response;
  }
  return Promise.reject(error);
});

Vue.config.productionTip = false;
Vue.use(ViewUI);
Vue.prototype.$http = axios;

new Vue({
  router,
  render: h => h(App)
}).$mount('#app');