import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import Home from '../pages/home.vue'

import CategoryList from '../pages/category/index.vue'
import CreateCategory from '../pages/category/create.vue'
import EditCategory from '../pages/category/edit.vue'

import ProductList from '../pages/product/index.vue'
import CreateProduct from '../pages/product/create.vue'
import EditProduct from '../pages/product/edit.vue'

import ProductDetails from '../pages/productDetails.vue'
import CartList from '../pages/cart/index.vue'
import OrderList from '../pages/order/index.vue'
import EditOrder from '../pages/order/edit.vue'

// Dashboard Component
import Dashboard from '../pages/dashboard/index.vue'
import UserProfile from '../pages/dashboard/profile.vue'

// Authentication File
import Login from '../pages/auth/login.vue'
import Signup from '../pages/auth/signup.vue'

const routes = new VueRouter({
    mode: 'history',
    linkExactActiveClass: 'active',
    routes: [
        {
            path: '/',
            component: Home,
            name: 'home',
        },
        {
            path: '/category',
            component: CategoryList,
            name: 'category-list',
        },
        {
            path: '/category/create',
            component: CreateCategory,
            name: 'create-category',
        },
        {
            path: '/category/edit/:id',
            component: EditCategory,
            name: 'edit-category',
        },
        {
            path: '/product',
            component: ProductList,
            name: 'product-list',
        },
        {
            path: '/product/create',
            component: CreateProduct,
            name: 'create-product',
        },
        {
            path: '/product/edit/:id',
            component: EditProduct,
            name: 'edit-product',
        },
        {
            path: '/auth/login',
            component: Login,
            name: 'login',
            meta: {
                requiresVisitor: true,
            }
        },
        {
            path: '/auth/signup',
            component: Signup,
            name: 'signup',
            meta: {
                requiresVisitor: true,
            }
        },
        {
            path: '/dashboard',
            component: Dashboard,
            name: 'dashboard',
            meta: {
                requiresAuth: true,
            }
        },
        {
            path: '/dashboard/profile',
            component: UserProfile,
            name: 'user-profile',
            meta: {
                requiresAuth: true,
            }
        },
        {
            path: '/product/:slug',
            component: ProductDetails,
            name: 'product-details',
        },
        {
            path: '/cartProductList',
            component: CartList,
            name: 'cart-list',
        },
        {
            path: '/order',
            component: OrderList,
            name: 'order-list',
        },
        {
            path: '/order/edit/:id',
            component: EditOrder,
            name: 'edit-order',
        }
    ]
});

export default routes;