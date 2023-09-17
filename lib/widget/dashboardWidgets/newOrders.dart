import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tanvi_vendor/screens/viewOrderDetails.dart';
import '../../model/orderSummary/orderSummary.dart';
import 'package:intl/intl.dart';

class NewOrders extends StatefulWidget {
  NewOrdersState createState() => NewOrdersState();
}

class NewOrdersState extends State<NewOrders> {
  bool isLoading = true;
  DateFormat dateFormat = DateFormat('dd-MMM-yyyy HH:mm:ss');

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   Provider.of<OrderSummaryProvider>(context, listen: false)
  //       .getRecentOrder()
  //       .then((_) {
  //     isLoading = false;
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;
    final recentOrder = Provider.of<OrderSummaryProvider>(context).orderRecent;

    // TODO: implement build
    return Container(
      width: double.infinity,
      // height: height * 0.24,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 2, offset: Offset(1, 2))
          ]),
      child: recentOrder['data'].length == 0
          ? const Center(
              child: Text('No Orders Yet'),
            )
          : Column(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recentOrder['data'][0]['order']['order_number'],
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 36, 71, 100),
                                    fontWeight: FontWeight.bold,
                                    fontSize: tabLayout ? 22 : 14),
                              ),
                              SizedBox(height: height * 0.002),
                              Text(
                                '${dateFormat.format(DateTime.parse(recentOrder['data'][0]['order']['created_at']).toLocal())}',
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '₹${recentOrder['data'][0]['order']['grand_total']}',
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 36, 71, 100),
                                    fontWeight: FontWeight.bold,
                                    fontSize: tabLayout ? 30 : 20),
                              ),
                              SizedBox(width: width * 0.002),
                              Text(
                                '(${recentOrder['data'][0]['order']['payment_status']})',
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
                  margin:
                      EdgeInsets.only(left: width * 0.02, right: width * 0.02),
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
                        recentOrder['data'][0]['order']['address']['name'],
                        style: TextStyle(
                            color: const Color.fromARGB(255, 36, 71, 100),
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
                  margin:
                      EdgeInsets.only(left: width * 0.02, right: width * 0.02),
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
                        recentOrder['data'][0]['order']['order_status'],
                        style: TextStyle(
                            color: const Color.fromARGB(255, 36, 71, 100),
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewOrderDetails(
                              recentOrder['data'][0]['id'].toString()))),
                      child: Text(
                        'View Details',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 36, 71, 100),
                            fontWeight: FontWeight.bold,
                            fontSize: tabLayout ? 18 : 14),
                      ),
                    )
                  ],
                ),
                SizedBox(height: height * 0.01)
              ],
            ),
    );
  }
}
