<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\Cart;
use Exception;
use App\Http\Requests\CartRequest;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
    public function all()
    {
        $subtotal = 0;
        $weight = 0;
        try {
            $carts = Cart::with(['product'])->where('user_id', Auth::user()->id)->get();

            foreach ($carts as $cart) {
                $subtotal += $cart->quantity * $cart->product->price;
                $weight += $cart->quantity * $cart->product->weight;
            }
            return response()->json(['subtotal' => $subtotal, 'weight' => $weight, 'carts' => $carts], 200);
        } catch (Exception $error) {
            return ResponseFormatter::error(null, $error->getMessage(), 400);
        }
    }
    

    public function addToCart(CartRequest $request)
    {
        try {
            $data = $request->all();
            Cart::create($data);
            return ResponseFormatter::success(null, "Produk berhasil ditambahkan", 200);
        } catch (Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);

        }
    }

    public function updateCart(CartRequest $request, $id)
    {
        try {
            $cart = Cart::where('id', $id)->first();
            Cart::where('id', $id)->update(['quantity' => $cart->quantity + $request->quantity]);
            return ResponseFormatter::success(null, "Cart updated", 200);
        } catch (Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);

        }
    }

    public function increment($id)
    {
        try {
            $cart = Cart::where('id', $id)->first();
            Cart::where('id', $id)->update(['quantity' => $cart->quantity + 1]);
            return ResponseFormatter::success(null, "Cart updated", 200);
        } catch (Exception $e) {
            return ResponseFormatter::success(null, $e->getMessage(), 400);

        }
    }

    public function decrement($id)
    {
        try {
            $cart = Cart::where('id', $id)->first();
            Cart::where('id', $id)->update(['quantity' => $cart->quantity -1]);
            return ResponseFormatter::success(null, "Cart updated", 200);
        } catch (Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);

        }
    }

    public function delete($id)
    {
        try {
            Cart::destroy($id);
            return ResponseFormatter::success(null, "Cart deleted", 200);
        } catch (Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);
        }
    }
}
