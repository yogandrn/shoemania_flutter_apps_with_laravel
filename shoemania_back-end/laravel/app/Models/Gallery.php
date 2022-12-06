<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

class Gallery extends Model
{
    use HasFactory;

    protected $guarded = ['id'];
    protected $table = 'galleries';

    protected function serializeDate($date) {
        return $date->format('Y-m-d H:i:s');
    }
    
    protected $casts = [
        'id' => 'integer',
        'product_id' => 'integer',
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
    
    public function getImageUrlAttribute($image_url)
    {
        return config('app.url') . '/laravel/storage/app/public/' . $image_url;
    }
}
