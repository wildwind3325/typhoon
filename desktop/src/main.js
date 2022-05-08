import Vue from 'vue';
import App from './App';
import VueI18n from 'vue-i18n';
import router from './router';
import axios from 'axios';
import './util/enhance';
import ViewUI from 'view-design';
import en from './i18n/en';
import zh from './i18n/zh';
import ViewUIEn from 'view-design/dist/locale/en-US';
import ViewUIZh from 'view-design/dist/locale/zh-CN';
import VueCustomScrollbar from 'vue-custom-scrollbar';
import 'view-design/dist/styles/iview.css';
import 'vue-custom-scrollbar/dist/vueScrollbar.css';
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
  if (!response.data.success && response.data.redirect) {
    localStorage.setItem('target_uri', router.currentRoute.fullPath);
    router.replace('/');
  }
  return response;
}, function (error) {
  ViewUI.Spin.hide();
  return Promise.reject(error);
});

Vue.config.productionTip = false;
Vue.prototype.$http = axios;
Vue.use(VueI18n);
Vue.use(ViewUI, { i18n: (key, value) => i18n.t(key, value) });
Vue.component('vue-custom-scrollbar', VueCustomScrollbar);

let i18n = new VueI18n({
  locale: 'zh',
  messages: {
    en: Object.assign(en, ViewUIEn),
    zh: Object.assign(zh, ViewUIZh)
  }
});

new Vue({
  router,
  i18n,
  render: h => h(App)
}).$mount('#app');