import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tanvi_vendor/model/notificationList/notificationList.dart';
import './widget/bottomNavigation.dart';
import './screens/addProducts.dart';
import 'package:provider/provider.dart';
import './model/category/categoryProvider.dart';
import './screens/signIn.dart';
import './screens/signUp.dart';
import './screens/changePassword.dart';
import './model/network/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './model/profile/profileProvider.dart';
import './model/profileStatus/statusProvider.dart';
import './model/profile/businessProfileProvider.dart';
import './model/products/productsProvider.dart';
import './model/sizeList/sizeListProvider.dart';
import './model/measureList/measureListProvider.dart';
import './model/dashboard/monthlyStats.dart';
import './model/orderSummary/orderSummary.dart';
import './screens/viewOrderDetails.dart';
import './model/address/addressChange.dart';
import 'notificationService/localNotificationService.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb){
    await Firebase.initializeApp(
      // name: "web",
        options: FirebaseOptions(
            apiKey: "AIzaSyDuGqpsATuAVjvVnSzTH4YPYD3tGOR2GM0",
            authDomain: "thanvi-to-run-in-web.firebaseapp.com",
            projectId: "thanvi-to-run-in-web",
            storageBucket: "thanvi-to-run-in-web.appspot.com",
            messagingSenderId: "819261290793",
            appId: "1:819261290793:web:7254036f285c28bb2c1f38",
            measurementId: "G-PEPQ7N6CBJ"));
  } else{
    await Firebase.initializeApp();
  }
  // await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  runApp(TanviVendor());
}

class TanviVendor extends StatefulWidget {
  TanviVendorState createState() => TanviVendorState();
}

class TanviVendorState extends State<TanviVendor> {
  bool isAuth = false;

  @override
  void initState() {
    // TODO: implement initState
    checkIfLoggedIn();
    // Provider.of<StatusProvider>(context, listen: false).getStatus();

    super.initState();
  }

  void checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    bool isExpired = JwtDecoder.isExpired(token!);

    print('Tokeeeeeeeeeeeeen $token');
    if (token != null && isExpired == false) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(create: (context) => Authentication()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => StatusProvider()),
        ChangeNotifierProvider(create: (context) => BusinessProfileProvider()),
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => SizeListProvider()),
        ChangeNotifierProvider(create: (context) => MeasureListProvider()),
        ChangeNotifierProvider(create: (context) => MonthlyStatsProvider()),
        ChangeNotifierProvider(create: (context) => OrderSummaryProvider()),
        ChangeNotifierProvider(create: (context) => ChangeLocationProvider()),
        ChangeNotifierProvider(create: ((context) => NotificationList()))
      ],

      builder: (context, child) {
        final provider = Provider.of<StatusProvider>(context).profileStatus;

        // print('Provider $provider');

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: const Color.fromRGBO(236, 236, 248, 1)),
          // home: SignIn(),
          home: isAuth ? CustomBottomNavigation() : SignIn(),
          routes: {
            '/home': (context) => CustomBottomNavigation(),
            '/add-products': (context) => AddProductsPage(),
            '/sign-in': (context) => SignIn(),
            '/sign-up': (context) => SignUp(),
            '/change-password': (context) => ChangePassword(),
            // '/view-order-details': (context) => ViewOrderDetails()
            // '/edit-products': (context) => EditProductsPage()
          },
        );
      },

      // child: MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   theme: ThemeData(
      //       scaffoldBackgroundColor: const Color.fromRGBO(236, 236, 248, 1)),
      //   // home: SignIn(),
      //   home: isAuth ? CustomBottomNavigation() : SignIn(),
      //   routes: {
      //     '/home': (context) => CustomBottomNavigation(),
      //     '/add-products': (context) => AddProductsPage(),
      //     '/sign-in': (context) => SignIn(),
      //     '/sign-up': (context) => SignUp(),
      //     '/change-password': (context) => ChangePassword(),
      //   },
      // ),
    );
  }
}
