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

        <form action="{{ route('dashboard.gallery.store') }}" method="post" enctype="multipart/form-data">
            @csrf
            {{-- Select Product --}}
            <div class="flex flex-wrap -mx-3 mb-6">
                <label for="product_id" class="block tracking-wide text-grey-700 text-s font-bold mb-2">Select Product</label>
                {{-- <input list="list-product-id" id="product_id" name="product_id" >
                <datalist id="list-product-id">
                    @foreach ($products as $item)
                        
                    <option value="{{ $item->id }}">{{ $item->name }}</option>
    
                    @endforeach
                </datalist> --}}
                <select name="product_id" class="appearance-none block w-full bg-grey text-grey-700 border border-grey-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="product_id">
                    @foreach ($products as $item)
                        
                    <option value="{{ $item->id }}">{{ $item->name }}</option>

                    @endforeach
                </select>
            </div>

            {{-- Upload photo  --}}
            <div class="flex flex-wrap -mx-3 mb-6">
                <div class="w-full">
                    <label class="block tracking-wide text-s font-bold mb-2" for="image_url">
                        Product Image
                    </label>
                    <img class="img-preview img-fluid col-sm-4 text-center mb-3">
                    <input name="image_url" class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="image_url" type="file" placeholder="Choose your profile photo" required onchange="previewImage()">
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
    <script>
        function previewImage() {
            const image = document.querySelector('#image_url');
            const imgPreview = document.querySelector('.img-preview');

            imgPreview.style.display = 'block';
            const oFReader = new FileReader();
            oFReader.readAsDataURL(image.files[0]);

            oFReader.onload = function(oFREvent) {
                imgPreview.src = oFREvent.target.result;
            }
        }
    </script>
@endsection

