import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoemania/models/transaction_model.dart';
import 'package:shoemania/utils/app_const.dart';

class OrderProvider with ChangeNotifier {
  List<Transaction> _orders = [];
  List<Transaction> _pastorders = [];
  List<Transaction> _onprogress = [];
  List<Transaction> _pendingOrders = [];
  List<Transaction> _onProcessOrders = [];
  List<Transaction> _onDeliveryOrders = [];
  List<Transaction> _successOrders = [];
  List<Transaction> _cancelledOrders = [];
  List<Transaction> get orders => [..._orders];
  List<Transaction> get pastOrders => [..._pastorders];
  List<Transaction> get onProgress => [..._onprogress];
  List<Transaction> get pendingOrders => [..._pendingOrders];
  List<Transaction> get onProcessOrders => [..._onProcessOrders];
  List<Transaction> get onDeliveryOrders => [..._onDeliveryOrders];
  List<Transaction> get successOrders => [..._successOrders];
  List<Transaction> get cancelledOrders => [..._cancelledOrders];

  Future<void> getMyOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer $token",
      "Accept": "application/json"
    };
    try {
      final request = await http.get(Uri.parse(BaseURL + "/transactions"),
          headers: headers);
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        List<Transaction> order = [];
        List<Transaction> pending = [];
        List<Transaction> ondelivery = [];
        List<Transaction> onprocess = [];
        List<Transaction> success = [];
        List<Transaction> cancelled = [];
        List parsedJson = response["data"];

        parsedJson.forEach((element) {
          order.add(Transaction.fromJson(element));
        });

        order.forEach((element) {
          if (element.status == "PENDING") {
            pending.add(element);
          }
          if (element.status == "ON_DELIVERY") {
            ondelivery.add(element);
          }
          if (element.status == "ON_PROCESS") {
            onprocess.add(element);
          }
          if (element.status == "SUCCESS") {
            success.add(element);
          }
          if (element.status == "CANCELED") {
            cancelled.add(element);
          }
        });
        _orders = order;
        _pendingOrders = pending;
        _onProcessOrders = onprocess;
        _onDeliveryOrders = ondelivery;
        _successOrders = success;
        _cancelledOrders = cancelled;
        notifyListeners();
      } else {
        print(response["meta"]["message"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getOrder(id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer $token",
      "Accept": "application/json"
    };
    try {
      final request = await http
          .get(Uri.parse(BaseURL + "/transactions?id=$id"), headers: headers);
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        var index = _orders.indexWhere((element) => element.id == id);
        _orders[index] = Transaction.fromJson(response["data"]);
        notifyListeners();
      } else {
        print(response["meta"]["message"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Transaction?> checkout(
      int addressId, int subtotal, int shipping, int total) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };
    var body = {
      "address_id": addressId,
      "subtotal": subtotal,
      "shipping": shipping,
      "total": total,
      "status": "PENDING"
    };
    Transaction? transaction;
    try {
      final request = await http.post(Uri.parse(BaseURL + "/checkout"),
          headers: headers, body: jsonEncode(body));
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        transaction = Transaction.fromJson(response["data"]);
        _orders.add(Transaction.fromJson(response["data"]));
        notifyListeners();
        return transaction;
      } else {
        print(response["meta"]["message"]);
        return transaction;
      }
    } catch (e) {
      print(e.toString());
      return transaction;
    }
  }

  Future<int> confirmOrder(int orderId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("token") ?? "";
    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    var order = _orders.firstWhere((element) => element.id == orderId);
    var orderIndex = _orders.indexWhere((element) => element.id == orderId);
    var onprogressIndex =
        _onprogress.indexWhere((element) => element.id == orderId);

    try {
      final request = await http.patch(
          Uri.parse(BaseURL + "/transaction/confirm/$orderId"),
          headers: headers);
      var response = jsonDecode(request.body);
      if (request.statusCode == 200) {
        // _orders[orderIndex] = Data.fromJson(response["data"]);
        _orders[orderIndex] = Transaction(
          id: order.id,
          orderId: order.orderId,
          userId: order.userId,
          addressId: order.addressId,
          subtotal: order.subtotal,
          total: order.total,
          status: "SUCCESS",
          paymentUrl: order.paymentUrl,
          receipt: order.receipt,
          createdAt: order.createdAt,
          updatedAt: order.updatedAt,
          deletedAt: order.deletedAt,
          items: order.items,
          address: order.address,
          user: order.user,
        );
        _successOrders.add(Transaction(
          id: order.id,
          orderId: order.orderId,
          userId: order.userId,
          addressId: order.addressId,
          subtotal: order.subtotal,
          total: order.total,
          status: "SUCCESS",
          paymentUrl: order.paymentUrl,
          receipt: order.receipt,
          createdAt: order.createdAt,
          updatedAt: order.updatedAt,
          deletedAt: order.deletedAt,
          items: order.items,
          address: order.address,
          user: order.user,
        ));
        // _pastorders.add(Data.fromJson(response["data"]));
        _onDeliveryOrders.removeWhere((element) => element.id == orderId);
        notifyListeners();
        return 200;
      } else {
        print(response["meta"]["message"]);
        return 400;
      }
    } catch (e) {
      print(e.toString());
      return 500;
    }
  }
}
