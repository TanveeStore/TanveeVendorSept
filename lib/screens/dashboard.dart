import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tanvi_vendor/model/orderSummary/orderSummary.dart';
import '../model/notificationList/notificationList.dart';
import '../notificationService/localNotificationService.dart';
import '../widget/dashboardWidgets/grossSales.dart';
import '../widget/dashboardWidgets/grossEarnings.dart';
import '../widget/dashboardWidgets/totalOrders.dart';
import '../widget/dashboardWidgets/totalProducts.dart';
import '../widget/dashboardWidgets/newOrders.dart';
import 'package:provider/provider.dart';
import '../model/dashboard/monthlyStats.dart';
import '../model/profile/profileProvider.dart';
import 'notificationList.dart';

class Dashboard extends StatefulWidget {
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<MonthlyStatsProvider>(context, listen: false)
        .getStats()
        .then((_) {
      Provider.of<NotificationList>(context, listen: false)
          .getNotificationList()
          .then((_) {
        setState(() {
          isLoading = false;
        });
      });
      // Provider.of<ProfileProvider>(context, listen: false)
      //     .fetchProfileDetails()
      //     .then((_) {

      // });
    });
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<MonthlyStatsProvider>(context).stats;
    final profileProvider = Provider.of<ProfileProvider>(context).profile;
    final notificationLength =
        Provider.of<NotificationList>(context).notificationList;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        toolbarHeight: tabLayout ? height * 0.15 : height * 0.1,
        elevation: 0,
        title: Stack(
          children: [
            Container(
              height: height * 0.1,
              width: double.infinity,
              // color: Colors.red,
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: double.infinity,
                      // color: Colors.amber,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isLoading
                                ? 'Loading...'
                                : 'Hi, ${profileProvider['data']['first_name']}',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 36, 71, 100),
                                fontWeight: FontWeight.bold,
                                fontSize: tabLayout ? 40 : 22),
                          ),
                          SizedBox(height: height * 0.005),
                          Text(DateFormat.yMMMMd().format(DateTime.now()),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 99, 118, 134),
                                  fontSize: tabLayout ? 40 : 20))
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: double.infinity,
                      // color: Colors.green,
                      padding: EdgeInsets.only(
                          top: height * 0.01, right: width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Notifications())),
                            child: Icon(
                              Icons.notifications,
                              size: tabLayout ? height * 0.05 : height * 0.04,
                              color: const Color.fromARGB(255, 99, 118, 134),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: height * 0.01,
                right: width * 0.02,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    : CircleAvatar(
                        radius: width * 0.023,
                        backgroundColor: Colors.red,
                        child: Text(
                          notificationLength['data'].length.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: tabLayout ? 16 : 10),
                        ),
                      ))
          ],
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
              padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Text(
                        'This Month',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 36, 71, 100),
                            fontWeight: FontWeight.bold,
                            fontSize: tabLayout ? 28 : 22),
                      )
                    ],
                  ),
                  // SizedBox(height: height * 0.01),
                  Container(
                    height: tabLayout ? height * 0.7 : height * 0.458,
                    width: double.infinity,
                    // color: Colors.amber,
                    padding: EdgeInsets.only(
                        left: width * 0.02,
                        top: height * 0.02,
                        right: width * 0.02,
                        bottom: height * 0.005),
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          childAspectRatio:
                              !tabLayout && !largeLayout ? 2.4 / 2 : 2.1 / 2,
                          crossAxisSpacing: width * 0.065,
                          mainAxisSpacing: height * 0.03,
                          maxCrossAxisExtent: width * 0.45),
                      children: [
                        GrossSales(provider['data']['gross_sell']
                        // ['total_price__sum']
                            .toString()),
                        GrossEarnings(provider['data']['gross_tax']
                                ['total_tax__sum']
                            .toString()),
                        TotalOrders(
                            provider['data']['total_orders'].toString()),
                        TotalProducts(
                            provider['data']['total_products'].toString())
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New Order',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 36, 71, 100),
                            fontWeight: FontWeight.bold,
                            fontSize: tabLayout ? 28 : 22),
                      ),
                      Text(
                        'See All Orders',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 39, 138, 42),
                            // fontWeight: FontWeight.bold,
                            fontSize: tabLayout ? 22 : 15),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.025),
                  NewOrders(),
                  SizedBox(height: height * 0.04),
                ],
              ),
            ),
    );
  }
}
