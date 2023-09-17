import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import './productsModel.dart';

class ProductsProvider with ChangeNotifier {
  String baseUrl = 'http://34.100.212.22/';
  Map<String, dynamic> _vendorProductFullList = {};

  Map<String, dynamic> _vendorProductList = {};

  Map<String, dynamic> get vendorProducts {
    // return {..._vendorProductFullList};
    return {..._vendorProductList};
  }

  Future<void> postItem(
      String? name,
      String? shortDescription,
      String? description,
      String? status,
      String? weight,
      String? quantity,
      String? price,
      String? tax,
      File? image,
      String? category,
      String? size,
      String? uom,
      String offerPrice) async {
    print(name);
    print(shortDescription);
    print(description);
    print(status);
    print(weight);
    print(quantity);
    print(price);
    print(tax);
    print(image);
    print(category);
    print(size);
    print(uom);
    // print(object);

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/product/');
    var request = http.MultipartRequest('POST', url);
    request.headers
        .addAll({'Authorization': 'Bearer ${localStorage.getString('token')}'});
    request.fields['name'] = name!;
    request.fields['short_description'] = shortDescription!;
    request.fields['description'] = description!;
    request.fields['status'] =
        status == 'Available' ? 'in_stock' : 'out_of_stock';
    request.fields['weight'] = weight!;
    request.fields['qty'] = quantity!;
    request.fields['price'] = price!;
    request.fields['tax'] = tax!;
    request.files.add(await http.MultipartFile.fromPath(
        'main_image', image!.path,
        contentType: MediaType('application', 'x-tar')));
    request.fields['category'] = category!;
    request.fields['sizes'] = size!;
    request.fields['uom'] = uom!;
    request.fields['discount_price'] = offerPrice;
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded');
    } else {
      print('Response Code ${response.statusCode}');
    }
  }

  Future<void> getProducts() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/product/');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });
    // ProductsModel productsModel = productsModelFromJson(response.body);
    // _vendorProducts = productsModel.toJson();
    // print('Vendor Products: $_vendorProducts');
    _vendorProductFullList = json.decode(response.body);
    print('Vendor Products: $_vendorProductFullList');
    searchProduct("");
  }

  searchProduct(String query) {
    _vendorProductList["data"] = _vendorProductFullList["data"].where((e) =>
        // "${e["name"]} ${e["description"]} ${e["short_description"]}}".toLowerCase().contains(query.toLowerCase())).toList();
        "${e["name"]}}".toLowerCase().contains(query.toLowerCase())).toList();
    notifyListeners();
  }

  Future<dynamic> putProducts(
    String? id,
    String? name,
    String? shortDescription,
    String? description,
    String? status,
    String? weight,
    String? quantity,
    String? price,
    String? tax,
    File? image,
    String? category,
    String? size,
    String? uom,
    String? offerPrice,
  ) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var formData;

    print('name $name');
    print('image: $image');
    print('shortDescription $shortDescription');
    print('description $description');
    print('status $status');
    print('weight $weight');
    print('quantity $quantity');
    print('price $price');
    print('tax $tax');
    print('image $image');
    print('category $category');
    print('size $size');
    print('uom $uom');

    if (image == null) {
      formData = FormData.fromMap({
        'id': id,
        'name': name,
        'short_description': shortDescription,
        'description': description,
        'status': status == 'Available' ? 'in_stock' : 'out_of_stock',
        'weight': weight,
        'qty': quantity,
        'price': price,
        'tax': tax,
        // 'main_image': await MultipartFile.fromFile(image.path),
        'brand_name': 1,
        'category': int.parse(category!),
        'sizes': int.parse(size!),
        'uom': int.parse(uom!),
        'discount_price': offerPrice ?? price
      });
    } else {
      formData = FormData.fromMap({
        'id': id,
        'name': name,
        'short_description': shortDescription,
        'description': description,
        'status': status == 'Available' ? 'in_stock' : 'out_of_stock',
        'weight': weight,
        'qty': quantity,
        'price': price,
        'tax': tax,
        'main_image': await MultipartFile.fromFile(image.path),
        'brand_name': 1,
        'category': category,
        'sizes': size,
        'uom': uom
      });
    }

    print('Form Data $formData');

    final response = await Dio().patch(
        'http://34.100.212.22/api/vendor/product/',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        }));
    print('Response from Dio $response');

    return response;
  }

  Future<void> deleteProduct(String id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/product/');
    final response =
        await http.delete(url, body: json.encode({'id': id}), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    print('Delete response: ${response.body}');
  }
}
