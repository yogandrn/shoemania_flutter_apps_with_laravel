<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Category extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = ['name'];

    public function products()
    {
        return $this->hasMany(Product::class, 'id', 'category_id');
    }
    
    protected $casts = [
        'id' => 'integer',
    ];

    protected function serializeDate($date) {
        return $date->format('Y-m-d H:i:s');
    }
}
