import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanvi_vendor/model/network/authentication.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// import '../authentication/network.dart';

class SignUp extends StatefulWidget {
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _orgNameController;
  late TextEditingController _panCardController;
  late TextEditingController _numberController;
  late TextEditingController _emailController;
  // final _focusFirst = FocusNode();
  // final _focusSecond = FocusNode();
  // final _focusThird = FocusNode();
  String? dropDownValue;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? organizationName;
  String? panNumber;
  List<String> gender = ['Female', 'Male', 'Rather Not Say'];

  @override
  void initState() {
    // TODO: implement initState
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _orgNameController = TextEditingController();
    _panCardController = TextEditingController();
    _numberController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   // _focusFirst.dispose();
  //   // _focusSecond.dispose();
  //   // _focusThird.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // final textScaleFactor = MediaQuery.of(context).textScaleFactor * 1.2;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;

    // TODO: implement build
    return Scaffold(
      body: Container(
          height: height * 1,
          width: double.infinity,
          // margin: EdgeInsets.only(top: height * 0.08),
          padding: EdgeInsets.only(top: height * 0.01),
          decoration: const BoxDecoration(
             /* image: DecorationImage(
                  image: AssetImage('assets/images/Rectangle 392.png'),
                  fit: BoxFit.cover)*/),
          child: Stack(
            children: [
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Image.asset('assets/images/sign_up_asset.png',
              //         fit: BoxFit.cover),
              //   ],
              // ),
              Positioned(
                child: Form(
                  key: _globalKey,
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          'Sign Up',
                          // textScaleFactor: textScaleFactor,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: tabLayout
                                  ? width * 0.06
                                  : largeLayout
                                      ? 22
                                      : 18),
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, right: width * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name',
                              // textScaleFactor: textScaleFactor,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: tabLayout
                                      ? width * 0.03
                                      : largeLayout
                                          ? 18
                                          : 16),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              margin: EdgeInsets.only(bottom: height * 0.04),
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
                                style: TextStyle(fontSize: tabLayout ? 25 : 18),
                                controller: _firstNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'Enter Your First Name',
                                    hintStyle: TextStyle(
                                        fontSize: tabLayout ? 25 : 18),
                                    // suffixIcon:
                                    //     Icon(Icons.check_circle, color: Colors.green),
                                    // label: Text(
                                    //   'Enter Your Phone Number',
                                    // textScaleFactor: textScaleFactor,
                                    //   style: const TextStyle(color: Colors.grey),
                                    // ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                                // onFieldSubmitted: (_) => FocusScope.of(context)
                                //     .requestFocus(_focusFirst),
                                validator: (fName) {
                                  if (fName!.isEmpty) {
                                    return 'Please Enter First Name';
                                  } else {
                                    firstName = fName;
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, right: width * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Name',
                              // textScaleFactor: textScaleFactor,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: tabLayout ? 25 : 18),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              margin: EdgeInsets.only(bottom: height * 0.04),
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
                                style: TextStyle(fontSize: tabLayout ? 25 : 18),
                                controller: _lastNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'Enter Your Last Name',
                                    hintStyle: TextStyle(
                                        fontSize: tabLayout ? 25 : 18),
                                    // suffixIcon:
                                    //     Icon(Icons.check_circle, color: Colors.green),
                                    // label: Text(
                                    //   'Enter Your Phone Number',
                                    // textScaleFactor: textScaleFactor,
                                    //   style: const TextStyle(color: Colors.grey),
                                    // ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                                // onFieldSubmitted: (_) => FocusScope.of(context)
                                //     .requestFocus(_focusFirst),
                                validator: (lName) {
                                  if (lName!.isEmpty) {
                                    return 'Please Enter Last Name';
                                  } else {
                                    lastName = lName;
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: height * 0.02),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, right: width * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              // textScaleFactor: textScaleFactor,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: tabLayout ? 25 : 18),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              padding: EdgeInsets.only(left: width * 0.01),
                              margin: EdgeInsets.only(bottom: height * 0.04),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 8,
                                        offset: Offset(1, 2))
                                  ]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    hint: const Text('Gender'),
                                    style: TextStyle(
                                        fontSize: tabLayout ? 25 : 18),
                                    value: dropDownValue,
                                    items: gender.map((e) {
                                      return DropdownMenuItem(
                                        child: Text(e,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        value: e,
                                      );
                                    }).toList(),
                                    onChanged: (selectedValue) {
                                      setState(() {
                                        dropDownValue =
                                            selectedValue.toString();
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, right: width * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Organization Name',
                              // textScaleFactor: textScaleFactor,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: tabLayout ? 25 : 18),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.02, top: height * 0.0045),
                              margin: EdgeInsets.only(bottom: height * 0.04),
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
                                style: TextStyle(fontSize: tabLayout ? 25 : 18),
                                controller: _orgNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'Enter Your Organization\'s name',
                                    hintStyle: TextStyle(
                                        fontSize: tabLayout ? 25 : 18),
                                    // suffixIcon:
                                    //     Icon(Icons.check_circle, color: Colors.green),
                                    // label: Text(
                                    //   'Enter Your Phone Number',
                                    // textScaleFactor: textScaleFactor,
                                    //   style: const TextStyle(color: Colors.grey),
                                    // ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                                // onFieldSubmitted: (_) => FocusScope.of(context)
                                //     .requestFocus(_focusFirst),
                                validator: (orgName) {
                                  if (orgName!.isEmpty) {
                                    return 'Please Enter Your Organization\'s name';
                                  } else {
                                    organizationName = orgName;
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, right: width * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PAN Card (Optional)',
                              // textScaleFactor: textScaleFactor,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: tabLayout ? 25 : 18),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.02, top: height * 0.0045),
                              margin: EdgeInsets.only(bottom: height * 0.04),
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
                              child: TextField(
                                style: TextStyle(fontSize: tabLayout ? 25 : 18),
                                controller: _panCardController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'Enter Your PAN Number',
                                    hintStyle: TextStyle(
                                        fontSize: tabLayout ? 25 : 18),
                                    // suffixIcon:
                                    //     Icon(Icons.check_circle, color: Colors.green),
                                    // label: Text(
                                    //   'Enter Your Phone Number',
                                    // textScaleFactor: textScaleFactor,
                                    //   style: const TextStyle(color: Colors.grey),
                                    // ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                                // onFieldSubmitted: (_) => FocusScope.of(context)
                                //     .requestFocus(_focusFirst),
                                // validator: (panNo) {
                                //   if (panNo!.isEmpty) {
                                //     // return 'Please Enter Your PAN Number';
                                //     return null;
                                //   }
                                //   // else {
                                //   //   panNumber = panNo;
                                //   //   return null;
                                //   // }
                                // },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, right: width * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              // textScaleFactor: textScaleFactor,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: tabLayout ? 25 : 18),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.02, top: height * 0.0045),
                              margin: EdgeInsets.only(bottom: height * 0.04),
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
                                style: TextStyle(fontSize: tabLayout ? 25 : 18),
                                controller: _numberController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Enter Your Phone Number',
                                    hintStyle: TextStyle(
                                        fontSize: tabLayout ? 25 : 18),
                                    // suffixIcon:
                                    //     Icon(Icons.check_circle, color: Colors.green),
                                    // label: Text(
                                    //   'Enter Your Phone Number',
                                    // textScaleFactor: textScaleFactor,
                                    //   style: const TextStyle(color: Colors.grey),
                                    // ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                                // onFieldSubmitted: (_) => FocusScope.of(context)
                                //     .requestFocus(_focusFirst),
                                validator: (number) {
                                  if (number!.length < 10 ||
                                      number.length > 10) {
                                    return 'Please Check Your Phone Number';
                                  } else if (number.isEmpty) {
                                    return 'Please Enter Phone Number';
                                  } else {
                                    phoneNumber = '+91' + number;
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, right: width * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              // textScaleFactor: textScaleFactor,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: tabLayout ? 25 : 18),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
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
                                style: TextStyle(fontSize: tabLayout ? 25 : 18),
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: 'Enter Your Email',
                                    hintStyle: TextStyle(
                                        fontSize: tabLayout ? 25 : 18),
                                    // suffixIcon:
                                    //     Icon(Icons.check_circle, color: Colors.green),
                                    // label: Text(
                                    //   'Enter Your Phone Number',
                                    // textScaleFactor: textScaleFactor,
                                    //   style: const TextStyle(color: Colors.grey),
                                    // ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                                // onFieldSubmitted: (_) => FocusScope.of(context)
                                //     .requestFocus(_focusFirst),
                                validator: (mail) {
                                  if (mail!.isEmpty) {
                                    return 'Please Enter Email';
                                  } else {
                                    email = mail;
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.08, right: width * 0.08),
                        child: InkWell(
                          // onTap: () =>
                          //     Navigator.of(context).pushNamed('/home-screen'),
                          onTap: () {
                            // if (_globalKey.currentState!.validate()) {
                            //   _signUp();
                            // }
                            if (_globalKey.currentState!.validate()) {
                              _signUp(_panCardController.text == null
                                  ? ""
                                  : _panCardController.text);
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
                                'Sign Up',
                                // textScaleFactor: textScaleFactor,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: tabLayout ? 25 : 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?',
                            textAlign: TextAlign.center,
                            // textScaleFactor: textScaleFactor,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: tabLayout ? 18 : 14),
                          ),
                          InkWell(
                            onTap: () =>
                                Navigator.of(context).pushNamed('/sign-in'),
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              // textScaleFactor: textScaleFactor,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: tabLayout ? 18 : 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _signUp(String panCardNumber) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var data = {
      'first_name': firstName.toString(),
      'last_name': lastName.toString(),
      'gender': dropDownValue.toString(),
      'org_name': organizationName.toString(),
      'pancard': panCardNumber,
      'mobile': phoneNumber.toString(),
      'email': email.toString()
    };
    print(data);

    localStorage.setString('registeredEmail', data['email'].toString());
    var response = await Provider.of<Authentication>(context, listen: false)
        .signUp(data, 'api/vendor/registration/');

    print("Signup response ${response.body}");
    var receivedResponse = json.decode(response.body);
    print(json.decode(response.body));

    if (receivedResponse['status'] != 'warning') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Registration Successful!!! Please Check your Email for Username and Password',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.green,
          action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(receivedResponse['errors'].toString(),
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

  // void _signUp() async {
  //   var data = {
  //     'first_name': firstName.toString(),
  //     'last_name': lastName.toString(),
  //     'mobile': phoneNumber.toString(),
  //     'email': email.toString()
  //   };
  //   print(data);

  //   var response = await Provider.of<Network>(context, listen: false)
  //       .signUp(data, 'api/register/');
  //   print(response.body);
  //   if (response.body == 'Otp send your Register Mobile Number sucessfully.') {
  //     Navigator.of(context)
  //         .pushNamed('/otp-screen', arguments: {'mobile': data['mobile']});
  //   }
  // }
}
