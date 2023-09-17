import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './categoryModel.dart';
import 'dart:convert';

class CategoryProvider with ChangeNotifier {
  String baseUrl = 'http://34.100.212.22/';
  List<dynamic> _categoryList = [];
  List<dynamic> _list = [];

  List<dynamic> get categoryList {
    return [..._categoryList];
  }

  Future<void> getCategories() async {
    final url = Uri.parse(baseUrl + 'api/category-list/');
    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    _categoryList = json.decode(response.body);
    print(_categoryList);
  }
}
