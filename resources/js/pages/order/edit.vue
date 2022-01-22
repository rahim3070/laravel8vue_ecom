<template>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5>Update Order - {{  orderForm.order_id }}</h5>
                        <router-link :to="{name: 'order-list'}" class="btn btn-primary">Order List</router-link>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-6 offset-3">
                                <form @submit.prevent="updateOrder">
                                    <div class="form-group">
                                        <label for="">Order Id</label>
                                        <input type="text" v-model="orderForm.order_id" class="form-control mb-3" name="order_id" placeholder="Order Id" :class="{ 'is-invalid': orderForm.errors.has('order_id') }" readonly>
                                        <has-error :form="orderForm" field="order_id" class="mb-3"></has-error>
                                    </div>
                                    <div class="form-group">
                                        <label for="">Select Status</label>
                                        <select name="order_status" v-model="orderForm.order_status" :class="{ 'is-invalid': orderForm.errors.has('order_status') }" class="form-control mb-3">
                                            <option value="" selected="selected">Please Select a Status ...</option>
                                            <option value="0">Pending</option>
                                            <option value="1">Recieved</option>
                                            <option value="2">Shipped</option>
                                            <option value="3">Completed</option>
                                            <option value="4">Return</option>
                                            <option value="5">Reject</option>
                                        </select>
                                        <has-error :form="orderForm" field="order_status" class="mb-3"></has-error>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-success">Update Order</button>
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
            orderForm: new Form({
                order_id: '',
            }),
        }
    },
    methods: {
        updateOrder(){
            let id = this.$route.params.id;
            this.orderForm.put(`/api/order/${id}`).then(() => {
                Toast.fire({
                    icon: 'success',
                    title: 'Order updated successfully.'
                });
            })
        },
        loadOrder(){
            let id = this.$route.params.id;
            
            axios.get(`/api/order/${id}/edit`).then(response => {
                this.orderForm.order_id = response.data[0].order_id;
            });
        }
    },
    mounted(){
        this.loadOrder();
    }
}
</script>