<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Transaction;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        return view('newdashboard', [ 
            'title' => 'Dashboard', 
            'transactions' => Transaction::with(['user', 'items', 'address'])
                    ->where('deleted_at', '=', null)
                    ->where('status', '=', 'ON_PROCESS')
                    ->orWhere('status', '=', 'ON_DELIVERY')
                    ->orWhere('status', '=', 'PENDING')
                    ->orderBy('created_at', 'desc')
                    ->paginate(20),
            'countProduct' => Product::count(),
            'countTransaction' => Transaction::count(),
     ]);
    }
}
