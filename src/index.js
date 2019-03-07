/* globals alert */
const weexPluginJyc = {
  show () {
    alert('Module weexPluginJyc is created sucessfully ');
  }
};

const meta = {
  weexPluginJyc: [{
    lowerCamelCaseName: 'show',
    args: []
  }]
};

function init (weex) {
  weex.registerModule('weexPluginJyc', weexPluginJyc, meta);
}

export default {
  init: init
};
