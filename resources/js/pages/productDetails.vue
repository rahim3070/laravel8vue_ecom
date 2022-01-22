<template>
    <div class="container py-5">
        <div class="row">
            <div class="col-8">
                <div class="card">
                    <div class="card-header">
                        <h2> {{ product.title }} </h2>
                    </div>
                    <div class="card-body">
                        <div style="text-align: center;"><img :src="product.image" alt="" class="img-fluid"></div>
                        <br>
                        <div class="mb-2 d-flex justify-content-between">
                            <label class="badge badge-danger mb-3" style="color: chocolate;font-size: medium;">  {{ product.category.name }} </label>
                            <h3>${{ product.price }}</h3>
                        </div>
                        <div class="mt-2">
                            {{ product.description }}
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="card">
                    <div class="card-body">
                        <router-link :to="{ name: 'home'}" class="btn btn-primary">Go to Home</router-link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                product: [],
                apiCallLoaded: false,
            }
        },
        methods: {
            async loadProductData(){
                let slug = this.$route.params.slug;
                let { data } = await axios.get('/api/products/'+slug);

                this.product = data;
            },
        },
        mounted(){
            this.loadProductData();
        }
    }
</script>
