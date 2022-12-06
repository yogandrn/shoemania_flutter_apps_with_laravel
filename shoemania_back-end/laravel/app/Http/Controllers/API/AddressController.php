<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Http\Requests\AddressRequest;
use App\Models\Address;
use Illuminate\Http\Request;
use Exception;

class AddressController extends Controller
{
    public function all(Request $request)
    {
        try {
            $address = Address::where('user_id', $request->user()->id)->get();
            return ResponseFormatter::success($address, "Successfully fetch address", 200);
        } catch (Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);
        }
    }
    
    public function create(AddressRequest $request)
    {
        $data = $request->all();
        try {
            Address::create($data);
            return ResponseFormatter::success(null, "Successfully add new address", 200);
        } catch(Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);
        }
    }
    
    public function update(AddressRequest $request, $id)
    {
        $data = $request->all();
        try {
            Address::where('id', $id)->update($data);
            return ResponseFormatter::success(null, "Successfully update address", 200);
        } catch(Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);
        }
    }

    public function destroy($id)
    {
        try {
            Address::destroy($id);
            return ResponseFormatter::success(null, 'Successfully delete address', 200);
        } catch(Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 400);
        }
    }
}
