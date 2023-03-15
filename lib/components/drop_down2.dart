import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:ghumo_24/components/image_picker.dart';
import 'package:ghumo_24/components/text_field_cart.dart';

class DropDownList2 extends StatefulWidget {
  DropDownList2({Key? key}) : super(key: key);

  @override
  State<DropDownList2> createState() => _DropDownList2State();
}

class _DropDownList2State extends State<DropDownList2> {
  bool open = false;
  var selectedvalue;
  int selectedvalue1 = 0;
  int selectedvalue2 = 0;
  int selectedvalue3 = 0;
  int selectedvalue4 = 0;
  int selectedvalue5 = 0;
  int selectedvalue6 = 0;
  int smokingallow1 = 0;
  int smokingallow2 = 0;
  int cardallow1 = 0;
  int cardallow2 = 0;
  bool passpostchecked = false;
  bool aadharchecked = false;
  bool drivinglicensechecked = false;
  bool governmentidchecked = false;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(

      child: Container(
        width: w * 0.97,
        child: Column(
          children: [
            Accordion(
                maxOpenSections: 1,
                headerBackgroundColorOpened: Colors.black54,
                scaleWhenAnimating: true,
                openAndCloseAnimation: true,
                paddingListBottom: 100.0,
                children: [
                  AccordionSection(
                      paddingBetweenClosedSections: 30.0,
                      paddingBetweenOpenSections: 30.0,
                      contentVerticalPadding: 8.0,
                      contentHorizontalPadding: 8.0,
                      isOpen: open,
                      headerPadding: EdgeInsets.only(
                          left: 20.0, right: 12.0, top: 12.0, bottom: 12.0),
                      headerBackgroundColor: Color.fromARGB(255, 255, 255, 255),
                      contentBackgroundColor:
                          Color.fromARGB(255, 178, 225, 243),
                      contentBorderColor: Color.fromARGB(0, 255, 255, 255),
                      rightIcon: Image.asset(
                        "images/ddicon.png",
                        width: w * 0.03,
                        height: h * 0.03,
                      ),
                      header: Text(
                        "Cancellation Policy",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 14.0),
                      ),
                      content: Column(children: [
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: selectedvalue ?? false,
                                onChanged: (value) {
                                  selectedvalue = value;
                                  setState(() {});
                                }),
                            Text("Non Refundable",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ])),
                  AccordionSection(
                    paddingBetweenClosedSections: 30.0,
                    paddingBetweenOpenSections: 30.0,
                    contentVerticalPadding: 8.0,
                    contentHorizontalPadding: 8.0,
                    isOpen: open,
                    onOpenSection: () {
                      open = true;
                      print(open);
                    },
                    headerPadding: EdgeInsets.only(
                        left: 20.0, right: 12.0, top: 12.0, bottom: 12.0),
                    headerBackgroundColor: Color.fromARGB(255, 255, 255, 255),
                    contentBackgroundColor: Color.fromARGB(255, 178, 225, 243),
                    contentBorderColor: Color.fromARGB(0, 255, 255, 255),
                    rightIcon: Image.asset(
                      "images/ddicon.png",
                      width: w * 0.03,
                      height: h * 0.03,
                    ),
                    header: Text(
                      "Guest Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14.0),
                    ),
                    content: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: w * 0.04,
                            ),
                            Text("Do you allow unmarried couples?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: selectedvalue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedvalue = value;
                                    // selectedvalue2 = 0;
                                  });
                                }),
                            Text("Yes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            Radio(
                                value: 2,
                                groupValue: selectedvalue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedvalue = value;
                                  });
                                }),
                            Text("No",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: w * 0.04,
                            ),
                            Text("Do you allow bachelors?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: selectedvalue3,
                                onChanged: (value) {
                                  setState(() {
                                    selectedvalue3 = 1;
                                    selectedvalue4 = 0;
                                  });
                                }),
                            Text("Yes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            Radio(
                                value: 1,
                                groupValue: selectedvalue4,
                                onChanged: (value) {
                                  setState(() {
                                    selectedvalue4 = 1;
                                    selectedvalue3 = 0;
                                  });
                                }),
                            Text("No",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: w * 0.04,
                            ),
                            Text("Do you allow guest below 18 yrs of age?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: selectedvalue5,
                                onChanged: (value) {
                                  setState(() {
                                    selectedvalue5 = 1;
                                    selectedvalue6 = 0;
                                  });
                                }),
                            Text("Yes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            Radio(
                                value: 1,
                                groupValue: selectedvalue6,
                                onChanged: (value) {
                                  setState(() {
                                    selectedvalue6 = 1;
                                    selectedvalue5 = 0;
                                  });
                                }),
                            Text("No",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AccordionSection(
                    paddingBetweenClosedSections: 30.0,
                    paddingBetweenOpenSections: 30.0,
                    contentVerticalPadding: 8.0,
                    contentHorizontalPadding: 8.0,
                    isOpen: false,
                    headerPadding: EdgeInsets.only(
                        left: 20.0, right: 12.0, top: 12.0, bottom: 12.0),
                    headerBackgroundColor: Color.fromARGB(255, 255, 255, 255),
                    contentBackgroundColor: Color.fromARGB(255, 178, 225, 243),
                    contentBorderColor: Color.fromARGB(0, 255, 255, 255),
                    rightIcon: Image.asset(
                      "images/ddicon.png",
                      width: w * 0.03,
                      height: h * 0.03,
                    ),
                    header: Text(
                      "Acceptable Identity Proofs",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14.0),
                    ),
                    content: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                value: passpostchecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    passpostchecked = value!;
                                  });
                                }),
                            Text("Passpost")
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                value: aadharchecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    aadharchecked = value!;
                                  });
                                }),
                            Text("Aadhar card")
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                value: drivinglicensechecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    drivinglicensechecked = value!;
                                  });
                                }),
                            Text("Driving License")
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                value: governmentidchecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    governmentidchecked = value!;
                                  });
                                }),
                            Text("Government Id")
                          ],
                        ),
                      ],
                    ),
                  ),
                  AccordionSection(
                    paddingBetweenClosedSections: 30.0,
                    paddingBetweenOpenSections: 30.0,
                    contentVerticalPadding: 8.0,
                    contentHorizontalPadding: 8.0,
                    isOpen: false,
                    headerPadding: EdgeInsets.only(
                        left: 20.0, right: 12.0, top: 12.0, bottom: 12.0),
                    headerBackgroundColor: Color.fromARGB(255, 255, 255, 255),
                    contentBackgroundColor: Color.fromARGB(255, 178, 225, 243),
                    contentBorderColor: Color.fromARGB(0, 255, 255, 255),
                    rightIcon: Image.asset(
                      "images/ddicon.png",
                      width: w * 0.03,
                      height: h * 0.03,
                    ),
                    header: Text(
                      "Property Restrictions",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14.0),
                    ),
                    content: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: w * 0.04,
                            ),
                            Text("Is smoking allowed within the permises?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: smokingallow1,
                                onChanged: (value) {
                                  setState(() {
                                    smokingallow1 = 1;
                                    smokingallow2 = 0;
                                  });
                                }),
                            Text("Yes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            Radio(
                                value: 1,
                                groupValue: smokingallow2,
                                onChanged: (value) {
                                  setState(() {
                                    smokingallow2 = 1;
                                    smokingallow1 = 0;
                                  });
                                }),
                            Text("No",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: w * 0.04,
                            ),
                            Text("Are Credit/Debit cards accepted?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: cardallow1,
                                onChanged: (value) {
                                  setState(() {
                                    cardallow1 = 1;
                                    cardallow2 = 0;
                                  });
                                }),
                            Text("Yes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            Radio(
                                value: 1,
                                groupValue: cardallow2,
                                onChanged: (value) {
                                  setState(() {
                                    cardallow2 = 1;
                                    cardallow1 = 0;
                                  });
                                }),
                            Text("No",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
