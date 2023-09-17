import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SizeListProvider with ChangeNotifier {
  String baseUrl = 'http://34.100.212.22/';
  List<dynamic> _sizeList = [];

  List<dynamic> get sizeList {
    return [..._sizeList];
  }

  Future<void> getSizeList() async {
    final url = Uri.parse(baseUrl + 'api/product/size-list/');

    final response = await http.get(url);

    final res = json.decode(response.body);

    _sizeList = res;

    print('Size List $_sizeList');
  }
}
