<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Cart List</h5>
                    </div>

                    <div class="card-body">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th> Title </th>
                                    <th> Price </th>
                                    <th> Quantity </th>
                                    <th> Price </th>
                                    <th style="width: 170px"> Action </th>
                                </tr>
                            </thead>
                            <tbody v-if="cartProducts">
                                <tr v-for="product in cartProducts" :key="product.id">
                                    <td> {{ product.name }} </td>
                                    <td> {{ product.price }} </td>
                                    <td> {{ product.qty }} </td>
                                    <td> {{ product.qty * product.price }} </td>
                                    <td style="width: 170px">
                                        <a @click.prevent="deleteCartProduct(product)" class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td style="font-weight: bold;">Order Total</td>
                                    <td style="font-weight: bold;"> {{ parseInt(totalPrice) }} </td>
                                    <td style="width: 170px"></td>
                                </tr>
                            </tbody>
                            <tbody v-else>
                                <tr>
                                    <td colspan="4">
                                        <h5 class="text-center mt-4 mb-4">Cart is Empty.</h5>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <br>
                <a @click.prevent="OrderPlace()" class="col-md-12 btn btn-primary">Place Order</a>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data(){
        return {
            cartProducts: [],
            totalPrice: 0,
        }
    },
    methods: {
        async loadCartProducts(){
            await axios.get('/api/cartProductList').then(response => {
                this.cartProducts = response.data;
            });

            await axios.get('/api/cartProductTotal').then(response => {
                this.totalPrice = response.data;
            });
        },
        async deleteCartProduct(product){
            await axios.get(`/api/cartProductDelete/${product.rowId}`).then(() => {
                Toast.fire({
                    icon: 'success',
                    title: 'Product deleted successfully.'
                });
            });

            this.loadCartProducts();
        },
        async OrderPlace(){
            await axios.get('/api/orderPlace').then(() => {
                Toast.fire({
                    icon: 'success',
                    title: 'Order Placed successfully.'
                });
            });

            this.loadCartProducts();
        }
    },
    mounted() {
        this.loadCartProducts();
    }
}
</script>