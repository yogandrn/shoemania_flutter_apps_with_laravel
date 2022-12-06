<x-app-layout>

    <div class="py-12">
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

    <form action="{{ route('dashboard.category.store') }}" method="POST">
        @csrf
        {{-- <input type="text" minlength="3" maxlength="255" required placeholder="Type New Category" id="name" name="name"> --}}
        {{-- Form Nama  --}}
        <div class="flex flex-wrap -mx-3 mb-6 ">
            <label for="name" class="block tracking-wide text-grey-700 text-s font-bold mb-2">Name</label>
            <input type="text" value="{{ old('name') }}" class="appearance-none block w-full bg-grey text-grey-700 border border-grey-700 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="name" name="name" placeholder="Type new category" required>
        </div>
    </form>
        </div>
        
    </div>
    
</x-app-layout>