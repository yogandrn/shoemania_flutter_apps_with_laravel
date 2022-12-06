<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    public function product()
    {
        return $this->hasOne(Product::class, 'id', 'product_id');
    }
    
    protected $casts = [
        'id' => 'integer',
        'user_id' => 'integer',
        'product_id' => 'integer',
        'quantity' => 'integer',
    ];

    protected function serializeDate($date) {
        return $date->format('Y-m-d H:i:s');
    }
}
