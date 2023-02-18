import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoemania/models/cart_model.dart';
import 'package:shoemania/models/shipping_model.dart';
import 'package:shoemania/utils/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class CartProvider with ChangeNotifier {
  List<Carts> _carts = [];
  List<Carts> get carts => [..._carts];
  int _subtotal = 0;
  int get subtotal => _subtotal;
  int _weight = 0;
  int get weight => _weight;
  Shipping? _shipping;
  Shipping get shipping =>
      _shipping ?? Shipping(name: "JNE REG", cost: 0, estimation: "0");

  Future<void> getCarts() async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
    };
    try {
      final res =
          await http.get(Uri.parse(BaseURL + "/carts"), headers: headers);
      if (res.statusCode == 200) {
        final responses = jsonDecode(res.body);
        List<Carts> carts = <Carts>[];
        List parsedJson = responses['carts'];
        _subtotal = responses["subtotal"];
        _weight = responses["weight"];

        parsedJson.forEach((element) {
          carts.add(Carts.fromJson(element));
        });

        _carts = carts;
        notifyListeners();
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> addtoCart(int productId, int qty) async {
    String url = "";
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    int user = preferences.getInt("user_id") ?? 0;
    print(user.toString());
    try {
      var headers = {
        "Authorization": "Bearer " + token,
        "Content-Type": "application/json"
      };
      var body = {"user_id": user, "product_id": productId, "quantity": qty};

      var check =
          _carts.firstWhereOrNull((cart) => cart.productId == productId);

      // if (check!.quantity + qty == check.product!.stock) {

      // }

      if (check != null) {
        print(check.id.toString());
        url = BaseURL + "/cart/${check.id}/update";
        final request = await http.post(Uri.parse(url),
            body: jsonEncode(body), headers: headers);
        if (request.statusCode == 200) {
          final index = _carts.indexWhere((element) => element.id == check.id);
          _carts[index] = Carts(
              id: check.id,
              userId: check.userId,
              productId: check.productId,
              quantity: check.quantity! + qty,
              createdAt: check.createdAt,
              updatedAt: check.updatedAt,
              product: check.product);
          notifyListeners();
          return true;
        } else {
          print(jsonEncode(request));
          return false;
        }
      } else {
        url = BaseURL + "/cart/add";
        final request = await http.post(Uri.parse(url),
            body: jsonEncode(body), headers: headers);
        if (request.statusCode == 200) {
          // _carts.add(Carts())
          getCarts();
          notifyListeners();
          return true;
        } else {
          print(jsonEncode(request.body));
          return false;
        }
      }
      // print(url);
      // final request = await http.post(Uri.parse(url),
      //     body: jsonEncode(body), headers: headers);
      // if (request.statusCode == 200) {
      //   getCarts();
      //   return true;
      // } else {
      //   return false;
      // }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<int> updateCart(cartId, int qty) async {
    var body = {"quantity": qty};
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
      "Content-Type": "application/json"
    };
    try {
      final request = await http.post(
          Uri.parse(BaseURL + "/cart/$cartId/update"),
          body: jsonEncode(body),
          headers: headers);
      if (request.statusCode == 200) {
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      return 500;
    }
  }

  Future<dynamic> shipmentRate(String postalCode) async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
      "Content-Type": "application/json"
    };
    var body = {"postal_code": postalCode, "weight": "$_weight"};
    try {
      final request = await http.post(Uri.parse(BaseURL + "/shipping"),
          body: jsonEncode(body), headers: headers);
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        Shipping shipping = Shipping.fromJson(response["data"]);
        _shipping = shipping;
        notifyListeners();
        print(shipping.cost.toString());
        return shipping.cost;
      } else {
        print(response["meta"]["message"]);
        return response["meta"]["message"];
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<bool> increment(int id) async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
    };
    var cart = _carts.firstWhere((element) => element.id == id);
    final index = _carts.indexWhere((element) => element.id == id);
    try {
      final request = await http
          .post(Uri.parse(BaseURL + "/cart/$id/increment"), headers: headers);
      if (request.statusCode == 200) {
        _subtotal += cart.product!.price!;
        _weight += cart.product!.weight!;
        _carts[index] = Carts(
            id: cart.id,
            userId: cart.userId,
            productId: cart.productId,
            quantity: cart.quantity! + 1,
            createdAt: cart.createdAt,
            updatedAt: cart.updatedAt,
            product: cart.product);
        notifyListeners();
        return true;
      } else {
        print(jsonDecode(request.body));
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> decrement(int id) async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
    };
    var cart = _carts.firstWhere((element) => element.id == id);
    final index = _carts.indexWhere((element) => element.id == id);
    try {
      final request = await http
          .post(Uri.parse(BaseURL + "/cart/$id/decrement"), headers: headers);
      if (request.statusCode == 200) {
        _subtotal -= cart.product!.price!;
        _weight -= cart.product!.weight!;
        _carts[index] = Carts(
            id: cart.id,
            userId: cart.userId,
            productId: cart.productId,
            quantity: cart.quantity! - 1,
            createdAt: cart.createdAt,
            updatedAt: cart.updatedAt,
            product: cart.product);
        notifyListeners();
        return true;
      } else {
        print(jsonDecode(request.body));
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteCart(int id) async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer " + token,
    };
    var cart = _carts.firstWhere((element) => element.id == id);
    try {
      final request =
          await http.delete(Uri.parse(BaseURL + "/cart/$id"), headers: headers);
      if (request.statusCode == 200) {
        _subtotal -= cart.product!.price! * cart.quantity!;
        _weight -= cart.product!.weight! * cart.quantity!;
        _carts.removeWhere((element) => element.id == id);
        notifyListeners();
        return true;
      } else {
        print(jsonDecode(request.body));
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Future getMyCarts() async {
  //   try {
  //     final response =
  //         await http.get(Uri.parse(BaseURL + "/carts"), headers: _headers);
  //     if (response.statusCode == 200) {
  //       List<Carts> carts = [];
  //       final responses = json.decode(response.body);
  //       List parsedJson = responses['data'];
  //       // if (parsedJson.isEmpty) {
  //       //   return;
  //       // }

  //       parsedJson.forEach((element) {
  //         carts.add(Carts.fromJson(element));
  //       });
  //       print(carts.toString());
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
