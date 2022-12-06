<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\Product;
use Exception;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function all(Request $request)
    {
        try {
        $id = $request->input('id');
        $limit = $request->input('limit');
        $tags = $request->input('tags');
        $category = $request->input('category');
        $name = $request->input('name');
        $description = $request->input('description');
        $price_from = $request->input('price_from');
        $price_to = $request->input('price_to');
        $keyword = $request->input('search');

        if ($id) {
            $product = Product::with(['category', 'galleries'])->find($id);
            if ($product) {
                return ResponseFormatter::success($product, "Data produk berhasil diambil", 200);
            } else {
                return ResponseFormatter::error(null, 'Data Produk tidak ada', 404);
            }
        }
        $products = Product::with(['galleries', 'category'])->where('deleted_at', null);

        if ($name) {
            $products->where('name', 'LIKE', '%' . $name .'%');
        }
        if ($description) {
            $products->where('description', 'LIKE', '%' . $description .'%');
        }
        if ($tags) {
            $products->where('tags', 'LIKE', '%' . $tags .'%');
        }
        if ($price_from) {
            $products->where('price', '>=', $price_from);
        }
        if ($price_to) {
            $products->where('price', '<=', $price_to);
        }
        if ($category) {
            $products->where('category', $category);
        }
        if ($keyword) {
            $products->where('name', 'LIKE', '%' . $keyword .'%')
                        ->orWhere('tags', 'LIKE', '%' . $keyword .'%');
                }
        return ResponseFormatter::success($products->get(), 'Produk Berhasil Diambil', 200);
        } catch (Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);
        }
    }
    
    public function searching($keyword)
    {
        try {
            $products = Product::query()->where('name', 'LIKE', '%{$keyword}')
                                ->orWhere('tags', 'LIKE', '%{$keyword}%')
                                ->orWhere('description', 'LIKE', '%{$keyword}%')
                                ->orWhere('tags', 'LIKE', '%{$keyword}%')
                                ->orderBy('name', 'asc')->get();
            if ($products->count() > 0) {
                return ResponseFormatter::success($products, 'Products found!', 200);
            } else {
                return ResponseFormatter::success($products, 'Products not found', 201);
            }
        } catch(Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);
        }
    }
    
    
    public function popularProducts(Request $request)
    {
        try {
            $products = Product::where('deleted_at', null)->with(['galleries', 'category'])->orderBy('sold', 'desc')->limit(6)->get();
            return ResponseFormatter::success($products, 'Data produk berhasil diambil', 200);
        } catch(Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);
        }
    }

    public function newProducts(Request $request)
    {
        try {
            $products = Product::with(['galleries', 'category'])->where('deleted_at', null)->orderBy('created_at', 'desc')->limit(6)->get();
            return ResponseFormatter::success($products, 'Data produk berhasil diambil', 200);
        } catch(Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);
        }
    }
}
