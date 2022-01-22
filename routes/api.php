<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::post('user', 'AuthController@update_user');
    Route::resource('category', 'CategoryController');
    Route::resource('product', 'ProductController');
    Route::resource('order', 'OrderController');
});

Route::get('products', 'PublicAPIController@products');
Route::get('search/products/{query}', 'PublicAPIController@search');
Route::get('search/homeproducts/{queryText}', 'PublicAPIController@search_home_products');
Route::get('search/homeproductshl/{querySelect}', 'PublicAPIController@search_home_productshl');
Route::get('products/{slug}', 'PublicAPIController@product_details');
Route::get('addtocart/{pid}', 'PublicAPIController@add_to_cart');
Route::get('cartProductList', 'PublicAPIController@cartProductList');
Route::get('cartProductTotal', 'PublicAPIController@cartProductTotal');
Route::get('cartProductDelete/{rowId}', 'PublicAPIController@cartProductDelete');
Route::get('orderPlace', 'PublicAPIController@orderPlace');
Route::get('search/orders/{query}', 'OrderController@search');