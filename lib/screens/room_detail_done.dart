import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghumo_24/screens/profile/views/profile_view.dart';
import 'package:ghumo_24/utills/colors.dart';
import 'package:ghumo_24/utills/textthem.dart';

class RoomDoneScreen extends StatelessWidget {
  RoomDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      // backgroundColor: Colors.red,
      body: Container(
          width: w,
          height: h,
          child: Stack(
            children: [
              Positioned(
                top: h * 0.01,
                left: w * 0.2,
                child: Image.asset(
                  "images/ghumologo.png",
                  width: w * 0.6,
                  height: h * 0.07,
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                child: Container(
                  height: 40,
                  width: w,
                  // color: Colors.yellow,
                  child: Divider(
                    height: 10,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: h * 0.2,
                left: w * 0.34,
                child: Image.asset(
                  "images/greenu.png",
                  width: w * 0.34,
                  height: h * 0.34,
                ),
              ),
              Positioned(
                top: h * 0.245,
                left: w * 0.385,
                child: Image.asset(
                  "images/green.png",
                  width: w * 0.25,
                  height: h * 0.25,
                ),
              ),
              Positioned(
                top: h * 0.32,
                left: w * 0.46,
                child: Image.asset(
                  "images/tick.png",
                  width: w * 0.1,
                  height: h * 0.1,
                ),
              ),
              Positioned(
                  top: h * 0.48,
                  left: w * 0.29,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Awesome!!",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          "Your room detail will be verify within 24 hours by Admin",
                          textAlign: TextAlign.center,
                          style: Texttheme.bodyText1.copyWith(
                              color: AppColor.defaultBlackColor, fontSize: 15),
                        ),
                      )
                    ],
                  )),
              Positioned(
                top: h * 0.63,
                left: w * 0.29,
                child: FloatingActionButton.extended(
                  elevation: 0,
                  backgroundColor: AppColor.neturalGreen,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileView(),
                        ),
                        (route) => false);
                  },
                  icon: Icon(Icons.home),
                  label: Text("Go to home"),
                ),
              )
            ],
          )),
    ));
  }
}
