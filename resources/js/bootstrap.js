window._ = require('lodash');

try {
    require('bootstrap');
} catch (e) {}

window.axios = require('axios');
axios.defaults.withCredentials = true;

window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';