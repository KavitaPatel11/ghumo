import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghumo_24/utills/textthem.dart';

class StaticCart extends StatelessWidget {
  const StaticCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      width: w * 0.9,
      height: h * 0.055,
      padding: EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        border: (Border.all(width: 0.1, color: Colors.white)),
        borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Image.asset(
            "images/ci.png",
            width: w * 0.05,
            height: h * .05,
          ),
          SizedBox(
            width: w * 0.05,
          ),
          Text(
            "Tap to image to uplode property photos",
            style: Texttheme.subTitle,
          )
        ],
      ),
    );
  }
}
