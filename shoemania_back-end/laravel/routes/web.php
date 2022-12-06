<?php

use App\Http\Controllers\CategoryController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\GalleryController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\TransactionController;
use App\Http\Controllers\API\MidtransController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/welcome', function () {
    return view('welcome');
});

// Route::group(['middleware' => ['auth:sanctum', 'verified']], function() {
//     Route::name('dashboard.')->prefix('dashboard')->group(function() {
//         Route::get('/', [DashboardController::class, 'index'])->name('dashboard');
//     });
// });

// Route::middleware(['auth:sanctum', 'verified',])->group(function() {
//     Route::name('dashboard')->prefix('dashboard')->group(function() {
//         Route::get('/', [DashboardController::class, 'index'])->name('index');
//     });
//     // Route::get('/dashboard', function() { return view('dashboard'); });
// });

// Route::middleware([
//     'auth:sanctum',
//     config('jetstream.auth_session'),
//     'verified'
// ])->group(function () {
//     Route::get('/dashboard', function () {
//         return view('dashboard');
//     })->name('dashboard');
// });

Route::group(['middleware' => ['auth:sanctum', 'verified']], function () {
   
    Route::name('dashboard.')->prefix('dashboard')->group(function () {
        Route::get('/', [DashboardController::class, 'index'])->name('index');
        Route::resource('category', CategoryController::class);
        Route::resource('product', ProductController::class);
        Route::resource('gallery', GalleryController::class);
        Route::resource('transaction', TransactionController::class);
    });
    
    Route::get('/transaction/{id}/{status}', [TransactionController::class, 'changeStatus'])->name('changeStatus');
});

// Midtrans related
Route::get('/payment/success', [MidtransController::class, 'success']);
Route::get('/payment/unfinish', [MidtransController::class, 'unfinish']);
Route::get('/payment/error', [MidtransController::class, 'error']);

