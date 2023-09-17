import 'package:flutter/material.dart';
import '../widget/signIn&signUp/signInWidget.dart';

// class SignIn extends StatefulWidget {
//   SignInState createState() => SignInState();
// }

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final tabLayout = width > 600;
    final largeLayout = width > 350 && width < 600;

    // TODO: implement build
    return Scaffold(
      body: Container(
        height: height * 1,
        width: double.infinity,
        decoration: const BoxDecoration(
           /* image: DecorationImage(
                image: AssetImage('assets/images/Rectangle 392.png'),
                fit: BoxFit.cover)*/
        ),
        // margin: EdgeInsets.only(top: height * 0.15),
        padding: EdgeInsets.only(top: height * 0.15),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Welcome',
                // // textScaleFactor: textScaleFactor,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: tabLayout
                        ? width * 0.06
                        : largeLayout
                            ? 35
                            : 18),
              ),
            ),
            Center(
              child: Text(
                'Login to Start Selling',
                // // textScaleFactor: textScaleFactor,
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(154, 154, 154, 1),
                    fontSize: tabLayout
                        ? width * 0.02
                        : largeLayout
                            ? 20
                            : 14),
              ),
            ),
            SizedBox(height: height * 0.04),
            FormWidget(),
          ],
        ),
      ),
    );
  }
}
