import Vue from 'vue';
import App from './App';
import VueI18n from 'vue-i18n';
import router from './router';
import axios from 'axios';
import './api/enhance';
import ViewUI from 'view-design';
import en from 'view-design/dist/locale/en-US';
import zh from 'view-design/dist/locale/zh-CN';
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
Vue.prototype.$http = axios;
Vue.use(VueI18n);
Vue.use(ViewUI);
Vue.locale = () => { };

let i18n = new VueI18n({
  locale: 'zh',
  messages: {
    en: Object.assign({ message: 'hello' }, en),
    zh: Object.assign({ message: '你好' }, zh)
  }
});

new Vue({
  router,
  i18n,
  render: h => h(App)
}).$mount('#app');