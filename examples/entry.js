import Vue from 'vue';

import weex from 'weex-vue-render';

import WeexPluginJyc from '../src/index';

weex.init(Vue);

weex.install(WeexPluginJyc)

const App = require('./index.vue');
App.el = '#root';
new Vue(App);
