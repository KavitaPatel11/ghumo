import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghumo_24/components/apply_button.dart';
import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/policy_card.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/property_detail_model.dart';
import 'package:ghumo_24/screens/gst.dart';
import 'package:ghumo_24/utills/textthem.dart';
import 'package:http/http.dart' as http;
import 'package:ghumo_24/screens/hotel_detail_done.dart';
import 'package:ghumo_24/screens/menu/menu.dart';
import 'package:ghumo_24/services/base_client.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class HotelRoomDetails extends StatefulWidget {
  final String propertId;
  const HotelRoomDetails({Key? key, required this.propertId}) : super(key: key);

  @override
  State<HotelRoomDetails> createState() => _HotelRoomDetailsState();
}

class _HotelRoomDetailsState extends State<HotelRoomDetails> {
  BaseClient baseClient = BaseClient();

  bool _isNonRefound = true;

  bool _isUnmarried = false;
  bool _isBechelors = false;
  bool _isEitheen = false;

  bool _isSmoking = false;
  bool _isCredit = false;

  bool passpostchecked = false;
  bool aadharchecked = false;
  bool drivinglicensechecked = false;
  bool voterIdChecked = false;
  bool panChecked = false;

  bool isopen4 = false;
  bool isopen1 = false;
  bool isopen2 = false;
  bool isopen3 = false;
  bool isProp = false;
  @override
  PropertyDetailModel? propertyDetailModel;

  getproperty() async {
    var response = await baseClient.get(false, Config.apiURL,
        "${Config.getdetailByPropertId}${widget.propertId}");

    var data1 = jsonDecode(response);

    print(
        "=========data1['success']===================${data1['success']}==========");

    if (data1['success'] == true) {
      var data = propertyDetailModelFromJson(response);
      if (data != null) {
        print("-----------daatt is not null---------------");

        print("----------data----$data-----------");
        propertyDetailModel = data;

        if (propertyDetailModel!.data!.guestAllow != null) {
          setState(() {
            _isUnmarried = propertyDetailModel!.data!.guestAllow == null
                ? false
                : propertyDetailModel!.data!.guestAllow!.unmarriedCouples!;

            _isBechelors = propertyDetailModel!.data!.guestAllow == null
                ? false
                : propertyDetailModel!.data!.guestAllow!.bachelors!;

            _isEitheen = propertyDetailModel!.data!.guestAllow == null
                ? false
                : propertyDetailModel!.data!.guestAllow!.guestBelow18!;

            // smoke allow
            _isSmoking = propertyDetailModel!.data!.propertyRestriction == null
                ? false
                : propertyDetailModel!.data!.propertyRestriction!.smokeAllow!;

            _isCredit = propertyDetailModel!.data!.propertyRestriction == null
                ? false
                : propertyDetailModel!
                    .data!.propertyRestriction!.creaditCardAccept!;

            aadharchecked = propertyDetailModel!.data == null
                ? false
                : propertyDetailModel!.data!.acceptIdentityProofs!.aadharCard!;

            passpostchecked = propertyDetailModel!.data!.acceptIdentityProofs ==
                    null
                ? false
                : propertyDetailModel!.data!.acceptIdentityProofs!.passport!;

            drivinglicensechecked =
                propertyDetailModel!.data!.acceptIdentityProofs == null
                    ? false
                    : propertyDetailModel!
                        .data!.acceptIdentityProofs!.drivingLicense!;
          });
        }
      }
    }
  }

  @override
  void initState() {
    getproperty();
    super.initState();
  }

  updatepropertyt() async {
    setState(() {
      isProp = true;
    });
    var headers = {
      'Authorization': 'Bearer ${BaseClient.box.read("logintoken")}'
    };
    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
          "${Config.apiURL}${Config.updatePropertyType}${widget.propertId}",
        ));
    request.fields.addAll({
      'guestAllow[unmarriedCouples]': "$_isUnmarried",
      'guestAllow[Bachelors]': "$_isBechelors",
      'guestAllow[guestBelow18]': "$_isEitheen",
      'AcceptIdentityProofs[passport]': "$passpostchecked",
      'AcceptIdentityProofs[aadharCard]': "$aadharchecked",
      'AcceptIdentityProofs[drivingLicense]': "$drivinglicensechecked",
      'AcceptIdentityProofs[voterId]': "$voterIdChecked",
      'AcceptIdentityProofs[panCard]': "$panChecked",
      'propertyRestriction[smokeAllow]': "$_isSmoking",
      'propertyRestriction[creaditCardAccept]': "$_isCredit"
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      box2.write("propertycreated", true);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HotelDoneScreen()),
        (route) => false,
      );
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    setState(() {
      isProp = false;
    });
  }

  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            body: ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/ghumologo.png",
              width: w * 0.6,
              height: h * 0.07,
            ),
            // Divider(
            //   height: 10,
            //   color: Colors.black,
            // ),
            // SizedBox(
            //   width: 30,
            // ),
            // IconButton(
            //     onPressed: () {
            //       showModalBottomSheet(
            //         shape: const RoundedRectangleBorder(
            //           // <-- SEE HERE
            //           borderRadius: BorderRadius.vertical(
            //             top: Radius.circular(25.0),
            //           ),
            //         ),
            //         context: context,
            //         builder: (BuildContext) => menuPicker(context),
            //       );
            //     },
            //     icon: Icon(Icons.menu))
          ],
        ),
        Divider(
          height: 10,
          color: Colors.black,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
            child: Center(
                child: Text(
              "Tell us about your Property",
              style: Texttheme.heading1,
            ))),
        Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFD3E5E9),
                  Color(0xFFF9F6FF),
                ],
              )),
          child: Column(
            children: [
              Image.asset(
                "images/policies.png",
                width: w * 0.3,
                height: h * 0.05,
              ),
              SizedBox(
                height: 16,
              ),
              PolicyCard(
                  onPress: () {
                    if (isopen1) {
                      setState(() {
                        isopen1 = false;
                      });
                    } else {
                      setState(() {
                        isopen1 = true;
                        isopen2 = false;
                        isopen3 = false;
                        isopen4 = false;
                      });
                    }
                  },
                  title: "Cancellation Policy",
                  content: Column(children: [
                    Row(
                      children: [
                        Radio(
                            value: _isNonRefound,
                            groupValue: _isNonRefound,
                            onChanged: (value) {
                              setState(() {
                                _isNonRefound = !_isNonRefound;
                              });
                              print(
                                  "=======Non Refundable============$_isNonRefound============");
                              setState(() {});
                            }),
                        Text("Non Refundable",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ]),
                  showContent: isopen1),
              SizedBox(
                height: 16,
              ),
              PolicyCard(
                  onPress: () {
                    if (isopen2) {
                      setState(() {
                        isopen2 = false;
                      });
                    } else {
                      setState(() {
                        isopen1 = false;
                        isopen2 = true;
                        isopen3 = false;
                        isopen4 = false;
                      });
                    }
                  },
                  title: "Guest Profile",
                  content: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.04,
                          ),
                          Text("Do you allow unmarried couples?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: true,
                              groupValue: _isUnmarried,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isUnmarried = value!;
                                });
                                print(
                                    "======_isUnmarried======$_isUnmarried=============");
                              }),
                          Text("Yes",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                          Radio(
                              value: false,
                              groupValue: _isUnmarried,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isUnmarried = value!;
                                });
                                print(
                                    "======_isUnmarried======$_isUnmarried=============");
                              }),
                          Text("No",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.04,
                          ),
                          Text("Do you allow bachelors?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: true,
                              groupValue: _isBechelors,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isBechelors = value!;
                                });
                              }),
                          Text("Yes",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                          Radio(
                              value: false,
                              groupValue: _isBechelors,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isBechelors = value!;
                                });
                              }),
                          Text("No",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.04,
                          ),
                          Text("Do you allow guest below 18 yrs of age?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: true,
                              groupValue: _isEitheen,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isEitheen = value!;
                                });
                              }),
                          Text("Yes",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                          Radio(
                              value: false,
                              groupValue: _isEitheen,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isEitheen = value!;
                                });
                              }),
                          Text("No",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ],
                  ),
                  showContent: isopen2),
              SizedBox(
                height: 16,
              ),
              PolicyCard(
                  onPress: () {
                    if (isopen3) {
                      setState(() {
                        isopen3 = false;
                      });
                    } else {
                      setState(() {
                        isopen1 = false;
                        isopen2 = false;
                        isopen3 = true;
                        isopen4 = false;
                      });
                    }
                  },
                  title: "Acceptable Identity Proofs",
                  content: Column(children: [
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
                        Text("Passport")
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
                            value: voterIdChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                voterIdChecked = value!;
                              });
                            }),
                        Text("Voter Id")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: Colors.white,
                            value: panChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                panChecked = value!;
                              });
                            }),
                        Text("Pancard")
                      ],
                    )
                  ]),
                  showContent: isopen3),
              SizedBox(
                height: 16,
              ),
              PolicyCard(
                  onPress: () {
                    if (isopen4) {
                      setState(() {
                        isopen4 = false;
                      });
                    } else {
                      setState(() {
                        isopen1 = false;
                        isopen2 = false;
                        isopen3 = false;
                        isopen4 = true;
                      });
                    }
                  },
                  title: "Property Restrictions",
                  content: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.04,
                          ),
                          Text("Is smoking allowed within the permises?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: true,
                              groupValue: _isSmoking,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isSmoking = value!;
                                });
                              }),
                          Text("Yes",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                          Radio(
                              value: false,
                              groupValue: _isSmoking,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isSmoking = value!;
                                });
                              }),
                          Text("No",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.04,
                          ),
                          Text("Are Credit/Debit cards accepted?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: true,
                              groupValue: _isCredit,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCredit = value!;
                                });
                              }),
                          Text("Yes",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                          Radio(
                              value: false,
                              groupValue: _isCredit,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCredit = value!;
                                });
                              }),
                          Text("No",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ],
                  ),
                  showContent: isopen4),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyButton(
                    onpress: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GstScreen(
                            propertId: widget.propertId,
                          ),
                        ),
                      );
                    },
                    btnname: Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                      size: 30.0,
                    ),
                    width: 0.16,
                    height: 0.07,
                    btncolor: Color.fromARGB(255, 255, 255, 255),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ApplyButton(
                    onpress: () {
                      updatepropertyt();
                    },
                  )
                ],
              )
            ],
          ),
        )
      ],
    )));
  }
}
