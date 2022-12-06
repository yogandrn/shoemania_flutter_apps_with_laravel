<?php

use App\Http\Controllers\API\AddressController;
use App\Http\Controllers\API\CartController;
use App\Http\Controllers\API\CategoryController;
use App\Http\Controllers\API\ProductController;
use App\Http\Controllers\API\TransactionController;
use App\Http\Controllers\API\MidtransController;
use App\Http\Controllers\API\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->group( function() {
    Route::get('/user', [UserController::class, 'fetch']);
    Route::post('/user/update', [UserController::class, 'updateProfile']);
    Route::post('/user/update/photo', [UserController::class, 'updatePhoto']);
    Route::post('/logout', [UserController::class, 'logout']);

    Route::get('/transactions', [TransactionController::class, 'all']);
    Route::post('/checkout', [TransactionController::class, 'checkout']);
    Route::patch('/transaction/confirm/{id}', [TransactionController::class, 'confirm']);
    Route::post('/shipping', [TransactionController::class, 'shipping']);

    Route::get('/carts', [CartController::class, 'all']);
    Route::post('/cart/add', [CartController::class, 'addToCart']);
    Route::post('/cart/{id}/update', [CartController::class, 'updateCart']);
    Route::post('/cart/{id}/increment', [CartController::class, 'increment']);
    Route::post('/cart/{id}/decrement', [CartController::class, 'decrement']);
    Route::delete('/cart/{id}', [CartController::class, 'delete']);
    
    Route::get('/address', [AddressController::class, 'all']);
    Route::post('/address/add', [AddressController::class, 'create']);
    Route::post('/address/{id}/update', [AddressController::class, 'update']);
    Route::delete('/address/{id}', [AddressController::class, 'destroy']);
});

Route::post('/register', [UserController::class, 'register']);
Route::post('/login', [UserController::class, 'login']);

Route::get('/products', [ProductController::class, 'all']);
Route::get('/products/search/{keyword}', [ProductController::class, 'searching']);
Route::get('/products/popular', [ProductController::class, 'popularProducts']);
Route::get('/products/new', [ProductController::class, 'newProducts']);
Route::get('/categories', [CategoryController::class, 'all']);

Route::post('/midtrans/callback', [MidtransController::class, 'callback']);

Route::post('/test', [TransactionController::class, 'test']);
