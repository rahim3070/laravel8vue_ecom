<?php

use Illuminate\Support\Facades\Route;

Route::get('/{any?}', function () {
    return view('app');
})->where('any', '[\/\w\.-]*');

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
