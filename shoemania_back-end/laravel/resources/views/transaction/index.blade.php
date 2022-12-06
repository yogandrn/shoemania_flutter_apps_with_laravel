{{-- <x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Category') }}
        </h2>
    </x-slot>
    <x-slot name="script">
        <script>
            // AJAX DataTables 
            var dataTable = $('#crudTable').DataTable({
                ajax : {
                    url : "{!! url()->current() !!}",
                },
                columns : [
                    {data : id, name: id, width : 10%},
                    {data : name, name: name, },
                    {
                        data : action, 
                        name : action, 
                        orderable : false, 
                        searchable : false, 
                        width : 25%
                    },
                ]
            });
        </script>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="mb-10"  style="margin-bottom: 2rem;">
                <a href="{{ route('dashboard.category.create') }}" class="text-white font-bold py-2 px-4 rounded bg-green hover:bg-green-600" style="background-color: green">+ New Category</a>
            </div>
            <div class="shadow overflow-hidden sm:rounded-md">
                <div class="px4 py-5 bg-white sm:p-6">
                    <table id="crudTable" class="w-full table-auto">
                        <thead>
                            <tr>
                                <th class="border px-6 py-4">#</th>
                                <th class="border px-6 py-4">Name</th>
                                <th class="border px-6 py-4">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse ($categories as $item)
                                <tr>
                                    <td class="border px-6 py-4">{{ $loop->iteration }}</td>
                                    <td class="border px-6 py-4">{{ $item->name }}</td>
                                    <td class="border px-6 py-4">
                                        <a class="inline-block border border-gray-700 bg-gray-700 text-white rounded-md px-2 py-1 m-1 transition duration-500 ease select-none hover:bg-gray-800 focus:outline-none focus:shadow-outline" href="{{route('dashboard.category.edit', $item->id)}}">
                                            Edit</a>
                                            <form class="inline-block" action="{{ route('dashboard.category.destroy', $item->id) }}" method="POST" style="display: inline-block">
                                                {!! method_field('delete') . csrf_field() !!}
                                                <button class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 mx-2 rounded inline-block" style="background-color: red; color: white; display:inline-block" >
                                                    Hapus
                                                </button>
                                            </form>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="3" class="border px-6 py-4">
                                        Tidak Ada Data
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</x-app-layout> --}}

@extends('layouts.main')

@section('content')
<div class="py-8" >
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 py-8 bg-white rounded shadow">
        <table class="table table-striped">
            <thead>
                <th class="text-center">Order ID</th>
                <th class="text-center">Date</th>
                <th class="text-center">Name</th>
                <th class="text-center">Total</th>
                <th class="text-center">Status</th>
                <th class="text-center">Action</th>
            </thead>
            <tbody>
                @forelse ($transactions as $item)
                    <tr>
                        <td class="text-center">{{ $item->order_id }}</td>
                        <td class="text-center">{{ $item->created_at }}</td>
                        <td class="text-center">{{ $item->user->name }}</td>
                        <td class="text-center">Rp {{ number_format($item->total) }}</td>
                        <td class="text-center">{{ $item->status }}</td>
                        <td class="text-center">
                            <a class="inline-block btn btn-info mr-2" href="{{route('dashboard.transaction.show', $item->id)}}">
                                See</a>
                                {{-- <form class="inline-block" action="{{ route('dashboard.transaction.destroy', $item->id) }}" method="POST" style="display: inline-block">
                                    {!! method_field('delete') . csrf_field() !!}
                                    <button class="btn btn-danger inline-block" onclick="return confirm('Apakah Anda yakin ingin menghapus transaksi ini?');">
                                        Hapus
                                    </button>
                                </form> --}}
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="6" class="text-center">Data Kosong</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>
</div>
    
@endsection