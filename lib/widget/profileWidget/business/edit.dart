import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../model/profile/businessProfileProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import '../../../screens/changeAddressScreen.dart';

class EditProfile extends StatefulWidget {
  final Map<String, dynamic> businessDetails;
  final Map<String, dynamic> bankDetails;
  final Map<String, dynamic> addressDetails;

  EditProfileState createState() => EditProfileState();

  EditProfile(this.businessDetails, this.bankDetails, this.addressDetails);
}

class EditProfileState extends State<EditProfile> {
  final key = GlobalKey<FormState>();
  late String organizationName;
  File? imageOne;
  File? imageTwo;

  TextEditingController orgName = TextEditingController();
  TextEditingController telephoneNumberOne = TextEditingController();
  TextEditingController telephoneNumberTwo = TextEditingController();
  TextEditingController companyPanCard = TextEditingController();
  TextEditingController aadharUdyamUdoyog = TextEditingController();
  TextEditingController gstNumber = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController branchName = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController accountNumber = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    bool flag =
        widget.bankDetails['message'] == 'You don\'t have any Bank details'
            ? true
            : false;
    orgName.text = widget.businessDetails['data']['org_name'] ?? '';
    telephoneNumberOne.text =
        widget.businessDetails['data']['telephone_1'] ?? '';
    telephoneNumberTwo.text =
        widget.businessDetails['data']['telephone_2'] ?? '';
    companyPanCard.text =
        widget.businessDetails['data']['company_pancard'] ?? '';
    aadharUdyamUdoyog.text =
        widget.businessDetails['data']['adhar_udyam_udoyog'] ?? '';
    gstNumber.text = widget.businessDetails['data']['gst_number'] ?? '';
    bankName.text =
        flag == true ? '' : widget.bankDetails['data']['acc_bank_name'];
    branchName.text =
        flag == true ? '' : widget.bankDetails['data']['acc_branch_name'];
    ifscCode.text = flag == true ? '' : widget.bankDetails['data']['acc_ifsc'];
    accountNumber.text =
        flag == true ? '' : widget.bankDetails['data']['acc_no'];
    super.initState();
  }

  Future pickFirstImage(ImageSource source) async {
    try {
      final img = await ImagePicker().pickImage(source: source);
      final imageTemporary = File(img!.path);
      print('Temp Image: $imageTemporary');
      setState(() {
        imageOne = imageTemporary;
        print('Image Oneeee $imageOne');
      });
      Provider.of<BusinessProfileProvider>(context, listen: false)
          .imageOne(imageOne);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickSecondImage(ImageSource source) async {
    try {
      final img = await ImagePicker().pickImage(source: source);
      final imageTemporary = File(img!.path);
      print('Temp Image: $imageTemporary');
      setState(() {
        imageTwo = imageTemporary;
        print('Image Twoooooooo $imageTwo');
      });
      Provider.of<BusinessProfileProvider>(context, listen: false)
          .imageTwo(imageTwo);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  String? organisation;
  String? teleOne;
  String? teleTwo;
  String? panCardNumber;
  String? aadharUdyom;
  String? gstNo;
  String? nameOfBank;
  String? nameOfBranch;
  String? ifsc;
  String? accountNo;
  // PlatformFile? panDoc;
  // PlatformFile? aadharDoc;

  String fileOneName = '';
  String fileTwoName = '';

  @override
  void dispose() {
    // TODO: implement dispose
    // _emailFocus.dispose();
    // _mobileNoFocus.dispose();
    // _addressFocus.dispose();
    // _pincodeFocus.dispose();
    // _passwordFocus.dispose();
    // _confirmPasswordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool bank =
        widget.bankDetails['message'] == 'You don\'t have any Bank details'
            ? true
            : false;
    final provider =
        Provider.of<BusinessProfileProvider>(context).businessAddress;
    final providerAddress =
        Provider.of<BusinessProfileProvider>(context).deliveryAddress;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;

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
                    controller: orgName,
                    autofocus: true,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        //hintText: 'Siddhartha Chatterjee',
                        label: Text(
                          'Organization Name',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (org) {
                      if (org!.isEmpty) {
                        return 'Please Enter Organisation Name';
                      } else {
                        organisation = org;
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
                    controller: telephoneNumberOne,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        // //: 'Siddhartha Chatterjee',
                        label: Text(
                          'Telephone Number 1',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (tele1) {
                      if (tele1!.isEmpty) {
                        return 'Please Enter Phone Number';
                      } else {
                        teleOne = tele1;
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
                    controller: telephoneNumberTwo,
                    autofocus: true,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        // //: 'Siddhartha Chatterjee',
                        label: Text(
                          'Telephone Number 2',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (tele2) {
                      if (tele2!.isEmpty) {
                        return 'Please Enter Phone Number';
                      } else {
                        teleTwo = tele2;
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
                    controller: companyPanCard,
                    autofocus: true,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        // //: 'Siddhartha Chatterjee',
                        label: Text(
                          'Company Pan Card',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (panCard) {
                      if (panCard!.isEmpty) {
                        return 'Please Enter Pan Card Number';
                      } else {
                        panCardNumber = panCard;
                      }
                    },
                  )),
              SizedBox(height: height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: height * 0.04,
                    // color: Colors.red,
                    child: Row(
                      children: [
                        // Text('Upload Pan Card Document'),
                        InkWell(
                          onTap: () => pickFirstImage(ImageSource.gallery),
                          // () async {
                          // final filePickerOne = await FilePicker.platform
                          //     .pickFiles(
                          //         type: FileType.custom,
                          //         allowedExtensions: [
                          //       'pdf',
                          //       'jpg',
                          //       'jpeg',
                          //       'png'
                          //     ]);
                          // if (filePickerOne == null) return;

                          // final fileOne = filePickerOne.files.first;
                          // openFile(fileOne);
                          // print('Name: ${fileOne.name}');

                          // setState(() {
                          //   fileOneName = fileOne.name;
                          //   panDoc = fileOne;
                          // });

                          // print('Bytes: ${fileOne.bytes}');
                          // print('Size: ${fileOne.size}');
                          // print('Extension: ${fileOne.extension}');
                          // print('Path: ${fileOne.path}');

                          // final newFile = await saveFile(fileOne);

                          // print('From Path: ${fileOne.path!}');
                          // print('To Path: ${fileOne.path}');

                          // },
                          child: Container(
                            width: width * 0.25,
                            height: height * 0.035,
                            margin: EdgeInsets.only(left: width * 0.02),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 36, 71, 100),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 8,
                                      offset: Offset(1, 2))
                                ]),
                            child: Center(
                              child: Text('Upload Pan Card',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: tabLayout ? 18 : 12)),
                            ),
                          ),
                        ),
                        fileOneName.length == 0
                            ? const Text('No File Selected')
                            : Text(fileOneName)
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: width * 0.03),
                  //   child: Text('PDF Only',
                  //       style: TextStyle(
                  //         fontSize: tabLayout ? 14 : 12,
                  //       )),
                  // )
                ],
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
                    // autofocus: true,
                    controller: aadharUdyamUdoyog,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          'Aadhar Udyam Udoyog',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (aadhar) {
                      if (aadhar!.isEmpty) {
                        return 'Please Enter Aadhar';
                      } else {
                        aadharUdyom = aadhar;
                      }
                    },
                  )),
              SizedBox(height: height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: height * 0.04,
                    // color: Colors.red,
                    child: Row(
                      children: [
                        // Text('Upload Pan Card Document'),
                        InkWell(
                          onTap: () => pickSecondImage(ImageSource.gallery),
                          // onTap: () async {
                          //   final filePickerTwo = await FilePicker.platform
                          //       .pickFiles(
                          //           type: FileType.custom,
                          //           allowedExtensions: [
                          //         'pdf',
                          //         'jpg',
                          //         'jpeg',
                          //         'png'
                          //       ]);
                          //   if (filePickerTwo == null) return;

                          //   final fileTwo = filePickerTwo.files.first;
                          //   openFile(fileTwo);
                          //   print('Name: ${fileTwo.name}');

                          //   setState(() {
                          //     fileTwoName = fileTwo.name;
                          //     aadharDoc = fileTwo;
                          //   });

                          //   print('Bytes: ${fileTwo.bytes}');
                          //   print('Size: ${fileTwo.size}');
                          //   print('Extension: ${fileTwo.extension}');
                          //   print('Path: ${fileTwo.path}');

                          //   final newFile = await saveFile(fileTwo);

                          //   print('From Path: ${fileTwo.path!}');
                          //   print('To Path: ${fileTwo.path}');
                          // },
                          child: Container(
                            width: width * 0.25,
                            height: height * 0.035,
                            margin: EdgeInsets.only(left: width * 0.02),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 36, 71, 100),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 8,
                                      offset: Offset(1, 2))
                                ]),
                            child: Center(
                              child: Text('Upload Aadhar Udyam Udoyog',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: tabLayout ? 15 : 11)),
                            ),
                          ),
                        ),
                        fileTwoName.length == 0
                            ? const Text('No File Selected')
                            : Text(fileTwoName)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.03),
                    child: Text('PDF Only',
                        style: TextStyle(
                          fontSize: tabLayout ? 14 : 12,
                        )),
                  )
                ],
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
                    controller: gstNumber,
                    // autofocus: true,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          'GST Number',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (gst) {
                      if (gst!.isEmpty) {
                        return 'Please Enter GST Number';
                      } else {
                        gstNo = gst;
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
                    controller: bankName,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          'Bank Name',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (nameBank) {
                      if (nameBank!.isEmpty) {
                        return 'Please Enter Bank Name';
                      } else {
                        nameOfBank = nameBank;
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
                    controller: branchName,
                    // autofocus: true,
                    keyboardType: TextInputType.name,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          'Branch Name',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (nameBranch) {
                      if (nameBranch!.isEmpty) {
                        return 'Please Enter Branch Name';
                      } else {
                        nameOfBranch = nameBranch;
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
                    controller: ifscCode,
                    // autofocus: true,
                    keyboardType: TextInputType.name,
                    style: TextStyle(fontSize: tabLayout ? 20 : 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          'Branch IFSC Code',
                          // textScaleFactor: textScale,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: tabLayout ? 20 : 14),
                        )),
                    validator: (ifscNo) {
                      if (ifscNo!.isEmpty) {
                        return 'Please Enter IFSC Code';
                      } else {
                        ifsc = ifscNo;
                        return null;
                      }
                    }),
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
                  // autofocus: true,
                  controller: accountNumber,
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontSize: tabLayout ? 20 : 14),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      label: Text(
                        'Account Number',
                        // textScaleFactor: textScale,
                        style: TextStyle(
                            color: Colors.grey, fontSize: tabLayout ? 20 : 14),
                      )),
                  validator: (numberAccount) {
                    if (numberAccount!.isEmpty) {
                      return 'Please Enter Account Number';
                    } else {
                      accountNo = numberAccount;
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChangeNewLocation())),
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: width * 0.05,
                        top: height * 0.005,
                        right: width * 0.05,
                        bottom: height * 0.005),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Address',
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text(provider['status'] == 'Warning'
                            ? 'No Address Selected'
                            : providerAddress)
                      ],
                    )),
              ),
              SizedBox(height: height * 0.02),
              InkWell(
                onTap: () {
                  if (key.currentState!.validate()) {
                    Provider.of<BusinessProfileProvider>(context, listen: false)
                        .postMethodOne(
                            organisation!.isEmpty
                                ? widget.businessDetails['data']['org_name']
                                : organisation,
                            teleOne!.isEmpty
                                ? widget.businessDetails['data']['telephone_1']
                                : teleOne,
                            teleTwo!.isEmpty
                                ? widget.businessDetails['data']['telephone_2']
                                : teleTwo,
                            panCardNumber!.isEmpty
                                ? widget.businessDetails['data']
                                    ['company_pancard']
                                : panCardNumber,
                            // imageOne,
                            aadharUdyom!.isEmpty
                                ? widget.businessDetails['data']
                                    ['adhar_udyam_udoyog']
                                : aadharUdyom,
                            // imageTwo,
                            gstNo!.isEmpty
                                ? widget.businessDetails['data']['gst_number']
                                : gstNo);

                    Provider.of<BusinessProfileProvider>(context, listen: false)
                        .postBankDetails(
                            nameOfBank!.isEmpty
                                ? widget.bankDetails['data']['acc_bank_name']
                                : nameOfBank,
                            nameOfBranch!.isEmpty
                                ? widget.bankDetails['data']['acc_branch_name']
                                : nameOfBranch,
                            ifsc!.isEmpty
                                ? widget.bankDetails['data']['acc_ifsc']
                                : ifsc,
                            accountNo!.isEmpty
                                ? widget.bankDetails['data']['acc_no']
                                : accountNo);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: Color.fromARGB(255, 36, 71, 100), width: 1)),
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
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  Future<File> saveFile(PlatformFile saveFile) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${saveFile.name}');
    return File(saveFile.path!).copy(newFile.path);
  }
}
