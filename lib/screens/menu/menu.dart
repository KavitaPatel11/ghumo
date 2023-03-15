  import 'package:flutter/material.dart';
import 'package:ghumo_24/screens/home_screen.dart';
import 'package:ghumo_24/screens/menu/menu_card.dart';
import 'package:ghumo_24/screens/menu/menu_card_two.dart';
import 'package:ghumo_24/screens/profile/views/profile_view.dart';
import 'package:ghumo_24/screens/propertytype.dart';
import 'package:get_storage/get_storage.dart';

menuPicker(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    return Wrap(children: [
      Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(
              width: 0.1, color: const Color.fromARGB(255, 255, 255, 255)),
          borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
        ),
        // height: h * 0.25,
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                MenuCardTwoTwo(
                    onpress: () {
                      var box2 = GetStorage();
                      box2.erase();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    icns: Icons.logout,
                    text: "Logout"),
                SizedBox(
                  width: 10,
                ),
                MenuCard(
                  onpress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileView()));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    ]);
  }