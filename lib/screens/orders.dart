import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/orderSummary/orderSummary.dart';
import '../screens/viewOrderDetails.dart';
import '../model/profile/profileProvider.dart';

class Orders extends StatefulWidget {
  OrdersState createState() => OrdersState();
}

class OrdersState extends State<Orders> {
  DateFormat dateFormat = DateFormat('dd-MMM-yyyy HH:mm:ss');

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;
    final provider = Provider.of<OrderSummaryProvider>(context).orderList;
    final profileProvider = Provider.of<ProfileProvider>(context).profile;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.1,
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
                            'Hi, ${profileProvider['data']['first_name']}',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 36, 71, 100),
                                fontWeight: FontWeight.bold,
                                fontSize: tabLayout ? 40 : 22),
                          ),
                          SizedBox(height: height * 0.005),
                          Text(DateFormat.yMMMMd().format(DateTime.now()),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 99, 118, 134),
                                  fontSize: tabLayout ? 40 : 22))
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
                          // Icon(
                          //   Icons.notifications,
                          //   size: tabLayout ? height * 0.05 : height * 0.04,
                          //   color: const Color.fromARGB(255, 99, 118, 134),
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Positioned(
            //     top: height * 0.01,
            //     right: width * 0.02,
            //     child: CircleAvatar(
            //       radius: width * 0.02,
            //       backgroundColor: Colors.red,
            //       child: Text(
            //         '9+',
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold,
            //             fontSize: tabLayout ? 16 : 12),
            //       ),
            //     ))
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        // color: Colors.red,
        child: provider['data'].length == 0
            ? const Center(
                child: Text('No Orders'),
              )
            : ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                  child: Container(
                    width: double.infinity,
                    // height: height * 0.24,
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(1, 2))
                        ]),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: height * 0.045,
                          // color: Colors.green,
                          margin: EdgeInsets.only(
                              left: width * 0.02,
                              top: height * 0.01,
                              right: width * 0.02),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  height: double.infinity,
                                  // color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider['data'][index]['order']
                                            ['order_number'],
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 36, 71, 100),
                                            fontWeight: FontWeight.bold,
                                            fontSize: tabLayout ? 22 : 14),
                                      ),
                                      SizedBox(height: height * 0.002),
                                      Text(
                                        '${dateFormat.format(DateTime.parse(provider['data'][index]['order']['created_at']).toLocal())}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: tabLayout ? 22 : 14),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  height: double.infinity,
                                  // color: Colors.amber,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '₹${provider['data'][index]['order']['grand_total']}',
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 36, 71, 100),
                                            fontWeight: FontWeight.bold,
                                            fontSize: tabLayout ? 30 : 20),
                                      ),
                                      SizedBox(width: width * 0.002),
                                      Text(
                                        '(${provider['data'][index]['order']['payment_status']})',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: tabLayout ? 22 : 15),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.002),
                        Padding(
                          padding: EdgeInsets.only(
                              left: tabLayout ? width * 0.05 : width * 0.1,
                              right: tabLayout ? width * 0.05 : width * 0.1),
                          child: const Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                        ),
                        // SizedBox(height: height * 0.02),
                        Container(
                          width: double.infinity,
                          height: height * 0.06,
                          // color: Colors.blue,
                          margin: EdgeInsets.only(
                              left: width * 0.02, right: width * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer Name',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: tabLayout ? 22 : 14),
                              ),
                              Text(
                                provider['data'][index]['order']['address']
                                    ['name'],
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 36, 71, 100),
                                    fontWeight: FontWeight.bold,
                                    fontSize: tabLayout ? 22 : 14),
                              )
                            ],
                          ),
                        ),
                        // SizedBox(height: height * 0.001),
                        Padding(
                          padding: EdgeInsets.only(
                              left: tabLayout ? width * 0.05 : width * 0.1,
                              right: tabLayout ? width * 0.05 : width * 0.1),
                          child: const Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                        ),
                        // SizedBox(height: height * 0.01),
                        Container(
                          width: double.infinity,
                          height: height * 0.06,
                          // color: Colors.blue,
                          margin: EdgeInsets.only(
                              left: width * 0.02, right: width * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery Status',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: tabLayout ? 22 : 14),
                              ),
                              Text(
                                provider['data'][index]['order']
                                    ['order_status'],
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 36, 71, 100),
                                    fontWeight: FontWeight.bold,
                                    fontSize: tabLayout ? 22 : 18),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ViewOrderDetails(
                                          provider['data'][index]['id']
                                              .toString()))),
                              child: Text(
                                'View Details',
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 36, 71, 100),
                                    fontWeight: FontWeight.bold,
                                    fontSize: tabLayout ? 18 : 14),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.01)
                      ],
                    ),
                  ),
                ),
                itemCount: provider['data'].length,
              ),
      ),
    );
  }
}
