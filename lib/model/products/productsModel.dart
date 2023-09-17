// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    required this.status,
    required this.data,
  });

  final String status;
  final List<Datum> data;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.status,
    required this.weight,
    required this.qty,
    required this.price,
    required this.tax,
    required this.mainImage,
    required this.category,
    required this.sizes,
    required this.brandName,
    required this.uom,
  });

  final int id;
  final String name;
  final String shortDescription;
  final String description;
  final String status;
  final String weight;
  final int qty;
  final double price;
  final String tax;
  final String mainImage;
  final Category category;
  final dynamic sizes;
  final dynamic brandName;
  final dynamic uom;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        shortDescription: json["short_description"],
        description: json["description"],
        status: json["status"],
        weight: json["weight"],
        qty: json["qty"],
        price: json["price"],
        tax: json["tax"],
        mainImage: json["main_image"],
        category: Category.fromJson(json["category"]),
        sizes: BrandName.fromJson(json["sizes"]),
        brandName: BrandName.fromJson(json["brand_name"]),
        uom: BrandName.fromJson(json["uom"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "short_description": shortDescription,
        "description": description,
        "status": status,
        "weight": weight,
        "qty": qty,
        "price": price,
        "tax": tax,
        "main_image": mainImage,
        "category": category.toJson(),
        "sizes": sizes.toJson(),
        "brand_name": brandName.toJson(),
        "uom": uom.toJson(),
      };
}

class BrandName {
  BrandName({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.size,
    required this.shortName,
  });

  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String size;
  final String shortName;

  factory BrandName.fromJson(Map<String, dynamic> json) => BrandName(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"] == null ? null : json["name"],
        size: json["size"] == null ? null : json["size"],
        shortName: json["short_name"] == null ? null : json["short_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name == null ? null : name,
        "size": size == null ? null : size,
        "short_name": shortName == null ? null : shortName,
      };
}

class Category {
  Category({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.categoryImage,
    required this.active,
  });

  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String categoryImage;
  final bool active;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        categoryImage: json["categoryImage"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "categoryImage": categoryImage,
        "active": active,
      };
}
