<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\Category;
use Exception;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function all(Request $request)
    {
        try {
        $id = $request->input('id');
        $limit = $request->input('limit');
        $name = $request->input('name');
        $show_product = $request->input('show_product');

        
        if ($id) {
            $category = Category::with(['products'])->find($id);
            if ($category) {
                return ResponseFormatter::success($category, "Data produk berhasil diambil", 200);
            } else {
                return ResponseFormatter::error(null, 'Data Produk tidak ada', 404);
            }
        }

        $categories = Category::query();

        if ($name) {
            $categories->where('name', 'LIKE', '%' . $name .'%')->where('deleted_at', null);
        }
        if ($show_product) {
            $categories->with(['products'])->where('deleted_at', null);
        }
        
        return ResponseFormatter::success($categories, 'Data kategori berhasil diambil', 200);
        } catch (Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);
        }

    }
}
