<template>
    <div>
        <div class="container">
            <div class="py-5">
                <div class="row">
                    <div class="col-6 offset-3">
                        <div class="card card-default">
                            <div class="card-header">
                                Login
                            </div>
                            <div class="card-body">
                                <form action="" method="post" @submit.prevent="login()">
                                    <div class="form-group">
                                        <label for="">Email</label>
                                        <input type="text" v-model="loginForm.email" class="form-control mb-3" name="email" placeholder="email" :class="{ 'is-invalid': loginForm.errors.has('email') }">
                                        <has-error :form="loginForm" field="email" class="mb-3"></has-error>
                                    </div>
                                    <div class="form-group">
                                        <label for="">Password</label>
                                        <input type="password" v-model="loginForm.password" class="form-control mb-3" name="password" placeholder="password" :class="{ 'is-invalid': loginForm.errors.has('password') }" >  
                                        <has-error :form="loginForm" field="password" class="mb-3"></has-error>                                       
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" :disabled="loginForm.busy" class="btn btn-success px-4">Login</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { Form } from 'vform'
export default {
    data(){
        return {
            loginForm: new Form({
                email: 'rahim3070@gmail.com',
                password: '12345678',
            }),
        }
    },
    methods: {
        async login(){
            await axios.get('/sanctum/csrf-cookie')
            await this.loginForm.post('/login')
            await this.getUserData();
            Toast.fire({
                icon: 'success',
                title: 'You are successfully logged in.'
            });
            
            this.$router.push({ name: 'dashboard' });
        },
        async getUserData(){
            await axios.get('/api/user').then(response => {
                let user = response.data;
                this.$store.commit('SET_USER', user);
                this.$store.commit('SET_AUTHENTICATED', true);
                localStorage.setItem("auth", true);
            });
        }
    },
    mounted(){ 
        
    }
}
</script>