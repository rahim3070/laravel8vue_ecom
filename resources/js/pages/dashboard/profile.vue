<template>
  <div class="container mt-5">
      <div class="row">
          <div class="col-4">
            <div class="list-group">
                <router-link :to="{ name: 'dashboard' }" class="list-group-item list-group-item-action">Dashboard</router-link>
                <router-link :to="{ name: 'user-profile' }" class="list-group-item list-group-item-action">User Profile</router-link>
                <a href="#" class="list-group-item list-group-item-action" @click.prevent="logout">Logout</a>
            </div>
          </div>
          <div class="col-8">
              <div class="card">
                    <div class="card-header">
                        User Profile
                    </div>
                    <div class="card-body">
                        <form @submit.prevent="updateUserProfile()">
                            <div class="row">
                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="">Your Name</label>
                                        <input type="text" class="form-control mb-3" placeholder="Your name" v-model="userProfile.name" :class="{ 'is-invalid': userProfile.errors.has('name') }">
                                        <has-error :form="userProfile" field="name" class="mb-3"></has-error>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="">Your Email</label>
                                        <input type="text" class="form-control mb-3" placeholder="Your email"  v-model="userProfile.email" :class="{ 'is-invalid': userProfile.errors.has('email') }">
                                        <has-error :form="userProfile" field="email" class="mb-3"></has-error>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="">Your Password</label>
                                        <input type="password" class="form-control mb-3" placeholder="Your password" v-model="userProfile.password" :class="{ 'is-invalid': userProfile.errors.has('password') }">
                                        <has-error :form="userProfile" field="password" class="mb-3"></has-error>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="">Confirm Password</label>
                                        <input type="password" class="form-control mb-3" placeholder="Confirm password" v-model="userProfile.password_confirmation" :class="{ 'is-invalid': userProfile.errors.has('password_confirmation') }">
                                        <has-error :form="userProfile" field="password_confirmation" class="mb-3"></has-error>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-success">Save Profile</button>
                        </form>
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
            userProfile: new Form({
                name: '',
                email: '',
                password: '',
                password_confirmation: '',
            }),
        }
    },
    methods: {
        user() {
            let user = this.$store.getters.getUser;
            this.userProfile.name = user.name;
            this.userProfile.email = user.email;
        },
        updateUserProfile(){
            this.userProfile.post('/api/user').then(response => {
                // user update on vuex store
                this.$store.commit('SET_USER', response.data);
                Toast.fire({
                    icon: 'success',
                    title: 'Profile updated successfully.'
                });
            });
        },
        logout() {
            axios.post('/logout').then(response => {
                Toast.fire({
                    icon: 'success',
                    title: 'Logged out Successfully.'
                });

                localStorage.removeItem("auth");
                this.$store.commit('SET_AUTHENTICATED', false);
                this.$router.push({ name: 'login' });
            });
        }
    },
    created(){
        this.user();
    },
    computed: {
        auth() {
            return this.$store.getters.getUser;
        }
    }
}
</script>
