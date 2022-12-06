<?php

namespace App\Http\Controllers;

use App\Http\Requests\CategoryRequest;
use App\Models\Category;
use Illuminate\Http\Request;
use Yajra\DataTables\Facades\DataTables;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        // $query = Category::query();

        //     return DataTables::of($query)
        //         ->addColumn('action', function ($item) {
        //             return '
        //                 <a class="inline-block border border-gray-700 bg-gray-700 text-white rounded-md px-2 py-1 m-1 transition duration-500 ease select-none hover:bg-gray-800 focus:outline-none focus:shadow-outline" 
        //                     href="' . route('dashboard.category.edit', $item->id) . '">
        //                     Edit
        //                 </a>
        //                 <form class="inline-block" action="' . route('dashboard.category.destroy', $item->id) . '" method="POST">
        //                 <button class="border border-red-500 bg-red-500 text-white rounded-md px-2 py-1 m-2 transition duration-500 ease select-none hover:bg-red-600 focus:outline-none focus:shadow-outline" >
        //                     Hapus
        //                 </button>
        //                     ' . method_field('delete') . csrf_field() . '
        //                 </form>';
        //         })
        //         ->editColumn('price', function ($item) {
        //             return number_format($item->price);
        //         })
        //         // ->order(['id', 'desc'])
        //         ->rawColumns(['action'])
        //         ->make();

        return view('category.index', [
            'categories' => Category::where('deleted_at', null)->paginate(10),
            'title' => 'Categories'
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('category.create', [ 'title' => 'Create Category' ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(CategoryRequest $request)
    {
        $data = $request->all();
        Category::create($data);
        return redirect()->route('dashboard.category.index')->with('success', 'Category has been created!');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function show(Category $category)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function edit(Category $category)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function update(CategoryRequest $request, Category $category)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function destroy(Category $category)
    {
        //
    }
}
