import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderSummaryProvider with ChangeNotifier {
  String baseUrl = 'http://34.100.212.22/';
  Map<String, dynamic> _orderList = {};
  Map<String, dynamic> _orderRecent = {};
  Map<String, dynamic> _orderDetails = {};

  Map<String, dynamic> get orderList {
    return {..._orderList};
  }

  Map<String, dynamic> get orderRecent {
    return {..._orderRecent};
  }

  Map<String, dynamic> get orderDetails {
    return {..._orderDetails};
  }

  Future<void> getOrderHistory() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/order/history/');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    var res = json.decode(response.body);

    _orderList = res;

    print('Order History: $_orderList');
  }

  Future<void> getRecentOrder() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/order/recent/');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    var res = json.decode(response.body);

    if (res['data'].length > 0) {
      _orderRecent = res;
    } else {
      _orderRecent = {'data': []};
    }

    print('Recent Order: $_orderRecent');
  }

  Future<void> getOrderDetails(String id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/order/details/$id/');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    var res = json.decode(response.body);

    _orderDetails = res;

    print('Order Details: $_orderDetails');
  }
}
