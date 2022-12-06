@extends('layouts.main')

@section('content')
    <div class="py-8" >
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        @if ($errors->any())
                <div  role="alert" style="margin-bottom: 1.5rem;">
                    <div class="bg-red-500 text-white font-bold text-l rounded-t px-4 py-2" >
                        There's something wrong
                    </div>
                    <div class="border border-t-0 border-red-400 rounded-b px-4 py-3 text-red-700 bg-red-100">
                        @foreach($errors->all() as $error)
                            <li>{{ $error}}</li>
                        @endforeach
                    </div>
                </div>
                @endif

        <form action="{{ route('dashboard.product.store') }}" method="post" enctype="multipart/form-data">
            @csrf
            {{-- <input type="text" minlength="3" maxlength="255" required placeholder="Type New Category" id="name" name="name"> --}}
            {{-- Form Nama  --}}
            <div class="flex flex-wrap -mx-3 mb-6 ">
                <label for="name" class="block tracking-wide text-grey-700 text-s font-bold mb-2">Name</label>
                <input type="text" value="{{ old('name') }}" class="appearance-none block w-full bg-grey text-grey-700 border border-grey-700 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="name" name="name" placeholder="Type the product name" required>
            </div>
            {{-- Form Description  --}}
            <div class="flex flex-wrap -mx-3 mb-6 ">
                <label for="description" class="block tracking-wide text-grey-700 text-s font-bold mb-2">Description</label>
                <input type="text" value="{{ old('description') }}" class="appearance-none block w-full bg-grey text-grey-700 border border-grey-700 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="description" name="description" placeholder="Type the product description" required>
            </div>

            <div class="row">
                {{-- Select Category  --}}
                <div class="col-6 flex flex-wrap -mx-3 mb-6">
                    <label for="category_id" class="block tracking-wide text-grey-700 text-s font-bold mb-2">Category</label>
                    <select name="category_id" class="appearance-none block w-full bg-grey text-grey-700 border border-grey-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="category_id">
                        @foreach ($categories as $item)
                            
                        <option value="{{ $item->id }}">{{ $item->name }}</option>

                        @endforeach
                    </select>
                </div>

                {{-- Form Tags  --}}
                <div class="col-6 flex flex-wrap -mx3 mb-6">
                    <label for="tags" class="block tracking-wide text-grey-700 text-s font-bold mb-2">Tags</label>
                    <input type="text" value="{{ old('tags') }}" class="appearance-none block w-full bg-grey text-grey-700 border border-grey-700 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="tags" name="tags" placeholder="Type the product tags" required>    
                    {{-- <p class="text-gray-600 text-xs text-italic">Pisahkan dengan tanda koma ',' </p> --}}
                </div>
            </div>

            <div class="row">
                <div class="col-4 flex- flex-wrap -mx-3 mb-6">
                    <label for="price" class="block tracking-wide text-grey-700 text-s font-bold mb-2">Price</label>
                    <input type="number" value="{{ old('price') }}" class="appearance-none block w-full bg-grey text-grey-700 border border-grey-700 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="price" name="price" placeholder="Type the product price" required>
                
                </div>
                <div class="col-4 flex- flex-wrap -mx-3 mb-6">
                    <label for="stock" class="block tracking-wide text-grey-700 text-s font-bold mb-2">Stock</label>
                    <input type="number" value="{{ old('stock') }}" class="appearance-none block w-full bg-grey text-grey-700 border border-grey-700 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="stock" name="stock" placeholder="Type the product stock" required>
                
                </div>
                <div class="col-4 flex- flex-wrap -mx-3 mb-6">
                    <label for="weight" class="block tracking-wide text-grey-700 text-s font-bold mb-2">{{ "Weight (on Gram)" }}</label>
                    <input type="number" value="{{ old('weight') }}" class="appearance-none block w-full bg-grey text-grey-700 border border-grey-700 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="weight" name="weight" placeholder="Type the product weight" required>
                
                </div>
            </div>
            <div class="flex flex-wrap -mb-6">
                <div class="w-full text-right">
                    <button type="submit" class="shadow-lg text-white font-bold py-2 px-4 rounded" style="background-color: #218a26">Save</button>
                </div>
            </div>
        </form>
        </div>
    </div>
@endsection

