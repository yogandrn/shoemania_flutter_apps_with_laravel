@extends('layouts.main')

@section('content')
    <div class="container  mt-6">
        <div class="">
            <a href="{{route('dashboard.category.create')}}" class="btn btn-success mt-4 mb-4">+ New Category</a>
        </div>
        <div class="shadow overflow-hidden sm:rounded-md">
            <div class="px-4 py-4 bg-white sm:p-6">
                <table class="table table-striped">
                    <thead>
                        <th>#</th>
                        <th>Category ID</th>
                        <th>Name</th>
                        <th>Action</th>
                    </thead>
                    <tbody>
                        @forelse ($categories as $item)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $item->id }}</td>
                                <td>{{ $item->name }}</td>
                                <td class="text-center">
                                    <a class="inline-block btn btn-info mr-2" href="{{route('dashboard.category.edit', $item->id)}}">
                                        Edit</a>
                                        <form class="inline-block" action="{{ route('dashboard.category.destroy', $item->id) }}" method="POST" style="display: inline-block">
                                            {!! method_field('delete') . csrf_field() !!}
                                            <button class="btn btn-danger inline-block" onclick="return(confirm('Apakah Anda yakin ingin menghapus Category ini?'));">
                                                Hapus
                                            </button>
                                        </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="3">Data Kosong</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        <div class="py-4 px-6">
            <table class="table table-bordered">
                <thead>
                    <th>#</th>
                    <th>Name</th>
                    <th>Action</th>
                </thead>
                <tbody>
                    @forelse ($categories as $item)
                        <tr>
                            <td>{{ $loop->iteration }}</td>
                            <td>{{ $item->name }}</td>
                            <td>{{ $item->name }}</td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="3">Data Kosong</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
@endsection