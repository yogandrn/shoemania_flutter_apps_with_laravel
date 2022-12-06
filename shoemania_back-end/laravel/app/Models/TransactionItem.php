<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransactionItem extends Model
{
    use HasFactory;

    protected $guarded = ['id'];
    
    protected $casts = [
        'id' => 'integer',
        'transaction_id' => 'integer',
        'product_id' => 'integer',
        'subtotal' => 'integer',
        'price' => 'integer',
        'quantity' => 'integer',
    ];

    public function product()
    {
        return $this->hasOne(Product::class, 'id', 'product_id');
    }

    protected function serializeDate($date) {
        return $date->format('Y-m-d H:i:s');
    }
}
