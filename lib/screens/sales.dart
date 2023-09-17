import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesReport extends StatefulWidget {
  SalesReportState createState() => SalesReportState();
}

class SalesReportState extends State<SalesReport> {
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 6, 9), end: DateTime(2022, 6, 10));

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;

    final currentData = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final start = dateRange.start;
    final end = dateRange.end;

    print('Start Date $start, End Date $end');

    print('${start.day}-${start.month}-${start.year}');

    print('${end.day}-${end.month}-${end.year}');

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
          'Sales Report',
          style: TextStyle(
              color: const Color.fromARGB(255, 36, 71, 100),
              fontWeight: FontWeight.bold,
              fontSize: tabLayout ? 35 : 14),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.04),
            child: InkWell(
              onTap: () => datePicker(context),
              child: const Icon(Icons.calendar_month,
                  color: Color.fromARGB(255, 36, 71, 100)),
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
      ),
    );
  }

  Future datePicker(BuildContext context) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(2021),
        lastDate: DateTime(2050));

    if (newDateRange == null) {
      return;
    } else {
      setState(() => dateRange = newDateRange);
    }
  }
}
