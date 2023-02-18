import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoemania/models/address_model.dart';
import 'package:shoemania/models/user_model.dart';
import 'package:shoemania/utils/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuth = false;
  bool get isAuth => _isAuth;
  String _token = "";
  // String _token = "9|NWk41DEQU3DmgwUymq5BXuxPmpJ1LuKofPgBVUg6";
  String get token => _token;
  User? _user;
  List<Address> _address = [];
  List<Address> get addresses => [..._address];

  // User _user = User(
  //     id: 0,
  //     name: "Your name",
  //     email: "Your email address",
  //     phoneNumber: "",
  //     emailVerifiedAt: null,
  //     twoFactorConfirmedAt: null,
  //     currentTeamId: null,
  //     profilePhotoPath: "",
  //     roles: "USER",
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //     profilePhotoUrl:
  //         "https://shoemania.sipaling-ngoding.my.id/laravel/storage/app/public/assets/user/default_user.png");
  int _countCarts = 0;
  int _countOrders = 0;
  int get countCarts => _countCarts;
  int get countOrder => _countOrders;

  User get user =>
      _user ??
      User(
          id: 0,
          name: "...",
          email: "...",
          phoneNumber: "...",
          emailVerifiedAt: null,
          twoFactorConfirmedAt: null,
          currentTeamId: null,
          profilePhotoPath: "...",
          roles: "USER",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          profilePhotoUrl:
              "https://shoemania.sipaling-ngoding.my.id/laravel/storage/app/public/assets/user/default_user.png");

  set setAuth(bool value) {
    _isAuth = value;
    notifyListeners();
  }

  set setToken(String value) {
    _token = value;
    notifyListeners();
  }

  // set setUser(dynamic user) {
  //   _user.id = user["id"];
  //   _user.email = user["email"];
  //   _user.name = user["name"];
  //   _user.phoneNumber = user["phone_number"];
  //   _user.emailVerifiedAt = user["email_verified_at"];
  //   _user.twoFactorConfirmedAt = user["two_factor_confirmed_at"];
  //   _user.profilePhotoPath = user["profile_photo_path"];
  //   _user.profilePhotoUrl = user["profile_photo_url"];
  //   _user.roles = user["roles"];
  //   _user.createdAt = user["created_at"];
  //   _user.updatedAt = user["updated_at"];
  //   notifyListeners();
  // }

  Future<int> login(String email, String password) async {
    var body = {"email": email, "password": password};
    final request = await http.post(Uri.parse(BaseURL + "/login"),
        body: jsonEncode(body), headers: {"Content-Type": "application/json"});
    var response = json.decode(request.body);
    final preferences = await SharedPreferences.getInstance();
    try {
      if (request.statusCode == 200) {
        _isAuth = true;
        // Set Data User
        _user = User.fromJson(response["data"]["user"]);

        // Set Data Address
        List<Address> address = [];
        List parsedJson = response["data"]["user"]["address"];
        parsedJson.forEach((element) {
          address.add(Address.fromJson(element));
        });
        _address = address;

        preferences.setString('token', response["data"]["access_token"]);
        preferences.setBool('isAuth', true);
        preferences.setInt('user_id', response["data"]["user"]["id"]);
        _token = response["data"]["access_token"];
        apiToken = response["data"]["access_token"];
        _countCarts = response["data"]["carts"];
        _countOrders = response["data"]["orders"];
        notifyListeners();
        return 200;
      } else if (request.statusCode == 403) {
        return 403;
      } else if (request.statusCode == 404) {
        return 404;
      } else {
        return 500;
      }
    } catch (e) {
      print(e.toString());
      return 500;
    }
  }

  Future<int> register(
      String name, String phoneNumber, String email, String password) async {
    var body = {
      "name": "$name",
      "email": "$email",
      "phone_number": "$phoneNumber",
      "password": "$password"
    };
    final request = await http.post(Uri.parse(BaseURL + "/register"),
        body: jsonEncode(body), headers: {"Content-Type": "application/json"});
    var response = json.decode(request.body);
    final preferences = await SharedPreferences.getInstance();
    try {
      if (request.statusCode == 200) {
        _isAuth = true;
        _user = User.fromJson(response["data"]["user"]);

        // Set Data Address
        List<Address> address = [];
        List parsedJson = response["data"]["user"]["address"];
        parsedJson.forEach((element) {
          address.add(Address.fromJson(element));
        });
        _address = address;

        preferences.setString('token', response["data"]["access_token"]);
        preferences.setBool('isAuth', true);
        preferences.setInt('user_id', response["data"]["user"]["id"]);
        _token = response["data"]["access_token"];
        apiToken = response["data"]["access_token"];
        _countCarts = response["data"]["carts"];
        _countOrders = response["data"]["orders"];
        notifyListeners();
        return 200;
      } else if (response["meta"]["message"]["email"] != null) {
        print("Invalid");
        return 444;
      } else if (response["meta"]["message"]["phone_number"] != null) {
        print("tidak ditemukan");
        return 445;
      } else {
        print("Gagal Register");
        return 500;
      }
    } catch (e) {
      print(e.toString());
      return 500;
    }
  }

  Future<void> getUserData() async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
    };
    try {
      final request =
          await http.get(Uri.parse(BaseURL + "/user"), headers: headers);
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        print(response["data"]["user"]);
        _user = User.fromJson(response["data"]["user"]);
        // Set Data Address
        List<Address> address = [];
        List parsedJson = response["data"]["user"]["address"];
        parsedJson.forEach((element) {
          address.add(Address.fromJson(element));
        });
        _address = address;

        _countCarts = response["data"]["carts"];
        _countOrders = response["data"]["orders"];
        notifyListeners();
      } else {
        print(response["meta"]["message"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int> updateUser(String name, String email, String phoneNumber) async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
      "Content-Type": "application/json"
    };
    var body = {"name": name, "email": email, "phone_number": phoneNumber};
    try {
      final request = await http.post(Uri.parse(BaseURL + "/user/update"),
          body: jsonEncode(body), headers: headers);
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        _user = User.fromJson(response["data"]);
        notifyListeners();
        return 200;
      }
      if (request.statusCode == 400) {
        if (response['meta']['message']['email'] != null) {
          print(response['meta']['message']);
          return 480;
        }
        if (response['meta']['message']['phone_number'] != null) {
          print(response['meta']['message']);
          return 450;
        }
      }
      return 500;
    } catch (e) {
      print(e.toString());
      return 500;
    }
  }

  Future<int> updatePhotoProfile(filepath) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer $token",
    };
    try {
      var request = await http.MultipartRequest(
          'POST', Uri.parse(BaseURL + "/user/update/photo"));
      request.files.add(await http.MultipartFile.fromPath('file', filepath));
      request.headers.addAll(headers);
      final res = await request.send();
      final response = await http.Response.fromStream(res);
      final responsed = jsonDecode(response.body);
      if (res.statusCode == 200) {
        _user = User.fromJson(responsed["data"]);
        notifyListeners();
        return 200;
      } else {
        print(responsed['meta']['message']);
        return 400;
      }
    } catch (e) {
      print(e.toString());
      return 500;
    }
  }

  Future<void> getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer $token",
      "Accept": "application/json"
    };
    try {
      final request =
          await http.get(Uri.parse(BaseURL + "/address"), headers: headers);
      final response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        List<Address> address = [];
        List parsedJson = response["data"];

        parsedJson.forEach((element) {
          address.add(Address.fromJson(element));
        });

        _address = address;
        notifyListeners();
      } else {
        print(response["meta"]['message']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> addAddress(String name, String phoneNumber, String address,
      String postalCode) async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var userId = preferences.getInt("user_id") ?? 0;
    var headers = {
      "Authorization": "Bearer " + token,
      "Content-Type": "application/json"
    };
    var body = {
      "user_id": userId,
      "name": name,
      "address": address,
      "postal_code": postalCode,
      "phone_number": phoneNumber
    };
    try {
      final request = await http.post(Uri.parse(BaseURL + "/address/add"),
          body: jsonEncode(body), headers: headers);
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        getUserData();
        return true;
      } else {
        print(response["meta"]["message"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateAddress(int addressId, String name, String phoneNumber,
      String new_address, String postalCode) async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
      "Content-Type": "application/json"
    };
    var body = {
      "name": name,
      "address": new_address,
      "postal_code": postalCode,
      "phone_number": phoneNumber
    };
    try {
      var address = _address.firstWhere((element) => element.id == addressId);
      var index = _address.indexWhere((element) => element.id == addressId);
      final request = await http.post(
          Uri.parse(BaseURL + "/address/$addressId/update"),
          body: jsonEncode(body),
          headers: headers);
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        _address[index] = Address(
            id: address.id,
            userId: address.userId,
            name: name,
            phoneNumber: phoneNumber,
            address: new_address,
            postalCode: postalCode,
            deletedAt: address.deletedAt,
            createdAt: address.createdAt,
            updatedAt: address.updatedAt);
        notifyListeners();
        return true;
      } else {
        print(response["meta"]["message"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteAddress(int addressId) async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
    };

    try {
      final request = await http
          .delete(Uri.parse(BaseURL + "/address/$addressId"), headers: headers);
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        _address.removeWhere((element) => element.id == addressId);
        notifyListeners();
        return true;
      } else {
        print(response["meta"]["message"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
    };
    try {
      final request =
          await http.post(Uri.parse(BaseURL + "/logout"), headers: headers);
      final response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        _address = [];
        _token = "";
        _user = null;
        _countCarts = 0;
        _countOrders = 0;
        preferences.remove("token");
        preferences.remove("user_id");
        preferences.remove("isAuth");
        preferences.clear();
        notifyListeners();
        return true;
      } else {
        print(response["meta"]["message"]);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
