import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoemania/models/address_model.dart';
import 'package:shoemania/utils/app_const.dart';

class AddressProvider with ChangeNotifier {
  List<Address> _addresses = [];
  List<Address> get addresses => [..._addresses];

  set setAddress(List<Address> data) {
    _addresses = data;
    notifyListeners();
  }

  // set setAddressWhere(Address data, int id) {
  //   _addresses.firstWhere((element) => false)
  // }

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

        _addresses = address;
        notifyListeners();
        print(_addresses[0].address);
      } else {
        print(response["meta"]['message']);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
