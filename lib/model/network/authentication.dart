import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Authentication with ChangeNotifier {
  String baseUrl = 'http://34.100.212.22/';

  dynamic signUp(data, url) async {
    final fullUrl = Uri.parse(baseUrl + url);
    return await http.post(fullUrl,
        body: json.encode(data), headers: {'Content-Type': 'application/json'});
  }

  dynamic signIn(data, url) async {
    final fullUrl = Uri.parse(baseUrl + url);
    return await http.post(fullUrl,
        body: json.encode(data), headers: {'Content-Type': 'application/json'});
  }

  dynamic forgotPassword(data, url) async {
    final fullUrl = Uri.parse(baseUrl + url);
    return await http.post(fullUrl,
        body: json.encode(data), headers: {'Content-Type': 'application/json'});
  }

  dynamic resetPassword(data, url) async {
    var uri = baseUrl + url;
    print("Url ${uri}");
    final fullUrl = Uri.parse(uri);
    return await http.post(fullUrl,
        body: json.encode(data), headers: {'Content-Type': 'application/json'});
  }

  dynamic changePassword(data, url) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final fullUrl = Uri.parse(baseUrl + url);
    return await http.post(fullUrl, body: json.encode(data), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });
  }
}
