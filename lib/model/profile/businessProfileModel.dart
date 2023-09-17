// To parse this JSON data, do
//
//     final businessProfile = businessProfileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BusinessProfile businessProfileFromJson(String str) =>
    BusinessProfile.fromJson(json.decode(str));

String businessProfileToJson(BusinessProfile data) =>
    json.encode(data.toJson());

class BusinessProfile {
  BusinessProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final Data data;

  factory BusinessProfile.fromJson(Map<String, dynamic> json) =>
      BusinessProfile(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.orgName,
    required this.telephone1,
    required this.telephone2,
    required this.companyPancard,
    required this.companyPancardDoc,
    required this.adharUdyamUdoyog,
    required this.adharUdyamUdoyogDoc,
    required this.gstNumber,
  });

  final String orgName;
  final String telephone1;
  final String telephone2;
  final dynamic companyPancard;
  final String companyPancardDoc;
  final String adharUdyamUdoyog;
  final String adharUdyamUdoyogDoc;
  final String gstNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orgName: json["org_name"],
        telephone1: json["telephone_1"],
        telephone2: json["telephone_2"],
        companyPancard: json["company_pancard"],
        companyPancardDoc: json["company_pancard_doc"],
        adharUdyamUdoyog: json["adhar_udyam_udoyog"],
        adharUdyamUdoyogDoc: json["adhar_udyam_udoyog_doc"],
        gstNumber: json["gst_number"],
      );

  Map<String, dynamic> toJson() => {
        "org_name": orgName,
        "telephone_1": telephone1,
        "telephone_2": telephone2,
        "company_pancard": companyPancard,
        "company_pancard_doc": companyPancardDoc,
        "adhar_udyam_udoyog": adharUdyamUdoyog,
        "adhar_udyam_udoyog_doc": adharUdyamUdoyogDoc,
        "gst_number": gstNumber,
      };
}
