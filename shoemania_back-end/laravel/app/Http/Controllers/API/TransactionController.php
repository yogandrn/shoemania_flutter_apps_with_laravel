<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\Address;
use App\Models\Product;
use App\Models\Transaction;
use App\Models\TransactionAddress;
use App\Models\TransactionItem;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Midtrans\Config;

class TransactionController extends Controller
{
    public function all(Request $request)
    {
        try {
            $id = $request->input('id');
            $limit = $request->input('limit');
            $status = $request->input('status');

            if ($id) {
                $transaction = Transaction::with(['items.product', 'address'])->find($id);
                if ($transaction) {
                    return ResponseFormatter::success($transaction, 'Data Transaksi berhasil diambil', 200);
                } else {
                    return ResponseFormatter::error(null, 'Data transaksi tidak tersedia', 200);
                }
            }

            $transactions = Transaction::with(['items.product', 'address'])->where('user_id', Auth::user()->id)->orderBy('created_at', 'desc');

            if ($status) {
                $transactions->where('status', $status);
            }

            return ResponseFormatter::success($transactions->get(), 'Data Transaksi Berhasil Diambil', 200);

        } catch (Exception $error) {
            return ResponseFormatter::error(null, $error->getMessage(), 400);
        }
    }

    public function checkout(Request $request)
    {
        try {
            $user = Auth::user();
            $order_id = date('Ymd') . rand(1000,9999);
            $request->validate([
                'address_id' => 'required|exists:addresses,id',
                'subtotal' => 'required',
                'shipping' => 'required',
                'total' => 'required',
                'status' => 'required',
            ]);

            $address = Address::find($request->address_id);

            $transaction = Transaction::create([
                'order_id' => $order_id,
                'user_id' => $user->id,
                'subtotal' => $request->subtotal,
                'shipping' => $request->shipping,
                'total' => $request->total,
                'status' => $request->status,
            ]);

            TransactionAddress::create([
                'transaction_id' => $transaction->id,
                'name' => $address->name,
                'phone_number' => $address->phone_number,
                'address' => $address->address,
                'postal_code' => $address->postal_code,
            ]);

            $carts = Cart::with(['product'])->where('user_id', $user->id)->get();
            foreach ($carts as $cart) {
                $qty = $cart->quantity;
                $product = Product::where('id', $cart->product_id)->first();
                Product::where('id', $cart->product_id)->update([
                        'stock' => $product->stock - $qty,
                        'sold' => $product->sold + $qty,
                    ]);
                
                TransactionItem::create([
                    'transaction_id' => $transaction->id,
                    'product_id' => $cart->product->id,
                    'price' => $cart->product->price,
                    'quantity' => $cart->quantity,
                    'subtotal' => $cart->product->price * $cart->quantity,
                ]);

                Cart::destroy($cart->id);
            }


            //konfigurasi midtrans
            Config::$serverKey = config('services.midtrans.serverKey');
            Config::$isProduction = config('services.midtrans.isProduction');
            Config::$isSanitized = config('services.midtrans.isSanitized');
            Config::$is3ds = config('services.midtrans.is3ds');

            // panggil transaksi yang dibuat
            $transaction =Transaction::with(['items.product', 'address'])->find($transaction->id);

            // membuat transaksi midtrans
            $midtrans = [
                'transaction_details' => [
                    'order_id' => $transaction->order_id,
                    'gross_amount' => (int)$transaction->total,
                ],
                'customer_detail' => [
                    'first_name' => $transaction->user->name,
                    'email' => $transaction->user->email,
                ],
                'enabled_payments' => ['gopay', 'bank_transfer', 'indomaret'],
                'vtweb' => []
            ];

            // ambil halaman payment midtrans
            $paymentUrl = \Midtrans\Snap::createTransaction($midtrans)->redirect_url;
            $transaction->payment_url = $paymentUrl;
            $transaction->save();

            // mengembalikan data ke API
            return ResponseFormatter::success($transaction, 'Transaksi berhasil', 200);

        } catch (Exception $error) {
            return ResponseFormatter::error(null, $error->getMessage(), 400);
        }
    }

    public function shipping(Request $request)
    {
        $destination = $request->postal_code;
        $weight = $request->weight;

        try {
            $curl = curl_init();
            curl_setopt_array($curl, array(
                CURLOPT_URL => "https://api.rajaongkir.com/starter/cost",
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => "",
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => "origin=68161&destination=" . $destination . "&weight=" . $weight . "&courier=jne",
                CURLOPT_HTTPHEADER => array(
                    "content-type: application/x-www-form-urlencoded",
                    "key: ******************************"
                ),
            ));
            $response = curl_exec($curl);
            $err = curl_error($curl);

            curl_close($curl);

            if ($err) {
                exit("cURL Error #:" . $err);
                $new_response = (array('status' => 'FAILED'));
            }

            $responses = json_decode($response, true);
            $cost = $responses['rajaongkir']['results'][0]['costs'][0]['cost'][0]['value'];
            $est = $responses['rajaongkir']['results'][0]['costs'][0]['cost'][0]['etd'];
            return ResponseFormatter::success(['name' => 'JNE REG','cost' => $cost, 'estimation' => $est], 'Shipping price berhasil diambil', 200);

        } catch (Exception $error) {
            return ResponseFormatter::error(null, $error->getMessage(), 400);
        }
    }
    
    public function confirm($id) {
        $transaction = Transaction::with(['items.product', 'address', 'user'])->find($id);
        try {
            Transaction::where('id', $id)->update(['status' => 'SUCCESS']);
            return ResponseFormatter::success($transaction, 'Order Berhasil Dikonfirmasi', 200);
        } catch (Exception $e) {
            return ResponseFormatter::error($transaction, $e->getMessage(), 400);
        }
    }

}
