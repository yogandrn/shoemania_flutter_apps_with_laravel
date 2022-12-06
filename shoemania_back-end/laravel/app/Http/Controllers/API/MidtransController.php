<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Midtrans\Config;
use Midtrans\Notification;

class MidtransController extends Controller
{
    public function callback(Request $request)
    {
        // set konfigurasi midtrans
        Config::$serverKey = config('services.midtrans.serverKey');
        Config::$isProduction = config('services.midtrans.isProduction');
        Config::$isSanitized = config('services.midtrans.isSanitized');
        Config::$is3ds = config('services.midtrans.is3ds');

        // buat instance midtrans notifikasi
        $notification =  new Notification();

        // assign ke variable untuk coding
        $status  = $notification->transaction_status;
        $type  = $notification->payment_type;
        $fraud  = $notification->fraud_status;
        $order_id  = $notification->order_id;

        // cari transaksi berdasarkan ID
        $transaction = Transaction::where('order_id', '=', $order_id)->first();
        $items = $transaction->items;
        
        // handle notifikasi status midtrans
        if ($status == 'capture') 
        {
            if ($type == 'credit_card') 
            {
                if ($fraud == 'challenge')
                {
                    $transaction->status = 'PENDING';
                } 
                else 
                {
                    $transaction->status = 'ON_PROCESS';
                }
            }
        } 
        else if ($status == 'settlement') 
        {
            $transaction->status = 'ON_PROCESS';
        }
        else if ($status == 'pending') 
        {
            $transaction->status = 'PENDING';
        }
        else if ($status == 'deny') 
        {
            $transaction->status = 'CANCELLED';
            foreach($items as $item) {
                $product = Product::find($item->product_id);
                Product::where('id', $item->product_id)->update([
                    'stock' => $product->stock + $item->quantity,
                    'sold' => $product->sold - $item->quantity,
                ]);
            }
        }
        else if ($status == 'expire') 
        {
            $transaction->status = 'CANCELLED';
            foreach($items as $item) {
                $product = Product::find($item->product_id);
                Product::where('id', $item->product_id)->update([
                    'stock' => $product->stock + $item->quantity,
                    'sold' => $product->sold - $item->quantity,
                ]);
            }
        }
        else if ($status == 'cancel') 
        {
            $transaction->status = 'CANCELLED';
            foreach($items as $item) {
                $product = Product::find($item->product_id);
                Product::where('id', $item->product_id)->update([
                    'stock' => $product->stock + $item->quantity,
                    'sold' => $product->sold - $item->quantity,
                ]);
            }
        }
        else if ($status == 'failure') 
        {
            $transaction->status = 'CANCELLED';
            foreach($items as $item) {
                $product = Product::find($item->product_id);
                Product::where('id', $item->product_id)->update([
                    'stock' => $product->stock + $item->quantity,
                    'sold' => $product->sold - $item->quantity,
                ]);
            }
        }

        // simpan transaksi
        $transaction->save();
        
        // Kirimkan email
        // if ($transaction)
        // {
        //     if($status == 'capture' && $fraud == 'accept' )
        //     {
        //         //
        //     }
        //     else if ($status == 'settlement')
        //     {
        //         //
        //     }
        //     else if ($status == 'success')
        //     {
        //         //
        //     }
        //     else if($status == 'capture' && $fraud == 'challenge' )
        //     {
        //         return response()->json([
        //             'meta' => [
        //                 'code' => 200,
        //                 'message' => 'Midtrans Payment Challenge'
        //             ]
        //         ]);
        //     }
        //     else
        //     {
        //         return response()->json([
        //             'meta' => [
        //                 'code' => 200,
        //                 'message' => 'Midtrans Payment not Settlement'
        //             ]
        //         ]);
        //     }

        //     return response()->json([
        //         'meta' => [
        //             'code' => 200,
        //             'message' => 'Midtrans Notification Success'
        //         ]
        //     ]);
        // }

    }

    public function success()
    {
        return view('payment.success');
    }

    public function unfinish()
    {
        return view('payment.unfinish');
    }

    public function error()
    {
        return view('payment.error');
    }
}
