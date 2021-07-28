import 'dart:convert';
import 'package:aduaba_app/model/order_item.dart';
import 'package:aduaba_app/utilities/app_url.dart';
import 'package:aduaba_app/utilities/shared_preference.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  List<OrderItem> orderItemList = [];

  Future<List<OrderItem>> getAllOrders() async {
    await Future.delayed(Duration(seconds: 5));
    String token = await UserPreferences().getToken();

    final getOrderItems = await http.get(AppUrl.vieworder, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // print(getOrderItems.statusCode);
    final List responseBody = jsonDecode(getOrderItems.body);
    var result = responseBody.map((e) => OrderItem.fromJson(e)).toList();
    // print(result);
    return result;
  }

  Future<void> addOrder({
    itemTotal,
    totalAmount,
    payStackRef,
    address,
    status,
  }) async {
    Map<String, dynamic> apiBodyData;
    await Future.delayed(Duration(seconds: 5));
    if (payStackRef != null) {
      apiBodyData = {
        "totalNoOfCartItem": itemTotal,
        "totalAmount": totalAmount,
        "paystackRefNo": payStackRef,
        "address": address,
        "statusOfDelivery": status
      };
    } else {
      apiBodyData = {
        "totalNoOfCartItem": itemTotal,
        "totalAmount": totalAmount,
        "paystackRefNo": payStackRef,
        "address": address,
        "statusOfDelivery": status
      };
    }
    print("add order");
    String token = await UserPreferences().getToken();
    try {
      final response = await http
          .post(AppUrl.order, body: json.encode(apiBodyData), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        print("add order done");
      } else {
        print("add order fail");
        print(response.body);
      }
    } catch (error) {
      print("add order error");
      print(error.toString());
    }
    notifyListeners();
  }

  Future<void> removeOrder({String orderId, product}) async {
    String token = await UserPreferences().getToken();
    final client = http.Client();
    final url = Uri.parse(AppUrl.baseUrl + "/cancel-order?orderId=$orderId");
    final request = http.Request("DELETE", url);
    try {
      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final response = await request.send();
      if (response.statusCode == 200) {
        print("remove successful");
      } else {
        print("remove failed");
        print(response.stream.bytesToString());
      }
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
    notifyListeners();
  }
}
