import 'package:flutter/material.dart';
import './business/details.dart';
import './business/edit.dart';
import 'package:provider/provider.dart';
import '../../model/profile/businessProfileProvider.dart';

class Business extends StatefulWidget {
  // final String? bankName;
  // final String? branchName;
  // final String? ifscCode;
  // final String? accountNumber;
  // final String? organisationName;
  // final String? telephoneOne;
  // final String? telephoneTwo;
  // final String? companyPancard;
  // final String? companyPancardDoc;
  // final String? aadharUdyog;
  // final String? aadharUdyogDoc;
  // final String? gstNumber;

  BusinessState createState() => BusinessState();

  // Business(
  //     this.bankName,
  //     this.branchName,
  //     this.ifscCode,
  //     this.accountNumber,
  //     this.organisationName,
  //     this.telephoneOne,
  //     this.telephoneTwo,
  //     this.companyPancard,
  //     this.companyPancardDoc,
  //     this.aadharUdyog,
  //     this.aadharUdyogDoc,
  //     this.gstNumber);
}

class BusinessState extends State<Business> {
  bool clicked = false;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<BusinessProfileProvider>(context, listen: false)
        .getBusinessProfile()
        .then((_) {
      Provider.of<BusinessProfileProvider>(context, listen: false)
          .getBankDetails()
          .then((_) {
        Provider.of<BusinessProfileProvider>(context, listen: false)
            .getBusinessAddress()
            .then((_) {
          setState(() {
            isLoading = false;
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textScale = MediaQuery.of(context).textScaleFactor * 1.2;
    const textColor = Color.fromARGB(255, 36, 71, 100);
    final businessProvider =
        Provider.of<BusinessProfileProvider>(context).businessProfile;
    final bankProvider =
        Provider.of<BusinessProfileProvider>(context).bankDetails;
    final addressProvider =
        Provider.of<BusinessProfileProvider>(context).businessAddress;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;

    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text(
      //     'Personal',
      //     textScaleFactor: textScale,
      //     style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      //   ),
      //   // actions: [Cart(), NotifyBell()],
      // ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : Center(
              child: ListView(
                children: [
                  // SizedBox(height: height * 0.05),
                  // CircleAvatar(
                  //   radius: 50,
                  //   // child: Image.asset(
                  //   //   'assets/images/NoPath - Copy (14).png',
                  //   // ),
                  // ),
                  SizedBox(height: height * 0.03),
                  InkWell(
                    onTap: () {
                      setState(() {
                        clicked = !clicked;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit,
                            color: textColor, size: tabLayout ? 36 : 24),
                        SizedBox(width: width * 0.01),
                        Text(
                          'Edit Business Details',
                          textScaleFactor: textScale,
                          style: TextStyle(
                              color: textColor, fontSize: tabLayout ? 25 : 18),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.002),
                  // Center(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(left: width * 0.04),
                  //     child: Text(
                  //       'Hi there ${provider['name'].substring(0, 3)}',
                  //       textScaleFactor: textScale,
                  //       style: const TextStyle(
                  //           color: textColor, fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: height * 0.003),
                  // Center(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(left: width * 0.04),
                  //     child: Text(
                  //       'Sign Out',
                  //       textScaleFactor: textScale,
                  //       style: TextStyle(
                  //           color: textColor,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 12),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: height * 0.01),
                  !clicked
                      ? Details(businessProvider, bankProvider, addressProvider)
                      : EditProfile(
                          businessProvider, bankProvider, addressProvider)
                ],
              ),
            ),
    );
  }
}
