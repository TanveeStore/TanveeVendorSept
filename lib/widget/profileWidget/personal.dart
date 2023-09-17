import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../screens/signIn.dart';
import './personal/details.dart';
import './personal/edit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../../model/profile/profileProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Personal extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;
  final String alternateEmail;
  final String profilePic;

  PersonalState createState() => PersonalState();

  Personal(this.firstName, this.lastName, this.email, this.mobileNo,
      this.alternateEmail, this.profilePic);
}

class PersonalState extends State<Personal> {
  bool clicked = false;
  File? image;

  @override
  void initState() {
    // TODO: implement initState
    // image = File(widget.profilePic);
    // print('Initiallllll Image: $image');
    super.initState();
  }

  Future pickImage(ImageSource source) async {
    try {
      final img = await ImagePicker().pickImage(source: source);
      final imageTemporary = File(img!.path);
      print('Temp Image: $imageTemporary');
      setState(() {
        image = imageTemporary;
        print('Image $image');
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // bool isLoading = true;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   Provider.of<PersonalProvider>(context, listen: false).fetchData().then((_) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // final textScale = MediaQuery.of(context).textScaleFactor * 1.2;
    const textColor = Color.fromARGB(255, 36, 71, 100);
    final provider = Provider.of<ProfileProvider>(context).profile;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;
    // final provider = Provider.of<PersonalProvider>(context).Personal;

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: height * 0.02),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: height * 0.14,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  // color: Colors.red,
                  child: image != null
                      ? CircleAvatar(
                          radius: width * 0.12,
                          backgroundImage: FileImage(image!),
                        )
                      : image == null && widget.profilePic == ''
                          ? CircleAvatar(
                              radius: width * 0.12,
                              backgroundColor: Colors.blue,
                            )
                          : CircleAvatar(
                              radius: width * 0.12,
                              // child: Image.asset(
                              //   'assets/images/NoPath - Copy (14).png',
                              // ),
                              backgroundImage: NetworkImage(
                                'http://34.100.212.22${widget.profilePic}',
                              ),
                              backgroundColor: Colors.blue,
                              // child: widget.profilePic != ''
                              //     ? Image.network(
                              //       'http://34.100.212.22${widget.profilePic}',
                              //       // fit: BoxFit.fitHeight,
                              //     )
                              //     // ? Image.file(widget.profilePic, fit: BoxFit.cover)
                              //     : image != null
                              //         ? ClipRRect(
                              //             borderRadius:
                              //                 BorderRadius.circular(width * 0.12),
                              //             child: Image.file(
                              //               image!,
                              //               fit: BoxFit.cover,
                              //             ),
                              //           )
                              //         : const Center(
                              //             child: Text('Pick An Image'),
                              //           ),
                            ),
                ),
                clicked
                    ? Positioned(
                        top: height * 0.095,
                        left: width * 0.56,
                        child: InkWell(
                          onTap: () => pickImage(ImageSource.gallery),
                          child: Icon(Icons.camera_alt_rounded,
                              size: height * 0.04, color: textColor),
                        ),
                      )
                    : Container()
              ],
            ),
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: () {
                setState(() {
                  clicked = !clicked;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: textColor, size: tabLayout ? 36 : 24),
                  SizedBox(width: width * 0.01),
                  Text(
                    'Edit Personal',
                    // textScaleFactor: textScale,
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
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.04),
                child: InkWell(
                  onTap: () async {
                    SharedPreferences localStorage =
                        await SharedPreferences.getInstance();
                    localStorage.remove('token');
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => SignIn()));
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/sign-in', (route) => false);
                  },
                  child: Text(
                    'Sign Out',
                    // textScaleFactor: textScale,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: tabLayout ? 18 : 15),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            !clicked
                ? Details(widget.firstName, widget.lastName, widget.email,
                    widget.mobileNo, widget.alternateEmail)
                : EditProfile(
                    widget.firstName,
                    widget.lastName,
                    widget.email,
                    widget.mobileNo,
                    widget.alternateEmail,
                    // image ?? widget.profilePic == '' ? null : widget.profilePic as File
                    image ?? File(widget.profilePic))
          ],
        ),
      ),
    );
  }
}
