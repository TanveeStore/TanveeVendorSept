import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanvi_vendor/model/profile/businessProfileProvider.dart';
// import '../../model/profile/profileProvider.dart';

class Details extends StatelessWidget {
  final Map<String, dynamic> businessDetails;
  final Map<String, dynamic> bankDetails;
  final Map<String, dynamic> addressDetails;

  Details(this.businessDetails, this.bankDetails, this.addressDetails);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    const textColor = Color.fromARGB(255, 36, 71, 100);
    bool bank = bankDetails['message'] == 'You don\'t have any Bank details'
        ? true
        : false;
    bool address = addressDetails['status'] == 'warning' ? true : false;
    final provider =
        Provider.of<BusinessProfileProvider>(context).deliveryAddress;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;

    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Organization Name',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            // provider['name'],
            businessDetails['data']['org_name'] ?? '',
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Telephone Number 1',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            // provider['name'],
            businessDetails['data']['telephone_1'] ??
                'Please Enter Primary Phone Number',
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Telephone Number 2',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            businessDetails['data']['telephone_2'] ??
                'Please Enter Secondary Phone Number',
            // provider['email'],
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Company Pan Card',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            businessDetails['data']['company_pancard'] ??
                'Please Enter the Comapany PAN Card Number',
            // provider['phone'],
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.005),
          Text(
            businessDetails['data']['company_pancard_doc'] != null
                ? 'Pan Card Document Uploaded'
                : 'Pan Card Document Not Uploaded',
            // 'Pan Card Document Uploaded',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 15 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Aadhar Udyam Udoyog',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            // provider['name'],
            businessDetails['data']['adhar_udyam_udoyog'] ??
                'Please Enter Aadhar Udyog Number',
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.005),
          Text(
            businessDetails['data']['adhar_udyam_udoyog_doc'] != null
                ? 'Aadhar Card Document Uploaded'
                : 'Aadhar Card Document Not Uploaded',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 15 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'GST Number',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            // provider['name'],
            businessDetails['data']['gst_number'] ?? 'Please Enter GST Number',
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Bank Name',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            // provider['name'],
            bank == true
                ? 'Bank Details Incomplete'
                : bankDetails['data']['acc_bank_name'],
            // bankDetails['data']['acc_bank_name'] ?? 'Bank Details Incomplete',
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Branch Name',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            bank == true
                ? 'Bank Details Incomplete'
                : bankDetails['data']['acc_branch_name'],
            //bankDetails['data']['acc_branch_name'] ?? 'Bank Details Incomplete',
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Branch IFSC Code',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            bank == true
                ? 'Bank Details Incomplete'
                : bankDetails['data']['acc_ifsc'],
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Account Number',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            bank == true
                ? 'Bank Details Incomplete'
                : bankDetails['data']['acc_no'],
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Business Address',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            address == true
                ? 'Please Enter Address'
                // : '${addressDetails['data']['address']}, ${addressDetails['data']['locality']}, ${addressDetails['data']['city']}, ${addressDetails['data']['state']}, ${addressDetails['data']['postcode']}',
                : provider,
            // textScaleFactor: t: extScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          // Text(
          //   'Business Name',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(
          //       // color: Color.fromRGBO(131, 131, 131, 1),
          //       color: textColor,
          //       fontSize: 17),
          // ),
          // SizedBox(height: height * 0.01),
          // Text(
          //   // provider['name'],
          //   'Dum Dum Cantonment',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(color: textColor, fontSize: 12),
          // ),
          SizedBox(height: height * 0.02),
          // Text(
          //   'Business Address',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(
          //       // color: Color.fromRGBO(131, 131, 131, 1),
          //       color: textColor,
          //       fontSize: 17),
          // ),
          // SizedBox(height: height * 0.01),
          // Text(
          //   // provider['name'],
          //   'Dum Dum Cantonment',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(color: textColor, fontSize: 12),
          // ),
          // SizedBox(height: height * 0.02),
          // Text(
          //   'Locality',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(
          //       // color: Color.fromRGBO(131, 131, 131, 1),
          //       color: textColor,
          //       fontSize: 17),
          // ),
          // SizedBox(height: height * 0.01),
          // Text(
          //   // provider['name'],
          //   'Dum Dum Cantonment',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(color: textColor, fontSize: 12),
          // ),
          // SizedBox(height: height * 0.02),
          // Text(
          //   'City',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(
          //       // color: Color.fromRGBO(131, 131, 131, 1),
          //       color: textColor,
          //       fontSize: 17),
          // ),
          // SizedBox(height: height * 0.01),
          // Text(
          //   // provider['name'],
          //   'Dum Dum Cantonment',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(color: textColor, fontSize: 12),
          // ),
          // SizedBox(height: height * 0.02),
          // Text(
          //   'State',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(
          //       // color: Color.fromRGBO(131, 131, 131, 1),
          //       color: textColor,
          //       fontSize: 17),
          // ),
          // SizedBox(height: height * 0.01),
          // Text(
          //   // provider['name'],
          //   'Dum Dum Cantonment',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(color: textColor, fontSize: 12),
          // ),
          // SizedBox(height: height * 0.02),
          // Text(
          //   'Post Code',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(
          //       // color: Color.fromRGBO(131, 131, 131, 1),
          //       color: textColor,
          //       fontSize: 17),
          // ),
          // SizedBox(height: height * 0.01),
          // Text(
          //   // provider['name'],
          //   'Dum Dum Cantonment',
          //   // textScaleFactor: textScale,
          //   style: TextStyle(color: textColor, fontSize: 12),
          // ),
          SizedBox(height: height * 0.05),
          // Padding(
          //   padding: EdgeInsets.only(right: width * 0.1, bottom: height * 0.05),
          //   child: Container(
          //     width: double.infinity,
          //     height: height * 0.05,
          //     // margin: EdgeInsets.only(bottom: height * 0.05),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(100),
          //         border: Border.all(color: textColor, width: 1)),
          //     child: const Center(
          //       child: Text(
          //         'Save',
          //         // textScaleFactor: textScale,
          //         style: TextStyle(color: textColor),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
    // );
  }
}
