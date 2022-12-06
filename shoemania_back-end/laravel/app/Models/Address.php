<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class Address extends Model
{
    use HasFactory;
    
    protected $table = 'addresses';

    protected $fillable = [
        'name', 'phone_number', 'address', 'postal_code', 'user_id'
    ];

    protected $casts = [
        'id' => 'integer',
        'user_id' => 'integer',
    ];
    protected function serializeDate($date) {
        return $date->format('Y-m-d H:i:s');
    }
}
