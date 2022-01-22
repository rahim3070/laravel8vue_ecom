require('./bootstrap');
import Vue from 'vue';
import routes from './router/index';
import {
    Button,
    HasError,
    AlertError,
    AlertErrors,
    AlertSuccess
} from 'vform/src/components/bootstrap5';

import store from './store/index';

// sweetalert2
import Swal from 'sweetalert2';
window.Swal = Swal;
const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 2000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
    }
})
window.Toast = Toast;

Vue.component(Button.name, Button)
Vue.component(HasError.name, HasError)
Vue.component(AlertError.name, AlertError)
Vue.component(AlertErrors.name, AlertErrors)
Vue.component(AlertSuccess.name, AlertSuccess)

Vue.component('app-header', require('./components/Header.vue').default);

// Vue Router Nagivation Guard
function isLoggedIn() {
    return store.getters.getAuthenticated;
}

routes.beforeEach((to, from, next) => {
    if (to.matched.some(record => record.meta.requiresAuth)) {
        // this route requires auth, check if logged in
        // if not, redirect to login page.
        if (!isLoggedIn()) {
            next({
                name: 'login',
            })
        } else {
            next()
        }
    } else if (to.matched.some(record => record.meta.requiresVisitor)) {
        // this route requires auth, check if logged in
        // if not, redirect to login page.
        if (isLoggedIn()) {
            next({
                name: 'dashboard',
            })
        } else {
            next()
        }
    } else {
        next() // make sure to always call next()!
    }
})

// check authentication
let auth = localStorage.getItem("auth");

if (auth) {
    store.dispatch('authUser').then(() => {
        const app = new Vue({
            el: '#app',
            router: routes,
            store,
        });
    });
} else {
    const app = new Vue({
        el: '#app',
        router: routes,
        store,
    });
}
