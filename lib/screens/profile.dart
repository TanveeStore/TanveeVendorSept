import 'package:flutter/material.dart';
import '../widget/profileWidget/business.dart';
import '../widget/profileWidget/personal.dart';
import 'package:provider/provider.dart';
import '../model/profile/profileProvider.dart';
import '../model/profile/businessProfileProvider.dart';

class Profile extends StatefulWidget {
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProfileProvider>(context, listen: false)
        .fetchProfileDetails()
        .then((_) {
      // Provider.of<BusinessProfileProvider>(context, listen: false)
      //     .getBankDetails()
      //     .then((_) {
      //   Provider.of<BusinessProfileProvider>(context, listen: false)
      //       .getBusinessProfile()
      //       .then((_) {
      //     setState(() {
      //       isLoading = false;
      //     });
      //   });
      // });
      setState(() {
        isLoading = false;
      });
    });

    // Provider.of<BusinessProfileProvider>(context, listen: false)
    //     .getBankDetails();

    // Provider.of<BusinessProfileProvider>(context, listen: false)
    //     .getBusinessProfile();

    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // final textScale = MediaQuery.of(context).textScaleFactor * 1.2;
    final provider = Provider.of<ProfileProvider>(context).profile;
    final bankDetailsProvider =
        Provider.of<BusinessProfileProvider>(context).bankDetails;
    final businessDetailsProvider =
        Provider.of<BusinessProfileProvider>(context).businessProfile;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        toolbarHeight: tabLayout ? 100 : 56,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        // leading: const Icon(Icons.arrow_back_ios, color: Colors.red),
        title: Text('Profile',
            // textScaleFactor: textScale,
            style: TextStyle(
                color: const Color.fromARGB(255, 36, 71, 100),
                fontWeight: FontWeight.bold,
                fontSize: tabLayout ? 34 : 25)),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: const Color.fromARGB(255, 36, 71, 100),
          labelColor: const Color.fromARGB(255, 36, 71, 100),
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: tabLayout ? 20 : 12),
          tabs: const [
            // Tab(
            //   text: 'Cancelled Orders',
            // ),

            Tab(
              text: 'Personal',
            ),
            Tab(
              text: 'Business',
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : TabBarView(
              controller: tabController,
              children: [
                // CancelledOrders(),
                Personal(
                    provider['data']['first_name'] ?? '',
                    provider['data']['last_name'] ?? '',
                    provider['data']['email'] ?? '',
                    provider['data']['mobile'] ?? '',
                    provider['data']['alternate_email'] ?? 'Optional',
                    provider['data']['profile_pic'] ?? ''),
                Business(),
              ],
            ),
    );
  }
}
