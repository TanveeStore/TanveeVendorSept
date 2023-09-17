import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

class BusinessProfileProvider with ChangeNotifier {
  String baseUrl = 'http://34.100.212.22/';
  Map<String, dynamic> _bankDetails = {};
  Map<String, dynamic> _businessProfile = {};
  Map<String, dynamic> _businessAddress = {};
  String _deliveryAddress = '';

  String? postCode;
  String? addressLine;
  String? locality;
  String? city;
  String? selectedState;

  String get deliveryAddress {
    return _deliveryAddress;
  }

  Map<String, dynamic> get bankDetails {
    return {..._bankDetails};
  }

  Map<String, dynamic> get businessProfile {
    return {..._businessProfile};
  }

  Map<String, dynamic> get businessAddress {
    return {..._businessAddress};
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getBusinessAddress() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/profile/address/');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });
    var res = json.decode(response.body);
    _businessAddress = res;

    if (_businessAddress['data'].length == 0) {
      _deliveryAddress = 'No Address Selected';
    } else {
      _deliveryAddress =
          '${_businessAddress['data']['address']}, ${_businessAddress['data']['locality']}, ${_businessAddress['data']['city']}, ${_businessAddress['data']['state']}, ${_businessAddress['data']['postcode']}';
    }

    print('Business Address: $_businessAddress');

    print('Delivery Address: $_deliveryAddress');
  }

  Future<void> postBusinessAddress(double latitude, double longitude) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];

    _deliveryAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}. ${place.postalCode}';

    final url = Uri.parse(baseUrl + 'api/vendor/profile/address/');
    final response = await http.post(url,
        body: json.encode({
          "name": "Rachhel",
          "address": place.street,
          "locality": place.subLocality,
          "city": place.locality,
          "state": place.administrativeArea,
          "postcode": place.postalCode,
          "map_lat": latitude,
          "map_lng": longitude
        }),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });
    print(response.body);
    notifyListeners();
  }

  Future<void> getBusinessProfile() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/profile/business/');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    // BusinessProfile businessProfile = businessProfileFromJson(response.body);

    // _businessProfile = businessProfile.toJson();

    var res = json.decode(response.body);

    _businessProfile = res;

    print('Business Profile $_businessProfile');
  }

  Future<void> getBankDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/profile/bank-details/');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    _bankDetails = json.decode(response.body);
    print(_bankDetails);
  }

  Future<void> postBankDetails(String? bankName, String? branchName,
      String? ifscCode, String? accountNumber) async {
    print('Bank Name $bankName');
    print('Branch Name $branchName');
    print('IFSC $ifscCode');
    print('Account Number $accountNumber');

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/profile/bank-details/');

    final response = await http.post(url,
        body: json.encode({
          'acc_bank_name': bankName,
          'acc_branch_name': branchName,
          'acc_ifsc': ifscCode,
          'acc_no': accountNumber
        }),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    print(json.decode(response.body));
  }

  Future<dynamic> postOrganisationDetails(
      String? organizationName,
      String? telephoneNumberOne,
      String? telephoneNumberTwo,
      String? companyPanCard,
      PlatformFile? panCard,
      String? aadharUdyamUdoyog,
      PlatformFile? aadharCard,
      String? gstNumber) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/profile/business/');

    var formData = FormData.fromMap({
      'org_name': organizationName,
      'telephone_1': telephoneNumberOne,
      'telephone_2': telephoneNumberTwo,
      'company_pancard': companyPanCard,
      'company_pancard_doc':
          await MultipartFile.fromFile(panCard!.path.toString()),
      'adhar_udyam_udoyog': aadharUdyamUdoyog,
      'adhar_udyam_udoyog_doc':
          await MultipartFile.fromFile(aadharCard!.path.toString()),
      'gst_number': gstNumber
    });

    print('Form Data $formData');

    final response =
        await Dio().post('http://34.100.212.22/api/vendor/profile/business/',
            data: formData,
            options: Options(headers: {
              'Authorization': 'Bearer ${localStorage.getString('token')}',
              'Content-Type': 'application/json'
            }));
    print('Response from Dio $response');

    return response;
  }

  Future<Map<String, dynamic>> postMethodOne(
      String? organizationName,
      String? telephoneNumberOne,
      String? telephoneNumberTwo,
      String? companyPanCard,
      String? aadharUdyamUdoyog,
      String? gstNumber) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final url = Uri.parse(baseUrl + 'api/vendor/profile/business/');

    final response = await http.post(url,
        body: json.encode({
          'org_name': organizationName,
          'telephone_1': telephoneNumberOne,
          'telephone_2': telephoneNumberTwo,
          'company_pancard': companyPanCard,
          'adhar_udyam_udoyog': aadharUdyamUdoyog,
          'gst_number': gstNumber
        }),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    var res = json.decode(response.body);

    print(res);

    return res;
  }

  Future<void> imageOne(File? panCard) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // final File filePanCard = File(panCard!.path.toString());
    // final File fileAadharCard = File(aadharCard!.path.toString());
    final url = Uri.parse(baseUrl + 'api/vendor/profile/business/');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });
    request.files.add(await http.MultipartFile.fromPath(
        'company_pancard_doc', panCard!.path,
        contentType: MediaType('application', 'x-tar')));

    var response = await request.send();

    print('Response: $response');

    if (response.statusCode == 200) {
      print('Uploaded');
    } else {
      print('Response Error: ${response.stream.bytesToString()}');
      print('Failed');
    }
  }

  Future<void> imageTwo(File? aadharCard) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // final File filePanCard = File(panCard!.path.toString());
    // final File fileAadharCard = File(aadharCard!.path.toString());
    final url = Uri.parse(baseUrl + 'api/vendor/profile/business/');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    request.files.add(await http.MultipartFile.fromPath(
        'adhar_udyam_udoyog_doc', aadharCard!.path,
        contentType: MediaType('application', 'x-tar')));

    var response = await request.send();

    print('Response: $response');

    if (response.statusCode == 200) {
      print('Uploaded');
    } else {
      print('Response Error: ${response.stream.bytesToString()}');
      print('Failed');
    }
  }
}
