import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:ghumo_24/components/image_picker.dart';
import 'package:ghumo_24/components/text_field_cart.dart';

class GSTDropDownList extends StatelessWidget {
  GSTDropDownList({Key? key}) : super(key: key);
  TextEditingController m20 = TextEditingController();
  TextEditingController m21 = TextEditingController();
  TextEditingController m22 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      width: w * 0.97,
      height: h * 0.4,
      child: Accordion(
          maxOpenSections: 1,
          headerBackgroundColorOpened: Colors.black54,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          paddingListBottom: 100.0,
          children: [
            AccordionSection(
              paddingBetweenClosedSections: 30.0,
              paddingBetweenOpenSections: 30.0,
              contentVerticalPadding: 30.0,
              contentHorizontalPadding: 10.0,
              isOpen: false,
              headerPadding: EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 0.1, bottom: 0.1),
              headerBackgroundColor: Color.fromARGB(255, 255, 255, 255),
              contentBackgroundColor: Color.fromARGB(117, 175, 208, 221),
              contentBorderColor: Color.fromARGB(0, 255, 255, 255),
              leftIcon: Image.asset(
                "images/ai.png",
                width: w * 0.06,
                height: h * 0.06,
              ),
              rightIcon: Image.asset(
                "images/ddicon.png",
                width: w * 0.03,
                height: h * 0.03,
              ),
              header: Container(
                width: w * 0.6,
                height: h * 0.06,
                child: Stack(
                  children: [
                    Positioned(
                        top: h * 0.01,
                        child: Text(
                          "Enter your image to uplode aadhar",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 122, 122),
                              fontSize: 12.0),
                        )),
                    Positioned(
                        top: h * 0.03,
                        child: Text(
                          "Aadhar card",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
              content: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: w * 0.15,
                      ),
                      ImagePickerDemo(),
                      SizedBox(
                        width: w * 0.1,
                      ),
                      ImagePickerDemo(),
                      SizedBox(
                        width: w * 0.15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AccordionSection(
              isOpen: false,
              contentVerticalPadding: 30.0,
              contentHorizontalPadding: 10.0,
              paddingBetweenClosedSections: 30.0,
              paddingBetweenOpenSections: 30.0,
              headerPadding: EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 0.1, bottom: 0.1),
              headerBackgroundColor: Color.fromARGB(255, 255, 255, 255),
              contentBackgroundColor: Color.fromARGB(117, 175, 208, 221),
              contentBorderColor: Color.fromARGB(0, 255, 255, 255),
              leftIcon: Image.asset(
                "images/ai.png",
                width: w * 0.06,
                height: h * 0.06,
              ),
              rightIcon: Image.asset(
                "images/ddicon.png",
                width: w * 0.03,
                height: h * 0.03,
              ),
              header: Container(
                width: w * 0.6,
                height: h * 0.06,
                child: Stack(
                  children: [
                    Positioned(
                        top: h * 0.01,
                        child: Text(
                          "Enter your image to uplode pan",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 122, 122),
                              fontSize: 12.0),
                        )),
                    Positioned(
                        top: h * 0.03,
                        child: Text(
                          "Pan card",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
              content: ImagePickerDemo(),
            ),
            AccordionSection(
              isOpen: false,
              contentVerticalPadding: 10.0,
              contentHorizontalPadding: 10.0,
              headerPadding: EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 0.1, bottom: 0.1),
              headerBackgroundColor: Color.fromARGB(255, 255, 255, 255),
              contentBackgroundColor: Color.fromARGB(117, 175, 208, 221),
              contentBorderColor: Color.fromARGB(0, 255, 255, 255),
              leftIcon: Image.asset(
                "images/ai.png",
                width: w * 0.06,
                height: h * 0.06,
              ),
              rightIcon: Image.asset(
                "images/ddicon.png",
                width: w * 0.03,
                height: h * 0.03,
              ),
              header: Container(
                width: w * 0.6,
                height: h * 0.06,
                child: Stack(
                  children: [
                    Positioned(
                        top: h * 0.01,
                        child: Text(
                          "Enter your image to uplode passbook",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 122, 122),
                              fontSize: 12.0),
                        )),
                    Positioned(
                        top: h * 0.03,
                        child: Text(
                          "Enter your Bank account Details",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
              content: Column(
                children: [
                  MyTextFormField(
                      mycontroller: m20,
                      radius: 5.0,
                      hts: 12.0,
                      color: Colors.white,
                      hintcolor: Color.fromARGB(255, 126, 122, 122),
                      bordercolor: Color.fromARGB(255, 126, 122, 122),
                      borderwidth: 0.5,
                      width: 0.8,
                      height: 0.04,textcolor: Colors.black,
                      contentpadding: 15.0,
                      length: 20,
                      inptype: TextInputType.number,
                      hinttxt: "Enter your bank account number",
                      prefixicon: Icon(Icons.abc)),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(width: w * 0.03),
                      MyTextFormField(
                          mycontroller: m21,
                          hts: 10.0,
                          radius: 5.0,
                          contentpadding: 15.0,textcolor: Colors.black,
                          color: Colors.white,
                          hintcolor: Color.fromARGB(255, 126, 122, 122),
                          bordercolor: Color.fromARGB(255, 182, 175, 175),
                          borderwidth: 0.5,
                          width: 0.365,
                          height: 0.04,
                          length: 20,
                          inptype: TextInputType.number,
                          hinttxt: "Enter your IFSC code",
                          prefixicon:Icon( Icons.abc)),
                      SizedBox(width: w * 0.07),
                      MyTextFormField(
                          mycontroller: m22,
                          contentpadding: 15.0,
                          hts: 10.0,textcolor: Colors.black,
                          radius: 5.0,
                          color: Colors.white,
                          hintcolor: Color.fromARGB(255, 126, 122, 122),
                          bordercolor: Color.fromARGB(255, 255, 255, 255),
                          borderwidth: 0.5,
                          width: 0.365,
                          height: 0.04,
                          length: 20,
                          inptype: TextInputType.number,
                          hinttxt: "Enter your bank name",
                          prefixicon:Icon( Icons.abc)),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  ImagePickerDemo(),
                ],
              ),
            ),
          ]),
    );
  }
}
