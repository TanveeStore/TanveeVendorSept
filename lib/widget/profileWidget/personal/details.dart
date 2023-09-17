import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../model/profile/profileProvider.dart';

class Details extends StatelessWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNumber;
  final String? alternateEmail;

  Details(this.firstName, this.lastName, this.email, this.mobileNumber,
      this.alternateEmail);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textColor = Color.fromARGB(255, 36, 71, 100);
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;
    // final textScale = MediaQuery.of(context).textScaleFactor * 1.2;
    // final provider = Provider.of<ProfileProvider>(context).profile;

    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'First Name',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            // provider['name'],
            firstName!,
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Last Name',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            // provider['name'],
            lastName!,
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Email',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            email!,
            // provider['email'],
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Mobile No',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            mobileNumber!,
            // provider['phone'],
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.02),
          Text(
            'Alternate Email',
            // textScaleFactor: textScale,
            style: TextStyle(
                // color: Color.fromRGBO(131, 131, 131, 1),
                color: textColor,
                fontSize: tabLayout ? 28 : 17),
          ),
          SizedBox(height: height * 0.01),
          Text(
            alternateEmail ?? 'null',
            // textScaleFactor: textScale,
            style: TextStyle(color: textColor, fontSize: tabLayout ? 20 : 12),
          ),
          SizedBox(height: height * 0.1),
          // Padding(
          //   padding: EdgeInsets.only(right: width * 0.1, bottom: height * 0.05),
          //   child: Container(
          //     width: double.infinity,
          //     height: height * 0.05,
          //     // margin: EdgeInsets.only(bottom: height * 0.05),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(100),
          //         border: Border.all(color: textColor, width: 1)),
          //     child: Center(
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
