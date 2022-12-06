@extends('layouts.main')

@section('content')
    <div class="py-8" >
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 py-8 bg-white rounded shadow">
            {{-- <strong class="mb-4 text-xl">User Information</strong> --}}
            <div class="row">
                <div class="col-md-4  col-lg-4">
                    <p class="text-sm">Order ID</p>
                    <p class="text-lg">{{ $transaction->order_id }}</p>
                </div>
                <div class="col-md-4  col-lg-4">
                    <p class="text-sm">Tanggal</p>
                    <p class="text-lg">{{ $transaction->created_at }}</p>
                </div>
                <div class="col-md-4  col-lg-4">
                    <div class="row">
                        <div class="col-7">
                            <p class="text-sm">Status</p>
                            <strong class="text-lg">{{ $transaction->status }}</strong>
                        </div>
                        <div class="col-5">
                            <a href="{{ $transaction->payment_url }}" target="blank" class="btn btn-success">See Payment</a>
                        </div>
                    </div>
                </div>
            </div>
            <hr class="mt-6 mb-6">
            <div class="row">
                <div class="col-md-4 col-lg-4">
                    <p class="text-sm">User</p>
                    <p class="text-lg">{{ $transaction->user->name }}</p>
                    <p class="text-lg">{{ $transaction->user->email }}</p>
                </div>
                <div class="col-md-8  col-lg-8">
                    <p class="text-sm">Address</p>
                    <p class="text-lg">{{ $transaction->address->name . ' (' . $transaction->address->phone_number .')'}}</p>
                    <p class="text-lg">{{ $transaction->address->address }}</p>
                    <p class="text-lg">Kode Pos {{ $transaction->address->postal_code }}</p>
                </div>
            </div>
            <hr class="mt-6 mb-6">
            <p class="text-sm">Items</p>
            <div class="row justify-content-center">
                <div class="col-md-12  col-lg-12">
                    @foreach ($transaction->items as $item)
                        <div class="p-2 w-full row">
                            {{-- <div class="col-4">
                                <img src="{{ Storage::url($item['product']['galleries']['0']['image_url']) }}" alt="{{ $item->product->name }}">
                            </div> --}}
                            <div class="col-8">
                                <p class="text-md">{{ $item->product->name }}</p>
                            </div>
                            <div class="col-2">
                                <p class="text-md">{{ $item->quantity }}</p>
                            </div>
                            <div class="col-2 ">
                                <p class="text-md" >Rp {{ number_format($item->subtotal) }}</p>
                            </div>
                        </div>
                    @endforeach
                </div>
                {{-- <div class="col-md-4 col-lg-4">
                    <div class="row">
                        <div class="col-6">Subtotal Order</div>
                        <div class="col-6">{{ $transaction->subtotal }}</div>
                    </div>
                    <div class="row">
                        <div class="col-6">Shipping Price</div>
                        <div class="col-6">{{ $transaction->shipping }}</div>
                    </div>
                    <div class="row">
                        <div class="col-6">Shipping Price</div>
                        <div class="col-6">{{ $transaction->shipping }}</div>
                    </div>
                </div> --}}
            </div>
            <hr class="mt-6 mb-6">
            <div class="row w-full">
                <div class="col-10">
                    <p class="text-md">Subtotal Order</p>
                </div>
                <div class="col-2 text-md ">Rp {{ number_format($transaction->subtotal) }}</div>
            </div>
            <div class="row w-full">
                <div class="col-10">
                    <p class="text-md">Shipping Price</p>
                </div>
                <div class="col-2 text-md ">Rp {{ number_format($transaction->shipping) }}</div>
            </div>
            <hr class="mt-3 mb-3">
            <div class="row w-full">
                <div class="col-10">
                    <p class="text-md">Total</p>
                </div>
                <div class="col-2 text-md "><strong>Rp {{ number_format($transaction->total) }}</strong></div>
            </div>
            
        </div>
        @if ($transaction->status == 'ON_PROCESS')
            
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 py-8 bg-white rounded shadow mt-6">
            <div class="row justify-content-center">
                <div class="text-center">
                    <p class="text-md mb-3">Change Status</p>
                    <a href="{{ route('changeStatus', ['id' => $transaction->id, 'status' => 'ON_DELIVERY']) }}"
                        class="btn btn-primary mx-2"
                        onclick="return confirm('Ganti status transaksi menjadi ON_DELIVERY?');" >
                        On Delivery
                     </a>
                    <a href="{{ route('changeStatus', ['id' => $transaction->id, 'status' => 'CANCELLED']) }}"
                        class="btn btn-danger mx-2"
                        onclick="return confirm('Ganti status transaksi menjadi CANCELLED?');" >
                        Cancelled
                    </a>
                </div>
            </div>
            
        </div>
        @else 
        <div></div>
        @endif
    </div>
@endsection

