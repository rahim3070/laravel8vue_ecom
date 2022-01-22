<template>
    <div class="container py-5">
        <div class="mb-3">
            <h2>Our Products</h2>
        </div>
        <div class="mb-3">
            <div class="row">
                <div class="col-md-6">
                    <input v-model="querySearch" type="text" class="form-control" placeholder="Search by Title">
                </div>
                <div class="col-md-6">
                    <select v-model="queryFiled" class="form-control">
                        <option value="" selected="selected">Please Select a Value ...</option>
                        <option value="hl">High -> Low</option>
                        <option value="lh">Low -> High</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" v-if="apiCallLoaded">
            <div class="col-4 mb-4" v-for="product in products" :key="product.id">
                <div class="card">
                    <img :src="product.image" class="card-img-top" style="height: 150px; object-fit: cover; overflow: hidden" alt="...">
                    <div class="card-body">
                        <div class="mb-2 d-flex justify-content-between">
                            <label class="badge badge-danger mb-3" style="color: chocolate;font-size: small;">  {{ product.cat_name }} </label>
                            <h4>${{ product.price }}</h4>
                        </div>
                        <h5 class="card-title">{{ product.title }}</h5>
                        <div v-if="product.qty > 0">
                            <h5 class="card-title">Qty - {{ product.qty }}</h5>
                            <div class="mb-2 d-flex justify-content-between">
                                <a @click.prevent="AddtoCart(product.id)" class="btn btn-primary">Add to Cart</a>
                                <router-link :to="{ name: 'product-details', params: {slug: product.slug }}" class="btn btn-info">View Product</router-link>
                            </div>
                        </div>
                        <div v-else>
                            <h5 class="card-title">Qty - Out of Stock</h5>
                            <div class="mb-2 d-flex justify-content-between">
                                <a @click.prevent="AddtoCart(product.id)" class="btn btn-primary" style="display: none;">Add to Cart</a>
                                <router-link :to="{ name: 'product-details', params: {slug: product.slug }}" class="btn btn-info">View Product</router-link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center mt-5" v-if="apiCallLoaded">
            <button class="btn btn-primary" :disabled="!next_page_url" @click.prevent="loadMoreProducts(next_page_url)">Load More Products</button>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                querySearch: "",
                queryFiled: "",
                products: [],
                next_page_url: null,
                apiCallLoaded: false,
            }
        },
        watch: {
            querySearch: function(newQ, old) {
                if (newQ === "") {
                    this.loadProducts();
                } else {
                    // this.queryFiled = "";
                    this.searchData();
                }
            },
            queryFiled: function(newQ, old) {
                if (newQ === "") {
                    this.loadProducts();
                } else {
                    // this.querySearch = "";
                    this.searchDataHL();
                }
            },
        },
        methods: {
            async loadProducts(){
                let { data } = await axios.get('/api/products');

                this.products = data.data;
                this.next_page_url = data.next_page_url;
                this.apiCallLoaded = true;
            },
            async searchData() {
                await axios.get(`/api/search/homeproducts/${this.querySearch}`)
                .then(response => {
                    this.products = response.data;
                    this.next_page_url = data.next_page_url;
                    this.apiCallLoaded = true;
                })
                .catch(e => {
                    console.log(e);
                });
            },
            async searchDataHL() {
                await axios.get(`/api/search/homeproductshl/${this.queryFiled}`)
                .then(response => {
                    this.products = response.data;
                    this.next_page_url = data.next_page_url;
                    this.apiCallLoaded = true;
                })
                .catch(e => {
                    console.log(e);
                });
            },
            async loadMoreProducts(url){
                let { data } = await axios.get(url);
                
                let products = data.data;
                products.forEach(element => {
                    this.products.push(element);
                });
                // this.products.concat();
                this.next_page_url = data.next_page_url;
            },
            AddtoCart(pid){
                axios.get(`/api/addtocart/${pid}`)
                .then(response => {
                    Toast.fire({
                        icon: 'success',
                        title: 'Product added on cart.'
                    });
                })
                .catch(res => {
                    Toast.fire({
                        icon: 'warning',
                        title: 'Product not added on cart.'
                    });
                })
            }
        },
        mounted(){
            this.loadProducts();
        }
    }
</script>
