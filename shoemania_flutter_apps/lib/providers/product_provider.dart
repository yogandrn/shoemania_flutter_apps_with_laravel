import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoemania/models/product_model.dart';

import 'package:shoemania/utils/app_const.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => [..._products];
  List<Product> _popularProducts = [];
  List<Product> get popularProducts => [..._popularProducts];
  List<Product> _newProducts = [];
  List<Product> get newProducts => [..._newProducts];
  List<Product> _searchedProducts = [];
  List<Product> get searchedProducts => [..._searchedProducts];

  Future<void> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(BaseURL + "/products"));
      if (response.statusCode == 200) {
        List<Product> products = [];
        final responses = jsonDecode(response.body);
        List parsedJson = responses['data'];
        // if (parsedJson.isEmpty) {
        //   return;
        // }

        parsedJson.forEach((element) {
          products.add(Product.fromJson(element));
        });
        _products = products;
        print(products);
        notifyListeners();
      } else {
        print(response.body.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getPopularProducts() async {
    try {
      final response = await http.get(Uri.parse(BaseURL + "/products/popular"));
      if (response.statusCode == 200) {
        List<Product> popularProducts = [];
        final responses = jsonDecode(response.body);
        List parsedJson = responses['data'];
        // if (parsedJson.isEmpty) {
        //   return;
        // }

        parsedJson.forEach((element) {
          popularProducts.add(Product.fromJson(element));
        });
        _popularProducts = popularProducts;
        notifyListeners();
      } else {
        print(response.body.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getNewProducts() async {
    try {
      final response = await http.get(Uri.parse(BaseURL + "/products/new"));
      if (response.statusCode == 200) {
        List<Product> newProducts = [];
        final responses = jsonDecode(response.body);
        List parsedJson = responses['data'];
        // if (parsedJson.isEmpty) {
        //   return;
        // }

        parsedJson.forEach((element) {
          newProducts.add(Product.fromJson(element));
        });
        _newProducts = newProducts;
        notifyListeners();
      } else {
        print(response.body.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Product>> searchProduct(String keyword) async {
    try {
      final response =
          await http.get(Uri.parse(BaseURL + "/products?search=$keyword"));
      if (response.statusCode == 200) {
        List<Product> products = [];
        final responses = jsonDecode(response.body);
        List parsedJson = responses['data'];
        // if (parsedJson.isEmpty) {
        //   return;
        // }

        parsedJson.forEach((element) {
          products.add(Product.fromJson(element));
        });
        _searchedProducts = products;
        notifyListeners();
        return products;
      } else {
        print(response.body.toString());
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<void> getProduct(id) async {
    try {
      final request = await http.get(Uri.parse(BaseURL + "/products?id=$id"));
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        var index = _products.indexWhere((element) => element.id == id);
        _products[index] = Product.fromJson(response["data"]);
        notifyListeners();
      } else {
        print(response["meta"]["message"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
