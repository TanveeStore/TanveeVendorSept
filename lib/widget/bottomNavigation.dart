import 'package:flutter/material.dart';
import '../screens/orders.dart';
import '../screens/products.dart';
import '../screens/earning.dart';
import '../screens/dashboard.dart';
import '../screens/profile.dart';
import 'package:provider/provider.dart';
import '../model/profileStatus/statusProvider.dart';
import '../model/orderSummary/orderSummary.dart';
import '../model/profile/profileProvider.dart';

class CustomBottomNavigation extends StatefulWidget {
  CustomBottomNavigationState createState() => CustomBottomNavigationState();
}

class CustomBottomNavigationState extends State<CustomBottomNavigation> {
  bool isLoading = true;
  int index = 2;
  final screens = [Orders(), Products(), Dashboard(), Earnings(), Profile()];

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<StatusProvider>(context, listen: false).getStatus().then((_) {
      Provider.of<OrderSummaryProvider>(context, listen: false)
          .getOrderHistory()
          .then((_) {
        Provider.of<OrderSummaryProvider>(context, listen: false)
            .getRecentOrder()
            .then((_) {
          Provider.of<ProfileProvider>(context, listen: false)
              .fetchProfileDetails()
              .then((_) {
            setState(() {
              isLoading = false;
            });
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;
    final provider =
        Provider.of<StatusProvider>(context, listen: false).profileStatus;

    // TODO: implement build
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : (provider['data']['status'] == 'incomplete' ||
                    provider['data']['status'] == 'in review' ||
                    provider['data']['status'] == 'rejected')
                ? Profile()
                : screens[index],
        extendBody: true,
        bottomNavigationBar: Container(
          height: height * 0.06,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: height * 0.02),
          // color: Colors.red,
          // padding: EdgeInsets.only(
          //   left: width * 0.15, top: height * 0.08,
          //   //  right: width * 0.04
          // ),
          // padding: EdgeInsets.only(top: height * 0.035),
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: width * 0.75,
                  height: tabLayout ? height * 0.1 : height * 0.05,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 2))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: double.infinity,
                        width: width * 0.35,
                        padding: EdgeInsets.only(left: width * 0.065),
                        // color: Colors.red,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              // onTap: () =>
                              //     Navigator.of(context).pushNamed('/cart-screen'),
                              onTap: () {
                                // Navigator.of(context).pushNamed('/cart-screen');
                                // print('Cart Screen');
                                setState(() {
                                  index = 0;
                                });
                              },
                              // onTap: () {
                              //   screens[selectedItem] = 0 as StatefulWidget;
                              // setState(() {

                              // });

                              child: Icon(Icons.menu_book,
                                  size: tabLayout ? 45 : 24,
                                  color: Color.fromARGB(255, 36, 71, 100)),
                            ),
                            SizedBox(width: width * 0.1),
                            InkWell(
                              // onTap: () => Navigator.of(context)
                              //     .pushNamed('/dashboard-screen'),
                              onTap: () {
                                // Navigator.of(context)
                                //     .pushNamed('/dashboard-screen');
                                // print('Dashboard Screen');
                                setState(() {
                                  index = 1;
                                });
                              },
                              // onTap: () {
                              //   screens[selectedItem] = 1 as StatefulWidget;
                              //   // setState(() {

                              //   // });
                              // },
                              child: Icon(Icons.shopping_bag,
                                  size: tabLayout ? 45 : 24,
                                  color: Color.fromARGB(255, 36, 71, 100)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        width: width * 0.35,
                        // padding: EdgeInsets.only(right: width * 0.02),
                        // color: Colors.blue,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.06),
                              child: InkWell(
                                // onTap: () => Navigator.of(context)
                                //     .pushNamed('/notification-screen'),
                                onTap: () {
                                  // Navigator.of(context)
                                  //     .pushNamed('/notification-screen');
                                  // print('Notification Screen');
                                  setState(() {
                                    index = 3;
                                  });
                                },
                                // onTap: () {
                                //   screens[selectedItem] = 3 as StatefulWidget;
                                //   // setState(() {

                                //   // });
                                // },
                                child: Icon(Icons.money,
                                    size: tabLayout ? 45 : 24,
                                    color: Color.fromARGB(255, 36, 71, 100)),
                              ),
                            ),
                            SizedBox(width: width * 0.1),
                            InkWell(
                                // onTap: () {
                                //   screens[selectedItem] = 4 as StatefulWidget;
                                //   // setState(() {

                                //   // });
                                // },
                                // onTap: () => Navigator.of(context)
                                //     .pushNamed('/profile-screen'),
                                onTap: () {
                                  // Navigator.of(context)
                                  //     .pushNamed('/profile-screen');
                                  // print('Profile Screen');
                                  setState(() {
                                    index = 4;
                                  });
                                },
                                child: Icon(Icons.person,
                                    size: tabLayout ? 45 : 24,
                                    color: Color.fromARGB(255, 36, 71, 100)))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.of(context).pushNamed('/home-screen');
            setState(() {
              index = 2;
            });
          },
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              // height: height * 0.075,
              // width: width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 5, offset: Offset(0, 2))
                  ],
                  border: Border.all(
                      color: Colors.green, width: 2, style: BorderStyle.solid)),
              child: const Center(
                  child: Icon(Icons.menu,
                      color: Color.fromARGB(255, 36, 71, 100))),
            ),
          ),
        ));
  }
}
