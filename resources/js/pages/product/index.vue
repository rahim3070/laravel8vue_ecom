<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Product List</h5>
                        <router-link :to="{name: 'create-product'}" class="btn btn-primary">Create Product</router-link>
                    </div>

                    <div class="card-body">
                        <div class="mb-3">
                            <div class="row">
                                <div class="col-md-12">
                                    <input v-model="querySearch" type="text" class="form-control" placeholder="Search by Title">
                                </div>
                            </div>
                        </div>

                        <table class="table">
                            <thead>
                                <tr>
                                    <th style="width: 100px"> Id </th>
                                    <th> Image </th>
                                    <th> Title </th>
                                    <th> Category </th>
                                    <th> Price </th>
                                    <th> Quantity </th>
                                    <th style="width: 170px"> Action </th>
                                </tr>
                            </thead>
                            <tbody v-if="products.length">
                                <tr v-for="product in products" :key="product.id">
                                    <td style="width: 100px"> {{ product.id }} </td>
                                    <td> 
                                        <div style="max-width: 150px; max-height: 150px; overflow:hidden">
                                            <img :src="product.image" alt="" class="img-fluid">
                                        </div>    
                                    </td>
                                    <td> {{ product.title }} </td>
                                    <td> 
                                        <span v-if="product.category"> {{ product.category.name }} </span>
                                        <span v-else> {{ product.category_id }} </span>
                                    </td>
                                    <td> {{ product.price }} </td>
                                    <td> {{ product.qty }} </td>
                                    <td style="width: 170px">
                                        <router-link :to="{name: 'edit-product', params: {id: product.id}}" class="btn btn-primary btn-sm">Edit</router-link>
                                        <a @click.prevent="deleteProduct(product)" href="#" class="btn btn-danger btn-sm">Delete</a>
                                    </td>
                                </tr>
                            </tbody>
                            <tbody v-else>
                                <tr>
                                    <td colspan="4">
                                        <h5 class="text-center mt-4 mb-4">No products found.</h5>
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
            products: [],
        }
    },
    watch: {
        querySearch: function(newQ, old) {
          if (newQ === "") {
            this.loadProducts();
          } else {
            this.searchData();
          }
        }
    },
    methods: {
        async loadProducts(){
            await axios.get('/api/product').then(response => {
                this.products = response.data;
            });
        },
        async searchData() {
            await axios.get(`/api/search/products/${this.querySearch}`)
              .then(response => {
                this.products = response.data;
              })
              .catch(e => {
                console.log(e);
              });
        },
        async deleteProduct(product){
            await axios.delete(`/api/product/${product.id}`).then(() => {
                Toast.fire({
                    icon: 'success',
                    title: 'Product deleted successfully.'
                });
            });
            let index = this.products.indexOf(product);
            this.products.splice(index, 1);
        }
    },
    mounted() {
        this.loadProducts();
    }
}
</script>