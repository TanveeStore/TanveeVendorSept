import 'package:flutter/material.dart';
// import '../../model/profile/profileProvider.dart';
import 'package:provider/provider.dart';
import '../../../model/profile/profileProvider.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNo;
  final String? alternateEmail;
  final File? image;

  EditProfileState createState() => EditProfileState();

  EditProfile(this.firstName, this.lastName, this.email, this.mobileNo,
      this.alternateEmail, this.image);
}

class EditProfileState extends State<EditProfile> {
  final key = GlobalKey<FormState>();
  // final _emailFocus = FocusNode();
  // final _mobileNoFocus = FocusNode();
  // final _addressFocus = FocusNode();
  // final _pincodeFocus = FocusNode();
  // final _passwordFocus = FocusNode();
  // final _confirmPasswordFocus = FocusNode();
  String firstNames = '';
  String lastNames = '';
  String emailId = '';
  String alternateEmailId = '';
  String mobileNumber = '';

  @override
  void dispose() {
    // TODO: implement dispose
    // _emailFocus.dispose();
    // _mobileNoFocus.dispose();
    // _addressFocus.dispose();
    // _pincodeFocus.dispose();
    // _passwordFocus.dispose();
    // _confirmPasswordFocus.dispose();1

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;
    // final textScale = MediaQuery.of(context).textScaleFactor * 1.2;
    // final provider = Provider.of<ProfileProvider>(context).profile;

    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
      child: Center(
        child: Form(
          key: key,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: height * 0.06,
                padding: EdgeInsets.only(left: width * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
                child: TextFormField(
                  autofocus: true,
                  initialValue: widget.firstName,
                  style: TextStyle(fontSize: tabLayout ? 20 : 14),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      // hintText: widget.firstName,
                      label: Text(
                        'First Name',
                        // textScaleFactor: textScale,
                        style: TextStyle(
                            color: Colors.grey, fontSize: tabLayout ? 20 : 14),
                      )),
                  validator: (fName) {
                    if (fName!.isEmpty && widget.firstName!.isEmpty) {
                      return 'Please Enter First Name';
                    } else {
                      firstNames = fName;
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                  width: double.infinity,
                  height: height * 0.06,
                  padding: EdgeInsets.only(left: width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    autofocus: true,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    initialValue: widget.lastName,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        // hintText: widget.lastName,
                        label: Text(
                          'Last Name',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (lName) {
                      if (lName!.isEmpty && widget.lastName!.isEmpty) {
                        return 'Please Enter First Name';
                      } else {
                        lastNames = lName;
                        return null;
                      }
                    },
                  )),
              SizedBox(height: height * 0.02),
              Container(
                  width: double.infinity,
                  height: height * 0.06,
                  padding: EdgeInsets.only(left: width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    autofocus: true,
                    initialValue: widget.email,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        // hintText: widget.email,
                        label: Text(
                          'Email',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (inputEmail) {
                      if (inputEmail!.isEmpty && widget.email!.isEmpty) {
                        return 'Please Enter First Name';
                      } else {
                        emailId = inputEmail;
                        return null;
                      }
                    },
                  )),
              SizedBox(height: height * 0.02),
              Container(
                  width: double.infinity,
                  height: height * 0.06,
                  padding: EdgeInsets.only(left: width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    autofocus: true,
                    initialValue: widget.alternateEmail ?? '',
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        // hintText: widget.alternateEmail ?? 'null',
                        label: Text(
                          'Alternate Email',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (altEmail) {
                      if (altEmail!.isEmpty && widget.alternateEmail!.isEmpty) {
                        return 'Please Enter First Name';
                      } else {
                        alternateEmailId = altEmail;
                        return null;
                      }
                    },
                  )),
              SizedBox(height: height * 0.02),
              Container(
                  width: double.infinity,
                  height: height * 0.06,
                  padding: EdgeInsets.only(left: width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    // autofocus: true,
                    initialValue: widget.mobileNo,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        // hintText: widget.mobileNo,
                        label: Text(
                          'Mobile No',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (number) {
                      if (number!.isEmpty && widget.mobileNo!.isEmpty) {
                        return 'Please Enter First Name';
                      } else {
                        mobileNumber = number;
                        return null;
                      }
                    },
                  )),
              SizedBox(height: height * 0.025),
              InkWell(
                onTap: () async {
                  if (key.currentState!.validate()) {
                    // Provider.of<ProfileProvider>(context, listen: false)
                    //     .postProfileUpdate(
                    //         firstNames.isEmpty ? widget.firstName : firstNames,
                    //         lastNames.isEmpty ? widget.lastName : lastNames,
                    //         emailId.isEmpty ? widget.email : emailId,
                    //         alternateEmailId.isEmpty
                    //             ? widget.alternateEmail
                    //             : alternateEmailId,
                    //         mobileNumber.isEmpty
                    //             ? widget.mobileNo
                    //             : mobileNumber,
                    //         widget.image);
                    var res = await Provider.of<ProfileProvider>(context,
                            listen: false)
                        .postProfileUpdate(
                            firstNames.isEmpty ? widget.firstName : firstNames,
                            lastNames.isEmpty ? widget.lastName : lastNames,
                            emailId.isEmpty ? widget.email : emailId,
                            alternateEmailId.isEmpty
                                ? widget.alternateEmail
                                : alternateEmailId,
                            mobileNumber.isEmpty
                                ? widget.mobileNo
                                : mobileNumber,
                            widget.image);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(res['message'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                        action: SnackBarAction(
                          label: 'OK',
                          textColor: Colors.white,
                          onPressed: () => ScaffoldMessenger.of(context)
                              .hideCurrentSnackBar(),
                        )));

                    print('First Name $firstNames');
                    print('Last Name $lastNames');
                    print('Email ID $emailId');
                    print('Alternate Email ID $alternateEmailId');
                    print('Mobile Number $mobileNumber');
                    print('Image ${widget.image}');

                    Navigator.of(context).pushNamed('/home');
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: const Color.fromARGB(255, 36, 71, 100),
                          width: 1)),
                  child: Center(
                    child: Text(
                      'Save',
                      // textScaleFactor: textScale,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 36, 71, 100),
                          fontSize: tabLayout ? 25 : 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
