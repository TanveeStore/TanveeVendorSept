import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatusProvider with ChangeNotifier {
  String baseUrl = 'http://34.100.212.22/';
  Map<String, dynamic> _profileStatus = {};

  Map<String, dynamic> get profileStatus {
    return {..._profileStatus};
  }

  Future<void> getStatus() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/profile/status/');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    _profileStatus = json.decode(response.body);

    print('Profile Status $_profileStatus');
  }
}
