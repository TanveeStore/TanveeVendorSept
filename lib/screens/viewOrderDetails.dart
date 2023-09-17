import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/orderSummary/orderSummary.dart';

class ViewOrderDetails extends StatefulWidget {
  final String id;
  ViewOrderDetailsState createState() => ViewOrderDetailsState();

  ViewOrderDetails(this.id);
}

class ViewOrderDetailsState extends State<ViewOrderDetails> {
  bool isLoading = true;
  final List<String> moreItems = [
    'Cutomer Details',
    'Delivery Executive Details'
  ];

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<OrderSummaryProvider>(context, listen: false)
        .getOrderDetails(widget.id)
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;
    final provider = Provider.of<OrderSummaryProvider>(context).orderDetails;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(provider['data']?['orderDetails']?['order_number']??"",
            style: const TextStyle(color: Color.fromARGB(255, 36, 71, 100))),
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.green)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: const Icon(Icons.more_vert, color: Colors.green),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : provider['data']['deliveryExeDetails'] == null
              ? const Center(
                  child: Text('No Delivery Executive Assigned'),
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                            top: height * 0.02, bottom: height * 0.001),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  offset: Offset(1, 2))
                            ]),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.32,
                              height: height * 0.15,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  'http://34.100.212.22${provider['data']['productDetails'][index]['product']['main_image']}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height * 0.15,
                                padding: EdgeInsets.only(left: width * 0.03),
                                // color: Colors.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                          provider['data']['productDetails']
                                              [index]['product']['name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24)),
                                    ),
                                    Text(
                                        provider['data']['productDetails']
                                                        [index]['product']
                                                    ['status'] ==
                                                'in_stock'
                                            ? 'Status: Available'
                                            : 'Status: Out Of Stock',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text(
                                        'Quantity: ${provider['data']['productDetails'][index]['quantity']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text(
                                        'Price: ₹${provider['data']['productDetails'][index]['price']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text(
                                        'Weight: ${provider['data']['productDetails'][index]['product_weight']['weight']} ${provider['data']['productDetails'][index]['product_weight']['uom']['short_name']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    itemCount: provider['data']['productDetails'].length,
                  )),
    );
  }
}
