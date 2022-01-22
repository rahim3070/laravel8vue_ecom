<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Order List</h5>
                    </div>

                    <div class="card-body">
                        <div class="mb-3">
                            <div class="row">
                                <div class="col-md-12">
                                    <input v-model="querySearch" type="text" class="form-control" placeholder="Search by Order ID">
                                </div>
                            </div>
                        </div>

                        <table class="table">
                            <thead>
                                <tr>
                                    <th style="width: 100px"> Id </th>
                                    <th> Order ID </th>
                                    <th> Total </th>
                                    <th> Payment Type </th>
                                    <th> Status </th>
                                    <th style="width: 170px" v-if="user.is_admin == 1"> Action </th>
                                </tr>
                            </thead>
                            <tbody v-if="orders.length">
                                <tr v-for="order in orders" :key="order.id">
                                    <td style="width: 100px"> {{ order.id }} </td>
                                    <td> {{ order.order_id }} </td>
                                    <td> {{ order.total }} </td>
                                    <td> {{ order.payment_type }} </td>
                                    <div v-if="order.status == 0">
                                        <td>Pending</td>
                                    </div>
                                    <div v-else-if="order.status == 1">
                                        <td>Recieved</td>
                                    </div>
                                    <div v-else-if="order.status == 2">
                                        <td>Shipped</td>
                                    </div>
                                    <div v-else-if="order.status == 3">
                                        <td>Completed</td>
                                    </div>
                                    <div v-else-if="order.status == 4">
                                        <td>Return</td>
                                    </div>
                                    <div v-else-if="order.status == 5">
                                        <td>Reject</td>
                                    </div>
                                    <td style="width: 170px" v-if="user.is_admin == 1">
                                        <router-link :to="{name: 'edit-order', params: {id: order.id}}" class="btn btn-primary btn-sm">Edit</router-link>
                                    </td>
                                </tr>
                            </tbody>
                            <tbody v-else>
                                <tr>
                                    <td colspan="4">
                                        <h5 class="text-center mt-4 mb-4">No order found.</h5>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data(){
        return {
            querySearch: "",
            orders: [],
        }
    },
    watch: {
        querySearch: function(newQ, old) {
          if (newQ === "") {
            this.loadOrders();
          } else {
            this.searchData();
          }
        }
    },
    methods: {
        async loadOrders(){
            await axios.get('/api/order').then(response => {
                this.orders = response.data;
            });
        },
        async searchData() {
            await axios.get(`/api/search/orders/${this.querySearch}`)
              .then(response => {
                this.orders = response.data;
              })
              .catch(e => {
                console.log(e);
              });
        },
    },
    computed: {
        user() {
            return this.$store.getters.getUser;
        }
    },
    mounted() {
        this.loadOrders();
    }
}
</script>