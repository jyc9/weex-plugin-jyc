import Vue from 'vue';

import weex from 'weex-vue-render';

import WeexJyc from '../src/index';

weex.init(Vue);

weex.install(WeexJyc)

const App = require('./index.vue');
App.el = '#root';
new Vue(App);
