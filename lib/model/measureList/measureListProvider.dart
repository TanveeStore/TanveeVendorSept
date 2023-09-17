import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MeasureListProvider with ChangeNotifier {
  String baseUrl = 'http://34.100.212.22/';
  List<dynamic> _measureList = [];

  List<dynamic> get measureList {
    return [..._measureList];
  }

  Future<void> getMeasureList() async {
    final url = Uri.parse(baseUrl + 'api/product/unit-of-measure-list/');

    final response = await http.get(url);

    final res = json.decode(response.body);

    _measureList = res;

    print('Measure List: $_measureList');
  }
}
