import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:ghumo_24/components/dynamic_cart.dart';
import 'package:ghumo_24/components/image_picker.dart';
import 'package:ghumo_24/components/text_field_cart.dart';

class DropDownList3 extends StatefulWidget {
  DropDownList3({Key? key}) : super(key: key);

  @override
  State<DropDownList3> createState() => _DropDownList3State();
}

class _DropDownList3State extends State<DropDownList3> {
  bool ironing = false;
  bool balcony = false;
  bool refrigerator = false;
  bool bellboy = false;
  bool telephone = false;
  bool tv = false;
  bool attachedbathroom = false;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          top: h * 0.008,
          child: Container(
            width: w * 0.9,
            height: h * 0.055,
            decoration: BoxDecoration(
              border: (Border.all(width: 0.1, color: Colors.white)),
              borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
              color: Colors.white,
            ),
          ),
        ),
        Container(
            decoration: BoxDecoration(
              border: (Border.all(
                  width: 0.1, color: Color.fromARGB(0, 252, 245, 245))),
              borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
              color: Color.fromARGB(0, 255, 252, 252),
            ),
            width: w * 0.9,
            child: ExpansionTile(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              leading: Image.asset(
                "images/rn.png",
                width: w * 0.06,
                height: h * 0.06,
              ),
              title: Text(
                "Select Amientities in Rooms",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              children: [
                ExpansionTile(
                  title: Container(child: Text("Room Services")),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: ironing,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      ironing = value!;
                                    });
                                  }),
                              Text("Ironing Service")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: balcony,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      balcony = value!;
                                    });
                                  }),
                              Text("Balcony/Terrace")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: refrigerator,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      refrigerator = value!;
                                    });
                                  }),
                              Text("Refrigerator")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: bellboy,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      bellboy = value!;
                                    });
                                  }),
                              Text("Bellboy Service")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: telephone,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      telephone = value!;
                                    });
                                  }),
                              Text("Telephone")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: tv,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      tv = value!;
                                    });
                                  }),
                              Text("TV")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: attachedbathroom,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      attachedbathroom = value!;
                                    });
                                  }),
                              Text("Attached Bathroom")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      ],
    );
  }
}
