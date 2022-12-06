

@extends('layouts.main')

@section('content')
    <div class="container mt-4" style="padding-bottom: 8%">
        <div class="">
            <a href="{{route('dashboard.gallery.create')}}" class="btn btn-success mt-4 mb-4">+ New Gallery</a>
        </div>
        <div class="shadow overflow-hidden sm:rounded-md" >
            <div class="px-4 py-4 bg-white sm:p-6">
                <table class="table table-striped">
                    <thead>
                        <th class="text-center">#</th>
                        <th class="text-center">Product ID</th>
                        <th class="text-center">Product Name</th>
                        <th class="text-center">Image</th>
                        <th class="text-center">Action</th>
                    </thead>
                    <tbody>
                        @forelse ($galleries as $item)
                            <tr>
                                <td class="text-center">{{ $loop->iteration }}</td>
                                <td class="text-center">{{ $item->product_id }}</td>
                                <td class="text-center">{{ $item->product->name }}</td>
                                <td class="text-center"><img src="{{ $item->image_url }}" alt="{{$item->product->name}}" width="120px"></td>
                                <td class="text-center">
                                        <form class="inline-block" action="{{ route('dashboard.product.destroy', $item->id) }}" method="POST" style="display: inline-block">
                                            {!! method_field('delete') . csrf_field() !!}
                                            <button class="btn btn-danger inline-block" onclick="return confirm('Apakah Anda yakin ingin menghapus {{ $item->name }}?');">
                                                Hapus
                                            </button>
                                        </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="text-center">Data Kosong</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
                <div class="text-center mt-4">
                    {{ $galleries->links() }}
                </div>
            </div>
        </div>
        
    </div>
@endsection