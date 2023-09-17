import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../model/network/authentication.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../authentication/network.dart';

class ChangePassword extends StatefulWidget {
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  // final _focusFifth = FocusNode();
  String? oldPassword;
  String? newPassword;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _focusFifth.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // final textScaleFactor = MediaQuery.of(context).textScaleFactor * 1.2;

    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: height * 0.3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.08, right: width * 0.08),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: width * 0.02, top: height * 0.0045),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  // color: Color.fromRGBO(227, 189, 255, 0.5),
                                  offset: Offset(1, 2))
                            ]),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: 'Old Password',
                              // suffixIcon: mobileNumber!.length < 10
                              //     ? null
                              //     : const Icon(Icons.check_circle,
                              //         color: Colors.green),
                              // label: Text(
                              //   'Enter Your Phone Number',
                              //   textScaleFactor: textScaleFactor,
                              //   style: const TextStyle(color: Colors.grey),
                              // ),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                          // onFieldSubmitted: (_) =>
                          //     FocusScope.of(context).requestFocus(_focusFirst),
                          validator: (old) {
                            if (old!.isEmpty) {
                              return 'Please Enter Old Password';
                            } else {
                              oldPassword = old;
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.08, right: width * 0.08),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: width * 0.02, top: height * 0.0045),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  // color: Color.fromRGBO(227, 189, 255, 0.5),
                                  offset: Offset(1, 2))
                            ]),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Enter Your New Password',
                              // suffixIcon: mobileNumber!.length < 10
                              //     ? null
                              //     : const Icon(Icons.check_circle,
                              //         color: Colors.green),
                              // label: Text(
                              //   'Enter Your Phone Number',
                              //   textScaleFactor: textScaleFactor,
                              //   style: const TextStyle(color: Colors.grey),
                              // ),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                          // onFieldSubmitted: (_) =>
                          //     FocusScope.of(context).requestFocus(_focusFirst),
                          validator: (newP) {
                            if (newP!.isEmpty) {
                              return 'Please Enter New Password';
                            } else {
                              newPassword = newP;
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
          // Text(
          //   'Forgot your password?',
          //   textAlign: TextAlign.center,
          //   // textScaleFactor: textScaleFactor,
          //   style: const TextStyle(color: Colors.grey),
          // ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.08, right: width * 0.08),
            child: InkWell(
              onTap: () {
                // if (_otpKey.currentState!.validate()) {
                //   login(firstOtp!, secondOtp!, thirdOtp!, fourthOtp!,
                //       mobileNumber!);
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: const Text(
                //       'Please Enter Your OTP',
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     backgroundColor: Colors.white,
                //     action: SnackBarAction(
                //         label: 'Ok',
                //         onPressed: () => Navigator.of(context).pop()),
                //   ));
                // }
                if (_key.currentState!.validate()) {
                  _changePassword();
                }
              },
              child: Container(
                width: double.infinity,
                height: height * 0.07,
                margin: EdgeInsets.only(top: height * 0.02),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(57, 226, 14, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    'Change Password',
                    // textScaleFactor: textScaleFactor,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Dont\'t have an account?',
                textAlign: TextAlign.center,
                // textScaleFactor: textScaleFactor,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed('/sign-up'),
                child: const Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  // textScaleFactor: textScaleFactor,
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       width: width * 0.18,
          //       height: height * 0.065,
          //       padding:
          //           EdgeInsets.only(top: height * 0.02, bottom: height * 0.02),
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(10),
          //           boxShadow: const [
          //             BoxShadow(
          //                 color: Colors.grey,
          //                 spreadRadius: 2,
          //                 blurRadius: 4,
          //                 offset: Offset(0, 1))
          //           ]),
          //       child: Center(
          //         child: Image.asset(
          //             'assets/images/facebook-logo-transparent.png'),
          //       ),
          //     ),
          //     SizedBox(width: width * 0.04),
          //     Container(
          //       width: width * 0.18,
          //       height: height * 0.065,
          //       padding:
          //           EdgeInsets.only(top: height * 0.02, bottom: height * 0.02),
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(10),
          //           boxShadow: const [
          //             BoxShadow(
          //                 color: Colors.grey,
          //                 spreadRadius: 2,
          //                 blurRadius: 4,
          //                 offset: Offset(0, 1))
          //           ]),
          //       child: Center(
          //         child: Image.asset('assets/images/google-logo.png'),
          //       ),
          //     )
          //   ],
          // ),
          SizedBox(height: height * 0.04),
          // const Text(
          //     'Please Change your Password if you are Logging In For the First Time',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: Colors.grey,
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     )),
          // SizedBox(height: height * 0.02),
          // const Text('Change Password',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: Colors.green,
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     ))
        ],
      ),
    );
  }

  void _changePassword() async {
    var data = {
      'old_password': oldPassword.toString(),
      'new_password': newPassword.toString()
    };
    print(data);
    var response = await Provider.of<Authentication>(context, listen: false)
        .changePassword(data, 'api/vendor/change-password/');
    var res = json.decode(response.body);
    print('Changed Password $res');
    if (res['status'] != 'warning') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res['message'],
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.of(context).pushNamed('/sign-in');
          },
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res['message'],
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      ));
    }
  }
}
