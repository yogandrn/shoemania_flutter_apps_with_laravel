{{-- <x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Dashboard') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <x-jet-welcome />
            </div>
        </div>
    </div>
</x-app-layout> --}}

@extends('layouts.main')

@section('content')
    <div class="container rounded shadow px-6 py-6">
        <div class="row">
            <div class="col-md-6 col-sm-10 col-lg-6">
                <div class="row">
                    <div class="col-4 " style="font-size: 5rem">
                        <i class="fa-solid fa-file-invoice-dollar"></i>
                    </div>
                    <div class="col-8">
                        <h5>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Commodi?</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-10 col-lg-6">
                Hello
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-sm-10 col-lg-6">
                Hello
            </div>
            <div class="col-md-6 col-sm-10 col-lg-6">
                Hello
            </div>
        </div>
    </div>
@endsection