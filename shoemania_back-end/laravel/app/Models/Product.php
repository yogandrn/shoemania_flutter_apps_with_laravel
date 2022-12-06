<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'name', 'description', 'tags', 'price', 'stock', 'category_id', 'weight', 'sold',
    ];

    protected $with = ['galleries'];

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id', 'id');
    }
    
    protected $casts = [
        'id' => 'integer',
        'category_id' => 'integer',
        'price' => 'integer',
        'stock' => 'integer',
        'sold' => 'integer',
        'weight' => 'integer',
    ];

    public function galleries()
    {
        return $this->hasMany(Gallery::class, 'product_id', 'id');
    }

    protected function serializeDate($date) {
        return $date->format('Y-m-d H:i:s');
    }
}
