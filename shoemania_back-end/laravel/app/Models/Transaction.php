<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Transaction extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'order_id', 'user_id', 'address_id','subtotal', 'shipping', 'total', 'status', 'payment_url', 'receipt'
    ];
    
    protected $casts = [
        'id' => 'integer',
        'user_id' => 'integer',
        'address_id' => 'integer',
        'subtotal' => 'integer',
        'shipping' => 'integer',
        'total' => 'integer',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function address()
    {
        return $this->hasOne(TransactionAddress::class, 'transaction_id', 'id');
    }

    public function items()
    {
        return $this->hasMany(TransactionItem::class, 'transaction_id', 'id');
    }

    protected function serializeDate($date) {
        return $date->format('Y-m-d H:i:s');
    }

}
