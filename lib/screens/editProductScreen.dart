import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../model/category/categoryProvider.dart';
import 'package:image_picker/image_picker.dart';
import '../model/products/productsProvider.dart';
import '../model/sizeList/sizeListProvider.dart';
import '../model/measureList/measureListProvider.dart';
import './products.dart';
import 'package:uri_to_file/uri_to_file.dart';

class EditProductsPage extends StatefulWidget {
  final int id;
  final String name;
  final String shortDescription;
  final String description;
  final String status;
  final String weight;
  final int qty;
  final double price;
  final double offerPrice;
  final String tax;
  final String mainImage;
  final String category;
  final int categoryId;
  final String size;
  final int sizeId;
  final String measure;
  final int measureId;

  EditProductsPageState createState() => EditProductsPageState();

  EditProductsPage(
      this.id,
      this.name,
      this.shortDescription,
      this.description,
      this.status,
      this.weight,
      this.qty,
      this.price,
      this.tax,
      this.mainImage,
      this.category,
      this.categoryId,
      this.size,
      this.sizeId,
      this.measure,
      this.measureId,this.offerPrice);
}

class EditProductsPageState extends State<EditProductsPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _shortDesc = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  // final TextEditingController _size = TextEditingController();
  final TextEditingController _quantities = TextEditingController();
  final TextEditingController _weighht = TextEditingController();
  final TextEditingController _priceeee = TextEditingController();
  final TextEditingController _taxxx = TextEditingController();
  final TextEditingController _offerPrice = TextEditingController();

  String? dropDownValue;
  String? measureDropDownValue;
  String? sizeDropDownValue;
  String? availablityDropDownValue;
  String? nameOfProduct;
  String? shortDescription;
  String? description;
  String? sizeOfProduct;
  String? quantityOfProduct;
  String? weightOfProduct;
  String? priceOfProduct;
  String? taxAmount;
  String? offerPrice;
  List<dynamic> list = [];
  bool isLoading = true;
  PickedFile? _imageFile;
  File? image;
  File? stringToFile;
  bool first = false;
  PickedFile? _secondImageFile;
  bool second = false;
  final ImagePicker? _imagePicker = ImagePicker();
  // final measure = ['Kg', 'gm', 'ltr'];
  // final available = [
  //   {'value': true, 'data': 'Available'},
  //   {'value': false, 'data': 'Out Of Stock'}
  // ];
  final available = ['Available', 'Out Of Stock'];

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

  // Future pickSecondImage(ImageSource source) async {
  //   try {
  //     final pickedFile = await _imagePicker!.pickImage(source: source);
  //     final imageTemporary = File(pickedFile!.path);
  //     setState(() {
  //       imageTwo = imageTemporary;
  //       // second = true;
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future<void> convertUriToFile() async {
  //   image = await File(widget.mainImage).writeAsString(widget.mainImage);
  //   // try {
  //   //   String uriString = 'content://sample.txt'; // Uri string

  //   //   // Don't pass uri parameter using [Uri] object via uri.toString().
  //   //   // Because uri.toString() changes the string to lowercase which causes this package to misbehave

  //   //   // If you are using uni_links package for deep linking purpose.
  //   //   // Pass the uri string using getInitialLink() or linkStream

  //   //   stringToFile = await toFile(widget.mainImage); // Converting uri to file
  //   //   print('String To File: $stringToFile');
  //   // } on UnsupportedError catch (e) {
  //   //   print(e.message); // Unsupported error for uri not supported
  //   // } on IOException catch (e) {
  //   //   print(e); // IOException for system error
  //   // } catch (e) {
  //   //   print(e); // General exception
  //   // }
  // }

  @override
  void initState() {
    // TODO: implement initState1
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategories()
        .then((_) {
      Provider.of<SizeListProvider>(context, listen: false)
          .getSizeList()
          .then((_) {
        Provider.of<MeasureListProvider>(context, listen: false)
            .getMeasureList()
            .then((_) {
          setState(() {
            isLoading = false;
            // final url = Uri.parse(widget.mainImage);
            // image = File.fromUri(url);
          });
        });
      });
    });

    // convertUriToFile();

    print('Image Edit: $image');
    _title.text = widget.name;
    _shortDesc.text = widget.shortDescription;
    _desc.text = widget.description;
    _quantities.text = widget.qty.toString();
    _weighht.text = widget.weight;
    _priceeee.text = widget.price.toString();
    _taxxx.text = widget.tax.toString();
    _offerPrice.text=widget.offerPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<CategoryProvider>(context).categoryList;
    final sizeProvider = Provider.of<SizeListProvider>(context).sizeList;
    final measureList = Provider.of<MeasureListProvider>(context).measureList;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;

    // final routes =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // final id = routes['id'];
    // final name = routes['name'];
    // final productShortDescription = routes['short_description'];
    // final productDescription = routes['description'];
    // final status = routes['status'];
    // final weight = routes['weight'];
    // final qty = routes['qty'];
    // final price = routes['price'];
    // final tax = routes['tax'];
    // final mainImage = routes['main_image'];
    // final category = routes['category'];
    // final size = routes['size'];
    // final uom = routes['uom'];

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        toolbarHeight: tabLayout ? 100 : 56,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Padding(
            padding: EdgeInsets.only(
                left: width * 0.005,
                top: height * 0.003,
                right: width * 0.005,
                bottom: height * 0.003),
            child: Icon(Icons.arrow_back_ios,
                color: Colors.green, size: tabLayout ? 40 : 24),
          ),
        ),
        title: Text(
          'Edit Products',
          style: TextStyle(
              color: const Color.fromARGB(255, 36, 71, 100),
              fontWeight: FontWeight.bold,
              fontSize: tabLayout ? 35 : 14),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              // color: Colors.red,
              padding: EdgeInsets.all(width * 0.04),
              child: Form(
                key: _key,
                child: ListView(
                  children: [
                    Text(
                      'Select Category',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 36, 71, 100),
                          fontWeight: FontWeight.bold,
                          fontSize: tabLayout ? 25 : 15),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Container(
                        width: width * 0.1,
                        height: height * 0.05,
                        padding: EdgeInsets.only(left: width * 0.02),
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
                              value: dropDownValue == ''
                                  ? widget.categoryId
                                  : dropDownValue,
                              hint: Text(widget.category),
                              style: TextStyle(fontSize: tabLayout ? 20 : 14),
                              items: provider.map((list) {
                                return DropdownMenuItem(
                                    child: Text(list['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: tabLayout ? 20 : 14,
                                            color: Colors.black)),
                                    value: list['id'].toString());
                              }).toList(),
                              onChanged: (selectedDropdownValue) {
                                print(
                                    'selectedDropdownValue: $selectedDropdownValue');
                                setState(() {
                                  dropDownValue =
                                      selectedDropdownValue.toString();
                                });
                              }),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    Text(
                      'Title',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 36, 71, 100),
                          fontWeight: FontWeight.bold,
                          fontSize: tabLayout ? 25 : 15),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Container(
                        // width: width * 0.1,
                        height: height * 0.05,
                        padding: EdgeInsets.only(
                            left: width * 0.02,
                            top: height * 0.005,
                            right: width * 0.02),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 8,
                                  offset: Offset(1, 2))
                            ]),
                        child: TextFormField(
                          controller: _title,
                          style: TextStyle(fontSize: tabLayout ? 20 : 14),
                          decoration: InputDecoration(
                              hintText: 'Enter Name Of Product',
                              hintStyle:
                                  TextStyle(fontSize: tabLayout ? 20 : 14),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                          validator: (name) {
                            if (name!.isEmpty) {
                              return 'Please Enter Name';
                            } else {
                              nameOfProduct = name;
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    Text(
                      'Short Description',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 36, 71, 100),
                          fontWeight: FontWeight.bold,
                          fontSize: tabLayout ? 25 : 15),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Container(
                        height: height * 0.15,
                        padding: EdgeInsets.only(
                            left: width * 0.02, right: width * 0.02),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 8,
                                  offset: Offset(1, 2))
                            ]),
                        child: TextFormField(
                          controller: _shortDesc,
                          style: TextStyle(fontSize: tabLayout ? 20 : 14),
                          maxLines: 5,
                          decoration: InputDecoration(
                              hintText: 'Enter Description',
                              hintStyle:
                                  TextStyle(fontSize: tabLayout ? 20 : 14),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                          validator: (short) {
                            if (short!.isEmpty) {
                              return 'Please Enter Short Description';
                            } else {
                              shortDescription = short;
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    Text(
                      'Description',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 36, 71, 100),
                          fontWeight: FontWeight.bold,
                          fontSize: tabLayout ? 25 : 15),
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Container(
                        height: height * 0.15,
                        padding: EdgeInsets.only(
                            left: width * 0.02, right: width * 0.02),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 8,
                                  offset: Offset(1, 2))
                            ]),
                        child: TextFormField(
                          controller: _desc,
                          style: TextStyle(fontSize: tabLayout ? 20 : 14),
                          maxLines: 5,
                          decoration: InputDecoration(
                              hintText: 'Enter Description',
                              hintStyle:
                                  TextStyle(fontSize: tabLayout ? 20 : 14),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                          validator: (desc) {
                            if (desc!.isEmpty) {
                              return 'Please Enter Desccription';
                            } else {
                              description = desc;
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    Text('Images',
                        style: TextStyle(
                            color: Color.fromARGB(255, 36, 71, 100),
                            fontWeight: FontWeight.bold,
                            fontSize: tabLayout ? 25 : 15)),
                    SizedBox(height: height * 0.01),
                    SizedBox(
                      height: tabLayout ? height * 0.24 : height * 0.22,
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                height: double.infinity,
                                // color: Colors.amber,
                                padding: EdgeInsets.only(
                                    top: height * 0.01, bottom: height * 0.01),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width * 0.3,
                                      height: tabLayout
                                          ? height * 0.165
                                          : height * 0.14,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 36, 71, 100)),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 8,
                                                offset: Offset(1, 2))
                                          ]),
                                      child: image != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                image!,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                'http://34.100.212.22${widget.mainImage}',
                                                fit: BoxFit.cover,
                                              )),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    InkWell(
                                      onTap: () =>
                                          pickImage(ImageSource.gallery),
                                      child: Container(
                                        width: width * 0.4,
                                        height: height * 0.045,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 36, 71, 100),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 8,
                                                  offset: Offset(1, 2))
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.attachment,
                                                color: Colors.white),
                                            SizedBox(width: width * 0.01),
                                            Text('Choose Image',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        tabLayout ? 18 : 14))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Text('Size',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 36, 71, 100),
                            fontWeight: FontWeight.bold,
                            fontSize: tabLayout ? 25 : 15)),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.01),
                          child: Container(
                            // width: width * 0.35,
                            height: tabLayout ? height * 0.04 : height * 0.035,
                            padding: EdgeInsets.only(
                                left: tabLayout ? width * 0.01 : width * 0.02),
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
                                  value: sizeDropDownValue == ''
                                      ? widget.sizeId
                                      : sizeDropDownValue,
                                  hint: Text(widget.size),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  items: sizeProvider.map((sizeList) {
                                    return DropdownMenuItem(
                                        child: Text(sizeList['size'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: tabLayout ? 20 : 14,
                                                color: Colors.black)),
                                        value: sizeList['id'].toString());
                                  }).toList(),
                                  onChanged: (selectedDropdownValue) {
                                    setState(() {
                                      sizeDropDownValue =
                                          selectedDropdownValue.toString();
                                      print(
                                          'Measure DropDownValue $sizeDropDownValue');
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.015),
                    Text('Quantity',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 36, 71, 100),
                            fontWeight: FontWeight.bold,
                            fontSize: tabLayout ? 25 : 15)),
                    SizedBox(height: height * 0.01),
                    Container(
                      height: tabLayout ? height * 0.06 : height * 0.04,
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                          left: width * 0.01, top: height * 0.005),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.25,
                            height: tabLayout ? height * 0.045 : height * 0.035,
                            padding: EdgeInsets.only(
                                left: width * 0.02, top: height * 0.005),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 8,
                                      offset: Offset(1, 2))
                                ]),
                            child: TextFormField(
                              controller: _quantities,
                              style: TextStyle(fontSize: tabLayout ? 20 : 14),
                              decoration: InputDecoration(
                                  hintText: 'Enter Quantity',
                                  hintStyle:
                                      TextStyle(fontSize: tabLayout ? 20 : 13),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none),
                              validator: (quantity) {
                                if (quantity!.isEmpty) {
                                  return 'Please Enter Quantity';
                                } else {
                                  quantityOfProduct = quantity;
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Container(
                            width: width * 0.25,
                            height: tabLayout ? height * 0.045 : height * 0.035,
                            padding: EdgeInsets.only(
                                left: width * 0.02, top: height * 0.004),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 8,
                                      offset: Offset(1, 2))
                                ]),
                            child: TextFormField(
                              controller: _weighht,
                              style: TextStyle(fontSize: tabLayout ? 20 : 14),
                              decoration: InputDecoration(
                                  hintText: 'Enter Weight',
                                  hintStyle:
                                      TextStyle(fontSize: tabLayout ? 20 : 14),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none),
                              validator: (weight) {
                                if (weight!.isEmpty) {
                                  return 'Please Enter Weight';
                                } else {
                                  weightOfProduct = weight;
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Container(
                            // width: width * 0.35,
                            height: tabLayout ? height * 0.045 : height * 0.035,
                            padding: EdgeInsets.only(left: width * 0.02),
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
                                  value: measureDropDownValue == ''
                                      ? widget.measureId
                                      : measureDropDownValue,
                                  hint: Text(widget.measure,
                                      style: TextStyle(
                                          fontSize: tabLayout ? 20 : 12)),
                                  items: measureList.map((list) {
                                    return DropdownMenuItem(
                                        child: Text(list['short_name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: tabLayout ? 20 : 14,
                                                color: Colors.black)),
                                        value: list['id'].toString());
                                  }).toList(),
                                  onChanged: (selectedDropdownValue) {
                                    setState(() {
                                      measureDropDownValue =
                                          selectedDropdownValue.toString();
                                      print('Measure: $measureDropDownValue');
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    Container(
                      height: tabLayout ? height * 0.09 : height * 0.07,
                      width: width * 0.9,
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Container(
                            height: double.infinity,
                            width: width * 0.3,
                            // color: Colors.amber,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 36, 71, 100),
                                        fontWeight: FontWeight.bold,
                                        fontSize: tabLayout ? 25 : 15)),
                                SizedBox(height: height * 0.005),
                                Row(
                                  children: [
                                    Text('₹',
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 36, 71, 100),
                                            fontWeight: FontWeight.bold,
                                            fontSize: tabLayout ? 35 : 25)),
                                    SizedBox(width: width * 0.005),
                                    Container(
                                      width: width * 0.25,
                                      height: tabLayout
                                          ? height * 0.045
                                          : height * 0.035,
                                      padding: EdgeInsets.only(
                                          left: width * 0.02,
                                          top: height * 0.003),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 8,
                                                offset: Offset(1, 2))
                                          ]),
                                      child: TextFormField(
                                        controller: _priceeee,
                                        style: TextStyle(
                                            fontSize: tabLayout ? 20 : 14),
                                        decoration: InputDecoration(
                                            hintText: 'Enter Amount',
                                            hintStyle: TextStyle(
                                              fontSize: tabLayout ? 22 : 13,
                                            ),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none),
                                        validator: (price) {
                                          if (price!.isEmpty) {
                                            return 'Please Enter Price';
                                          } else {
                                            priceOfProduct = price;
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Container(
                            height: double.infinity,
                            width: width * 0.38,
                            // color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Offer Price',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 36, 71, 100),
                                        fontWeight: FontWeight.bold,
                                        fontSize: tabLayout ? 25 : 15)),
                                SizedBox(height: height * 0.005),
                                Row(
                                  children: [
                                    Container(
                                      width: width * 0.31,
                                      height: tabLayout
                                          ? height * 0.045
                                          : height * 0.035,
                                      padding: EdgeInsets.only(
                                          left: width * 0.02,
                                          top: height * 0.002),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 8,
                                                offset: Offset(1, 2))
                                          ]),
                                      child: TextFormField(
                                        controller: _offerPrice,
                                        style: TextStyle(
                                          fontSize: tabLayout ? 20 : 12,
                                        ),
                                        decoration: InputDecoration(
                                            hintText: 'Enter Offer Price',
                                            hintStyle: TextStyle(
                                              fontSize: tabLayout ? 20 : 12,
                                            ),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none),
                                        validator: (offerPrice) {
                                          if (offerPrice!.isEmpty) {
                                            return 'Please Offer Price';
                                          } else {
                                            this.offerPrice = offerPrice;
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    // SizedBox(width: width * 0.005)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    Container(
                      height: tabLayout ? height * 0.09 : height * 0.07,
                      width: width * 0.9,
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Container(
                            height: double.infinity,
                            width: width * 0.38,
                            // color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tax',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 36, 71, 100),
                                        fontWeight: FontWeight.bold,
                                        fontSize: tabLayout ? 25 : 15)),
                                SizedBox(height: height * 0.005),
                                Row(
                                  children: [
                                    Container(
                                      width: width * 0.31,
                                      height: tabLayout
                                          ? height * 0.045
                                          : height * 0.035,
                                      padding: EdgeInsets.only(
                                          left: width * 0.02,
                                          top: height * 0.002),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 8,
                                                offset: Offset(1, 2))
                                          ]),
                                      child: TextFormField(
                                        controller: _taxxx,
                                        style: TextStyle(
                                          fontSize: tabLayout ? 20 : 12,
                                        ),
                                        decoration: InputDecoration(
                                            hintText: 'Enter Tax Amount',
                                            hintStyle: TextStyle(
                                              fontSize: tabLayout ? 20 : 12,
                                            ),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none),
                                        validator: (tax) {
                                          if (tax!.isEmpty) {
                                            return 'Please Enter Tax';
                                          } else {
                                            taxAmount = tax;
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(width: width * 0.01),
                                    Text('%',
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 36, 71, 100),
                                            fontWeight: FontWeight.bold,
                                            fontSize: tabLayout ? 35 : 20)),
                                    // SizedBox(width: width * 0.005)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    Text('Availability',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 36, 71, 100),
                            fontWeight: FontWeight.bold,
                            fontSize: tabLayout ? 25 : 15)),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Container(
                        // width: width * 0.35,
                        height: tabLayout ? height * 0.05 : height * 0.04,
                        padding: EdgeInsets.only(left: width * 0.02),
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
                              value: availablityDropDownValue,
                              hint: Text(widget.status == 'in_stock'
                                  ? 'Available'
                                  : 'Out Of Stock'),
                              style: TextStyle(fontSize: tabLayout ? 20 : 14),
                              items: available.map((list) {
                                return DropdownMenuItem(
                                    child: Text(list,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: tabLayout ? 20 : 14,
                                            color: Colors.black)),
                                    value: list);
                              }).toList(),
                              onChanged: (selectedDropdownValue) {
                                setState(() {
                                  availablityDropDownValue =
                                      selectedDropdownValue.toString();
                                });
                              }),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.1, right: width * 0.1),
                      child: InkWell(
                        onTap: () {
                          if (_key.currentState!.validate()) {
                            editProducts(context);
                          }
                        },
                        child: Container(
                          width: width * 0.2,
                          height: height * 0.05,
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
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: tabLayout ? 20 : 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                  ],
                ),
              ),
            ),
    );
  }

  dynamic editProducts(BuildContext context) async {
    final url = Uri.parse(widget.mainImage);
    print('nameOfProduct: ${_title.text}');
    print('imageOfProduct: $image');
    Provider.of<ProductsProvider>(context, listen: false)
        .putProducts(
            // nameOfProduct,
            widget.id.toString(),
            _title.text,
            _shortDesc.text,
            _desc.text,
            availablityDropDownValue == null
                ? widget.status
                : availablityDropDownValue!,
            _weighht.text,
            _quantities.text,
            _priceeee.text,
            _taxxx.text,
            // image == null ? File(widget.mainImage) : image!,
            image,
            dropDownValue == null
                ? widget.categoryId.toString()
                : dropDownValue!,
            sizeDropDownValue == null
                ? widget.sizeId.toString()
                : sizeDropDownValue!,
            measureDropDownValue == null
                ? widget.measureId.toString()
                : measureDropDownValue!,
      _offerPrice.text
    )
        .then((_) {
      Navigator.push(
              context, MaterialPageRoute(builder: (context) => Products()))
          .then((_) {
        setState(() {
          Provider.of<ProductsProvider>(context, listen: false).getProducts();
        });
      });
    });

    // await Provider.of<ProductsProvider>(context, listen: false).getProducts();

    // var res = json.decode(response.body);
    // if (res['message'] == 'Invalid inputes') {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: const Text('Invalid Input Entered',
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontWeight: FontWeight.bold,
    //         )),
    //     backgroundColor: Colors.green,
    //     action: SnackBarAction(
    //         label: 'OK',
    //         onPressed: () =>
    //             ScaffoldMessenger.of(context).hideCurrentSnackBar()),
    //   ));
    // }
    // Navigator.of(context).pop().then((_) {});
  }
}
