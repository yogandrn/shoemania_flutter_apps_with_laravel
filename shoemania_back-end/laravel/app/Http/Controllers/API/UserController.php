<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Cart;
use App\Models\Transaction;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Laravel\Fortify\Rules\Password;
use File;
use Storage;

class UserController extends Controller
{
    public function register(Request $request)
    {
        try {
            $validated = Validator::make($request->all(),
            [
                'name' => ['required', 'string'],
                'email' => ['required', 'string', 'unique:users', 'email:dns'],
                // 'username' => ['required', 'string', 'unique:users'],
                'phone_number' => ['required', 'string', 'unique:users'],
                'password' => ['required', 'string', new Password],
            ]);
            if ($validated->fails()) {
                $error = $validated->errors()->toArray();
                // if ($error['username'][0] != null ) {
                //     return ResponseFormatter::error(null, 'Username is taken', 400);
                // }
                // if ($error['email'][0] != null) {
                //     return ResponseFormatter::error(null, 'Email is taken', 400);
                // }
                return ResponseFormatter::error(null,$validated->errors(), 401 );
            }

            User::create([
                'name' => $request->name,
                // 'username' => $request->username,
                'email' => $request->email,
                'phone_number' => $request->phone_number,
                'password' => Hash::make($request->password)
            ]);

            $user = User::where('email', $request->email)->with(['address'])->first();

            $tokenResult = $user->createToken('authToken')->plainTextToken;

            return ResponseFormatter::success([
                'access_token' => $tokenResult,
                'token_type' => 'Bearer',
                'user' => $user,
                  "carts" => 0,
                "orders" => 0
            ], 'Register Success', 200);

        } catch(Exception $e) {
            return ResponseFormatter::error(null, $e->getMessage(), 500);
        }
    }

    public function login(Request $request)
    {
        try {
            $request->validate([
                'email' => 'email|required',
                'password' => 'required'
            ]);

            $user = User::where('email', $request->email)->count();
            if ($user == 0) {
                return ResponseFormatter::error(['message' => 'Unregistered'], 'Email tidak ditemukan!' , 404);
            }

            $credentials = request(['email', 'password']);
            if (!Auth::attempt($credentials)) {
                return ResponseFormatter::error(null, 'Authentication Failed', 403);
            }

            $user = User::where('email', $request->email)->with(['address'])->first();

            if ( ! Hash::check($request->password, $user->password, [])) {
                throw new \Exception('Invalid Credentials');
            }
            $carts = Cart::where('user_id', $user->id)->count();
            $orders = Transaction::where('user_id', $user->id)->count();

            $tokenResult = $user->createToken('authToken')->plainTextToken;
            return ResponseFormatter::success([
                'access_token' => $tokenResult,
                'token_type' => 'Bearer',
                'user' => $user,
                "carts" => $carts,
                "orders" => $orders
            ],'Authenticated');
          

        } catch(Exception $e) {
            return ResponseFormatter::error([
                'message' => 'Something went wrong',
                'error' => $e->getMessage(),
            ],'Authentication Failed', 500);
        }
    }

    public function fetch(Request $request)
    {
        $carts = Cart::where('user_id', $request->user()->id)->count();
        $orders = Transaction::where('user_id', $request->user()->id)->count();
        $user = User::where('id', $request->user()->id)->with(['address'])->first();
        try {
            return ResponseFormatter::success(["user" => $user, "carts" => $carts, "orders" => $orders], 'Data user berhasil diambil', 200);
        } catch (Exception $error) {
            return ResponseFormatter::error(null, $error->getMessage(), 400);
        }
    }

    public function updateProfile(Request $request)
    {
        try {
            $user = Auth::user();
            $data = $request->all();
            $validator = Validator::make($request->all(), [
                'name' => ['string', 'required'],
                // 'username' => ['string', 'required', Rule::unique('users')->ignore($user->id)],
                'email' => ['string', 'required', 'email:dns', Rule::unique('users')->ignore($user->id)],
                'phone_number' => ['string', 'required', Rule::unique('users')->ignore($user->id)]
            ]);
    
            if ($validator->fails()) {
                return ResponseFormatter::error(null, $validator->errors(), 400);
            }
    
            
            $user->update($data);
            return ResponseFormatter::success($user, 'Data berhasil diupdate', 200);
        
        } catch(Exception $error) {
            return ResponseFormatter::error(null, $error->getMessage(), 400);
        }
    }
    
    public function editPhoto(Request $request)
    {
      try {
          
          $validated = $request->validate([
              'image' => 'required|image',
              ]);
          $user = Auth::user();

        $filestoDelete = $user->profile_photo_path;
        if ($request->file('image')) {
            $new_photo_profile = $request->file('image')->store('assets/user/' . date('Y') . "/", 'public');
            if ($filestoDelete != 'assets/user/default_user.png') {
               // File::delete(public_path('storage/'.$user->image));
               // unlink(public_path('storage/'.$user->image));
               Storage::delete('/laravel/storage/app/public/' . $filestoDelete);
            }
         }
        User::where('id', $user->id)->update(['profile_photo_path' => $new_photo_profile]);
        return ResponseFormatter::success(Auth::user, 'Photo profile successfully updated', 200);
      } catch (Exception $e) {
         return ResponseFormatter::error(Auth::user(), $e->getMessage(), 400);
         
      }
    }
    
    public function updatePhoto(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'file' => 'required|image',
        ]);

        if ($validator->fails()) {
            return ResponseFormatter::error(['error'=>$validator->errors()], 'Update Photo Fails', 401);
        }

        if ($request->file('file')) {

            $file = $request->file->store('assets/user/' . date('Y') . "/", 'public');

            //store your file into database
            $user = Auth::user();
            if ($user->profile_photo_path != 'assets/user/default_user.png') {
                // File::delete('/shoemania/laravel/storage/app/public/'.$user->profile_photo_path);
                Storage::delete('public/'.$user->profile_photo_path);
                // Storage::delete($user->profile_photo_path);
            }
            $user->profile_photo_path = $file;
            $user->update();

            return ResponseFormatter::success($user,'File successfully uploaded');
        }
    }

    public function logout(Request $request)
    {
        try {
            $token = $request->user()->currentAccessToken()->delete();
            return ResponseFormatter::success($token, 'Token Revoked'. 200);
        } catch (Exception $error) {
            return ResponseFormatter::error(false, $error->getMessage(), 400);
        }
    }
}
