import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghumo_24/components/room_selection.dart';
import 'package:ghumo_24/utills/textthem.dart';

import '../components/dynamic_cart.dart';

class RoomCategoryScreen extends StatefulWidget {
  final String property_id;

  const RoomCategoryScreen({super.key, required this.property_id});

  @override
  State<RoomCategoryScreen> createState() => _RoomCategoryScreenState();
}

class _RoomCategoryScreenState extends State<RoomCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Container(
          width: w,
          height: h,
          child: Stack(
            children: [
             
              Positioned(
                top: w*0.02,
                left: w*0.2,
                
                child: Align(
                  // alignment: Alignment.center,
                  child: Image.asset(
                    "images/ghumologo.png",
                    width: w * 0.6,
                    height: h * 0.07,
                  ),
                ),
              ),
              Positioned(
                  top: h * 0.1,
                  child: MyCart(
                      0.001,
                      1.0,
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                      Color.fromARGB(255, 70, 66, 66),
                      Color.fromARGB(255, 56, 53, 53),
                      Color.fromARGB(255, 255, 255, 255))),
              Positioned(
                  top: h * 0.14,
                  left: w * 0.24,
                  child: Center(
                      child: Text(
                    "Select your room-category",
                    style: Texttheme.heading2,
                  )),),
              Positioned(top: h * 0.21, left: w * 0.02, child: RoomSelection(propertId: "${widget.property_id}",))
            ],
          )),
    ));
  }
}
