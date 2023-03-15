import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghumo_24/components/text_field_cart.dart';

class DiscountCart extends StatefulWidget {
  const DiscountCart({Key? key}) : super(key: key);

  @override
  State<DiscountCart> createState() => _DiscountCartState();
}

class _DiscountCartState extends State<DiscountCart> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      width: w * 0.9,
      height: h * 0.15,
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: (Border.all(width: 0.1, color: Colors.white)),
        borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
        color: Color.fromARGB(255, 151, 214, 250),
      ),
      child: Column(
        children: [
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            children: [
              SizedBox(width: w * 0.015),
              Text(
                "Room Price",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(width: w * 0.26),
              Text(
                "Discount Price",
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  width: w * 0.35,
                  height: h * 0.05,
                  padding: EdgeInsets.all(5.0),
                  child: MyTextFormField(
                      radius: 5.0,textcolor: Colors.black,
                      contentpadding: 10.0,
                      mycontroller: controller1,
                      color: Colors.white,
                      hintcolor: Colors.black,
                      bordercolor: Colors.white,
                      borderwidth: 0.0,
                      width: 0.2,
                      height: 0.05,
                      length: 10,
                      inptype: TextInputType.number,
                      hinttxt: "₹ 0.0",
                      hts: 15.0,
                      prefixicon: Icon(Icons.currency_rupee))),
              SizedBox(
                width: w * 0.1,
              ),
              Container(
                  width: w * 0.35,
                  height: h * 0.05,
                  padding: EdgeInsets.all(5.0),
                  child: MyTextFormField(
                      radius: 5.0,textcolor: Colors.black,
                      contentpadding: 10.0,
                      mycontroller: controller2,
                      color: Colors.white,
                      hintcolor: Colors.black,
                      bordercolor: Colors.white,
                      borderwidth: 0.0,
                      width: 0.2,
                      height: 0.05,
                      length: 10,
                      inptype: TextInputType.number,
                      hinttxt: "₹ 0.0",
                      hts: 15.0,
                      prefixicon: Icon(Icons.currency_rupee))),
            ],
          )
        ],
      ),
    );
  }
}
