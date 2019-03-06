/* globals alert */
const weexJyc = {
  show () {
    alert('Module weexJyc is created sucessfully ');
  }
};

const meta = {
  weexJyc: [{
    lowerCamelCaseName: 'show',
    args: []
  }]
};

function init (weex) {
  weex.registerModule('weexJyc', weexJyc, meta);
}

export default {
  init: init
};
