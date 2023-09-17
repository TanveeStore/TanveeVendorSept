import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../model/network/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../screens/otpScreen.dart';

class FormWidget extends StatefulWidget {
  FormWidgetState createState() => FormWidgetState();
}

class FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<FormState> _dialogKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  // final _focusFifth = FocusNode();
  String? emailId = '';
  String? password = '';
  String? email;
  String? changedPassword;
  String? fcm;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> fcmCodeGenerate() async {
    fcm = await FirebaseMessaging.instance.getToken();
    print('FCM Code $fcm');
  }

  @override
  void initState() {
    // TODO: implement initState
    fcmCodeGenerate();
    super.initState();
  }

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
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;

    // TODO: implement build
    return Column(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _key,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.08, right: width * 0.08),
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
                      controller: emailController,
                      style: TextStyle(fontSize: tabLayout ? 25 : 18),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Email',
                          hintStyle: TextStyle(fontSize: tabLayout ? 25 : 18),
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
                      onChanged: (email) {
                        emailId = email;
                      },
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Please Enter Email';
                        } else {
                          emailId = email;
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.08, right: width * 0.08),
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
                      controller: passwordController,
                      style: TextStyle(fontSize: tabLayout ? 25 : 18),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          hintStyle: TextStyle(fontSize: tabLayout ? 25 : 18),
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
                      validator: (passWrd) {
                        if (passWrd!.isEmpty) {
                          return 'Please Enter Password';
                        } else {
                          password = passWrd;
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
      Padding(
        padding: EdgeInsets.only(left: width * 0.08, right: width * 0.08),
        child: InkWell(
          onTap: () {
            if (_key.currentState!.validate()) {
              _signIn();
            }
          },
          child: Container(
            width: double.infinity,
            height: height * 0.07,
            margin: EdgeInsets.only(top: height * 0.02),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(57, 226, 14, 1),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Text(
                'Login',
                // textScaleFactor: textScaleFactor,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: tabLayout
                        ? 25
                        : largeLayout
                            ? 18
                            : 14),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: height * 0.04),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if(kDebugMode){
                emailController.text="pothularamamunireddy@gmail.com";
                passwordController.text="harish123";
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Dont\'t have an account?',
                textAlign: TextAlign.center,
                // textScaleFactor: textScaleFactor,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: tabLayout
                        ? 23
                        : largeLayout
                            ? 16
                            : 12),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed('/sign-up'),
            child: Text(
              'Sign Up',
              textAlign: TextAlign.center,
              // textScaleFactor: textScaleFactor,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: tabLayout
                      ? 23
                      : largeLayout
                          ? 16
                          : 12),
            ),
          ),
        ],
      ),
      SizedBox(height: height * 0.01),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            // onTap: () => showDialog(
            //     context: context,
            //     builder: (context) => AlertDialog(
            //           title: Text('Please Enter Email To Continue'),
            //           actions: [
            //             Form(
            //               key: _dialogKey,
            //               child: Padding(
            //                 padding: EdgeInsets.only(
            //                     left: width * 0.04, right: width * 0.04),
            //                 child: TextFormField(
            //                   // controller: emailController,
            //                   decoration: InputDecoration(
            //                       hintText:
            //                           'Enter your registered email address'),
            //                   validator: (input) {
            //                     if (input!.isEmpty) {
            //                       return 'Please Enter your Registered Email Address';
            //                     } else {
            //                       email = input;
            //                       return null;
            //                     }
            //                   },
            //                 ),
            //               ),
            //             ),
            //             TextButton(
            //                 onPressed: () async {
            //                   SharedPreferences localStorage =
            //                       await SharedPreferences.getInstance();
            //                   if (_dialogKey.currentState!.validate()) {
            //                     var response =
            //                         await Provider.of<Authentication>(context,
            //                                 listen: false)
            //                             .forgotPassword({'email': email},
            //                                 'api/forgot-password/');
            //                     var passwordResponse =
            //                         json.decode(response.body);
            //                     print(passwordResponse);
            //                     localStorage.setString(
            //                         'uid', passwordResponse['uid'][0]);
            //                     localStorage.setString('passwordResetToken',
            //                         passwordResponse['token']);
            //                     Navigator.of(context).pop();
            //                     showDialog(
            //                         context: context,
            //                         builder: (context) => AlertDialog(
            //                               title: Text('Enter New Password'),
            //                               actions: [
            //                                 Form(
            //                                   key: _passwordKey,
            //                                   child: Padding(
            //                                     padding: EdgeInsets.only(
            //                                         left: width * 0.04,
            //                                         right: width * 0.04),
            //                                     child: TextFormField(
            //                                       // controller: emailController,
            //                                       decoration: InputDecoration(
            //                                           hintText:
            //                                               'Enter New Password'),
            //                                       validator: (changePassword) {
            //                                         if (changePassword!
            //                                             .isEmpty) {
            //                                           return 'Please Enter Password';
            //                                         } else if (changePassword
            //                                                 .length <
            //                                             10) {
            //                                           return 'Password must be atleast 10 characters long';
            //                                         } else {
            //                                           changedPassword =
            //                                               changePassword;
            //                                           return null;
            //                                         }
            //                                       },
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 TextButton(
            //                                   onPressed: () async {
            //                                     SharedPreferences localStorage =
            //                                         await SharedPreferences
            //                                             .getInstance();
            //                                     if (_passwordKey.currentState!
            //                                         .validate()) {
            //                                       var passwordResponse =
            //                                           await Provider.of<
            //                                                       Authentication>(
            //                                                   context,
            //                                                   listen: false)
            //                                               .resetPassword({
            //                                         'password': changedPassword,
            //                                         'uidb64': localStorage
            //                                             .getString('uid'),
            //                                         'token':
            //                                             localStorage.getString(
            //                                                 'passwordResetToken'),
            //                                       }, 'api/password-reset-complete/');
            //                                       Navigator.of(context).pop();
            //                                       var decodedReponse = json
            //                                           .decode(passwordResponse
            //                                               .body);
            //                                       if (decodedReponse[
            //                                               'success'] ==
            //                                           'true') {
            //                                         ScaffoldMessenger.of(
            //                                                 context)
            //                                             .showSnackBar(SnackBar(
            //                                           backgroundColor:
            //                                               Colors.green,
            //                                           content: Text(
            //                                               decodedReponse[
            //                                                   'message'],
            //                                               style: TextStyle(
            //                                                   color: Colors
            //                                                       .white)),
            //                                         ));
            //                                       }
            //                                       // print(json.decode(
            //                                       //     passwordResponse.body));
            //                                     }
            //                                   },
            //                                   child: Text('Ok',
            //                                       style: TextStyle(
            //                                           color: Colors.green)),
            //                                 )
            //                               ],
            //                             ));
            //                   }
            //                 },
            //                 child: Text(
            //                   'Continue',
            //                   style: TextStyle(color: Colors.green),
            //                 ))
            //           ],
            //         )),
            onTap: () async {
              if (emailId == null || emailId!.isEmpty) {
                Get.snackbar("Erro", "Enter Email Id");
                return;
              }
              var email = {'email': emailId};

              var response =
                  await Provider.of<Authentication>(context, listen: false)
                      .forgotPassword(email, 'api/forgot-password-send-otp/');
              print(response.body);

              var responseData = json.decode(response.body);

              print('FORGOT PASSWORD: $responseData');

              if (responseData['status'] == 'warning') {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(responseData['message']),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('OK',
                                  style: TextStyle(color: Colors.green)),
                            )
                          ],
                        ));
              } else {
                print('SUCCESS');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InputOTP(responseData['message'])));
              }
            },
            child: Text(
              'Change Password',
              textAlign: TextAlign.center,
              // textScaleFactor: textScaleFactor,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: tabLayout
                      ? 23
                      : largeLayout
                          ? 16
                          : 12),
            ),
          ),
        ],
      ),
      // SizedBox(height: height * 0.01),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     InkWell(
      //       onTap: () => Navigator.of(context).pushNamed('/sign-up'),
      //       child: Text(
      //         'Change Your Password',
      //         textAlign: TextAlign.center,
      //         // textScaleFactor: textScaleFactor,
      //         style: TextStyle(
      //             color: Colors.green,
      //             fontWeight: FontWeight.bold,
      //             fontSize: tabLayout
      //                 ? 23
      //                 : largeLayout
      //                     ? 16
      //                     : 12),
      //       ),
      //     ),
      //   ],
      // ),
      // SizedBox(height: height * 0.04),
    ]);
  }

  void _signIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = {'email': emailId.toString(), 'password': password.toString()};
    print(data);

    var response = await Provider.of<Authentication>(context, listen: false)
        .signIn(data, 'api/vendor/login/');
    var res = json.decode(response.body);
    if (res['status'] == 'success') {
      await localStorage.setString('token', res['data']['access']);
      final url = Uri.parse('http://34.100.212.22/' + 'api/fcm-token/');

      var responseFcm =
          await http.post(url, body: json.encode({'fcm_token': fcm}), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${localStorage.getString('token')}'
      });

      print(responseFcm.body);
      Navigator.of(context).pushNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(res['message'],
            style: const TextStyle(
              color: Colors.white,
            )),
        action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      ));
    }
    print(json.decode(response.body));
  }
}
