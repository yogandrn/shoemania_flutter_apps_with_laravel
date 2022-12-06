<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransactionAddress extends Model
{
    use HasFactory;

    protected $table = 'transaction_addresses';

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'transaction_id' => 'integer',
    ];

    public function transaction()
    {
        return $this->belongsTo(Transaction::class, 'transaction_id', 'id');
    }
}
