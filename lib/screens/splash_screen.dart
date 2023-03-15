import 'package:flutter/material.dart';
import 'package:ghumo_24/components/default_btn.dart';
import 'package:ghumo_24/screens/address.dart';
import 'package:ghumo_24/screens/authentication2.dart';
import 'package:ghumo_24/screens/authetication.dart';
import 'package:ghumo_24/screens/category_room_floors2.dart';
import 'package:ghumo_24/screens/gst.dart';
import 'package:ghumo_24/screens/hotel_amenities.dart';
import 'package:ghumo_24/screens/hotel_detail_done.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Container(
            height: double.infinity,
            width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage("images/bg1.png"))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: h*0.5,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                       DefaultBtn(
                        width: w * 0.8,
                        onTab: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuthenticationScreen2(),
                            ),
                            (route) => false,
                          );
                        },
                        btntext: "List Your Property",
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DefaultBtn(
                        width: w * 0.7,
                        onTab: () {
                         
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuthenticationScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        btntext: "Partner Login",
                      ),

                      SizedBox(
                        height: 30,
                      ),
                     
                    ],
                  ),
                ],
              ))),
    );
  }
}
