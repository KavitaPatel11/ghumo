import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/text_field_cart.dart';

import 'package:ghumo_24/components/textfileds/prefixicon_textfield.dart';
import 'package:ghumo_24/components/textfileds/suffix_icontextformfiled.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/create_room_response.dart';
import 'package:ghumo_24/model/room_detail_model.dart';

import 'package:ghumo_24/screens/update_room_details.dart';
import 'package:ghumo_24/services/base_client.dart';
import 'package:ghumo_24/utills/textthem.dart';

import 'package:snippet_coder_utils/hex_color.dart';
import 'package:intl/intl.dart';

import 'package:future_progress_dialog/future_progress_dialog.dart';

class AddRoomDetail extends StatefulWidget {
  final String categoryName;
  final String propertyId;

  AddRoomDetail(
      {Key? key, required this.categoryName, required this.propertyId})
      : super(key: key);

  @override
  State<AddRoomDetail> createState() => _AddRoomDetailState();
}

class _AddRoomDetailState extends State<AddRoomDetail> {
  BaseClient baseClient = BaseClient();
  TextEditingController timeinput = TextEditingController();
  GlobalKey<FormState> _addroomFormKey = GlobalKey<FormState>();

  int roomVal = 1;
  int guestVal = 1;
  //text editing controller for text field

  @override
  void initState() {
    // getroom();
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  TextEditingController roomNameController = TextEditingController();
  TextEditingController bedTypeController = TextEditingController();
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();
  TextEditingController mealController = TextEditingController();
  TextEditingController tarifController = TextEditingController();

  bool king = false;
  bool queen = false;
  bool twoSingleBed = false;
  bool fourBedFamilyroom = false;
  String bedvalue = "Select Bed Type";

  bool isloading = false;

  RoomDetailModel? propertyDetailModel;

  getroom() async {
    setState(() {
      isloading = true;
    });
    var response = await baseClient.get(false, Config.apiURL,
        "${Config.getRoomByPropertId}${widget.propertyId}");

    var data1 = jsonDecode(response);

    print(
        "=========data1['success']===================${data1['success']}==========");

    if (data1['success'] == true) {
      var data = roomDetailModelFromJson(response);
      if (data != null) {
        print("-----------daatt is not null---------------");

        print("----------data----$data-----------");

        setState(() {
          propertyDetailModel = data;
          roomNameController.text =
              propertyDetailModel!.room!.first.roomName == null
                  ? ""
                  : propertyDetailModel!.room!.first.roomName!;
          bedTypeController.text =
              propertyDetailModel!.room!.first.bedType == null
                  ? ""
                  : propertyDetailModel!.room!.first.bedType!;

          tarifController.text =
              propertyDetailModel!.room!.first.roomTariff == null
                  ? ""
                  : propertyDetailModel!.room!.first.roomTariff.toString();
          mealController.text =
              propertyDetailModel!.room!.first.mealOption == null
                  ? ""
                  : propertyDetailModel!.room!.first.mealOption!;
          checkInController.text =
              propertyDetailModel!.room!.first.checkInTime == null
                  ? ""
                  : propertyDetailModel!.room!.first.checkInTime!;
          checkOutController.text =
              propertyDetailModel!.room!.first.checkOutTime == null
                  ? ""
                  : propertyDetailModel!.room!.first.checkOutTime!;

          roomVal = int.parse(
              "${propertyDetailModel!.room!.first.availableRoom == null ? "" : propertyDetailModel!.room!.first.availableRoom!}");
          guestVal = int.parse(
              "${propertyDetailModel!.room!.first.maxGuest == null ? "" : propertyDetailModel!.room!.first.maxGuest!}");

          isloading = false;
        });
      }
    }
    setState(() {
      isloading = false;
    });
  }

  createRoom() async {
    var data = {
      "roomName": roomNameController.text,
      "availableRoom": roomVal.toInt(),
      "bedType": bedTypeController.text,
      "roomTariff": int.parse(tarifController.text),
      "maxGuest": guestVal.toInt(),
      "mealOption": mealController.text,
      "checkInTime": checkInController.text.toString(),
      "checkOutTime": checkOutController.text.toString(),
      // "checkInTime": "3/13/2000",
      // "checkOutTime": "3/12/2000",
      "roomCategory": "${widget.categoryName}"
    };

    print("============data=========$data===========");

    print(
        "===============url======${Config.apiURL}${Config.createRoom}${box2.read("property_id")}/${box2.read("user_id")}======================================\n=========");
    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.post(
        true,
        "${Config.apiURL}",
        "${Config.createRoom}${widget.propertyId}/${box2.read("user_id")}",
        data,
      )),
    );

    print(
        "======${box2.read("logintoken")}=========\n==propery ID===${box2.read("property_id")}========apiResponse=======$apiResponse====user=/${box2.read("user_id")}======");
    if (apiResponse != null) {
      var data = createRoomResponseFromJson(apiResponse);
      box2.write("room_id", data.room!.id);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Add Room Detail Successfully')));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdateRoomDetail(
                  roomId: "${data.room!.id}",
                  propertId: "${widget.propertyId}")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed  to Update Property')));
    }
  }

  BottomSheet() {
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
        child: Column(children: [
          ListTile(
            onTap: () {
              setState(() {
                bedTypeController.text = "King";
              });

              Navigator.of(context).pop();
            },
            title: Text("King"),
          ),
          const Divider(
            height: 5,
          ),
          ListTile(
            onTap: () {
              setState(() {
                bedTypeController.text = "Queen";
              });

              Navigator.of(context).pop();
            },
            title: Text("Queen"),
          ),
          const Divider(
            height: 5,
          ),
          ListTile(
            onTap: () {
              setState(() {
                bedTypeController.text = "2 Single bed";
              });

              Navigator.of(context).pop();
            },
            title: const Text("2 Single bed"),
          ),
          const Divider(
            height: 5,
          ),
          ListTile(
            onTap: () {
              setState(() {
                bedTypeController.text = "4 Bed Family Room";
              });

              Navigator.of(context).pop();
            },
            title: const Text("4 Bed Family Room"),
          ),
        ]),
      ),
    ]);
  }

  mealOtption() {
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
        child: Column(children: [
          ListTile(
            onTap: () {
              setState(() {
                mealController.text = "Accommodation only";
              });

              Navigator.of(context).pop();
            },
            title: Text("Accommodation only"),
          ),
          const Divider(
            height: 5,
          ),
          ListTile(
            onTap: () {
              setState(() {
                mealController.text = "Free Breakfast";
              });

              Navigator.of(context).pop();
            },
            title: Text("Free Breakfast"),
          ),
          const Divider(
            height: 5,
          ),
          ListTile(
            onTap: () {
              setState(() {
                mealController.text = "Free Breakfast and Dinner";
              });

              Navigator.of(context).pop();
            },
            title: const Text("Free Breakfast and Dinner"),
          ),
          const Divider(
            height: 5,
          ),
          ListTile(
            onTap: () {
              setState(() {
                mealController.text = "Free Breakfast and Lunch";
              });

              Navigator.of(context).pop();
            },
            title: const Text("Free Breakfast and Lunch"),
          ),
          const Divider(
            height: 5,
          ),
          ListTile(
            onTap: () {
              setState(() {
                mealController.text = "Free Breakfast,Lunch and Dinner";
              });

              Navigator.of(context).pop();
            },
            title: const Text("Free Breakfast,Lunch and Dinner"),
          ),
        ]),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _addroomFormKey,
        child: ListView(
          children: [
            Image.asset(
              "images/ghumologo.png",
              width: w * 0.6,
              height: h * 0.07,
            ),
            Container(
                width: w,
                child: Divider(
                  color: HexColor("#D9D9D9"),
                  height: 5,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 13),
              child: Center(
                  child: Text(
                "Add Room Details",
                style: Texttheme.heading1,
              )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              // height: h,
              // width: w,
              decoration: BoxDecoration(
                  // border: (Border.all(
                  //     width: 1.0, color: Color.fromARGB(255, 70, 66, 66))),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // HexColor,
                      HexColor("#D3E5E9"),
                      HexColor("#F9F6FF")
                      // Color.fromARGB(255, 56, 53, 53),
                      // Color.fromARGB(255, 255, 255, 255),
                    ],
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFormField(
                    mycontroller: roomNameController,
                    radius: 15.0,
                    bordercolor: const Color.fromARGB(255, 255, 255, 255),
                    borderwidth: 0.0,
                    width: 0.9,
                    height: 0.055,
                    contentpadding: 45.0,
                    hinttxt: "Enter your Room Name",
                    prefixicon: Image.asset(
                      "images/rn.png",
                      width: 10,
                      height: 10,
                    ),
                    color: Colors.white,
                    textInputType: TextInputType.name,
                    // length: 40,
                    hts: 15.0,
                    hintcolor: const Color.fromARGB(255, 126, 122, 122),
                    textcolor: Colors.black,
                    valiadte: (value) {
                      if (value!.isEmpty) {
                        return "Enter your room name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Number of available Rooms"),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Image.asset(
                          "images/minus.png",
                          width: w * 0.1,
                          height: h * 0.1,
                        ),
                        onTap: () {
                          setState(() {
                            roomVal > 1 ? roomVal -= 1 : roomVal = 1;
                          });
                        },
                      ),
                      SizedBox(
                        width: w * 0.03,
                      ),
                      Container(
                          width: w * 0.13,
                          height: h * 0.045,
                          decoration: BoxDecoration(
                            border: (Border.all(
                                width: 1.0,
                                color: Color.fromARGB(255, 173, 166, 166))),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              roomVal.toString(),
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )),
                      SizedBox(
                        width: w * 0.03,
                      ),
                      GestureDetector(
                        child: Image.asset(
                          "images/plus.png",
                          width: w * 0.1,
                          height: h * 0.1,
                        ),
                        onTap: () {
                          setState(() {
                            roomVal = roomVal + 1;
                          });
                        },
                      ),
                    ],
                  ),
                  MyTextFormField(
                    mycontroller: tarifController,
                    radius: 15.0,
                    bordercolor: const Color.fromARGB(255, 255, 255, 255),
                    borderwidth: 0.0,
                    width: 0.9,
                    height: 0.055,
                    contentpadding: 45.0,
                    hinttxt: "Enter your Room Tariff",
                    prefixicon: Image.asset(
                      "images/rn.png",
                      width: 10,
                      height: 10,
                    ),
                    color: Colors.white,
                    textInputType: TextInputType.number,
                    // length: 40,
                    hts: 15.0,
                    hintcolor: const Color.fromARGB(255, 126, 122, 122),
                    textcolor: Colors.black,
                    valiadte: (value) {
                      if (value!.isEmpty) {
                        return "Enter your room Tariff";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SufixIconTextField(
                    hinttext: "Select Bed Type",
                    maxLength: 255,
                    // validate: () {},
                    textInputType: TextInputType.name,
                    controller: bedTypeController,
                    image: 'images/ddicon.png',
                    readOnly: true,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Enter your room Tariff";
                      } else {
                        return null;
                      }
                    },
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          // <-- SEE HERE
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext) => BottomSheet(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Maximum guest allowed in this room"),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Image.asset(
                          "images/minus.png",
                          width: w * 0.1,
                          height: h * 0.1,
                        ),
                        onTap: () {
                          setState(() {
                            guestVal > 1 ? guestVal -= 1 : guestVal = 1;
                          });
                        },
                      ),
                      SizedBox(
                        width: w * 0.03,
                      ),
                      Container(
                          width: w * 0.13,
                          height: h * 0.045,
                          decoration: BoxDecoration(
                            border: (Border.all(
                                width: 1.0,
                                color: Color.fromARGB(255, 173, 166, 166))),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              guestVal.toString(),
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )),
                      SizedBox(
                        width: w * 0.03,
                      ),
                      GestureDetector(
                        child: Image.asset(
                          "images/plus.png",
                          width: w * 0.1,
                          height: h * 0.1,
                        ),
                        onTap: () {
                          setState(() {
                            guestVal = guestVal + 1;
                          });
                        },
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  SufixIconTextField(
                    hinttext: "Select Meal Option",
                    maxLength: 255,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please select meal ";
                      } else {
                        return null;
                      }
                    },
                    textInputType: TextInputType.name,
                    controller: mealController,
                    image: 'images/ddicon.png',
                    readOnly: true,
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          // <-- SEE HERE
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext) => mealOtption(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Check in & Check out time",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Checking Time"),
                            SizedBox(
                              height: 5,
                            ),
                            SufixIconTextField(
                              hinttext: "6:00PM",
                              maxLength: 255,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please, select checkIn Time";
                                } else {
                                  return null;
                                }
                              },
                              textInputType: TextInputType.name,
                              controller: checkInController,
                              image: 'images/alarm.png',
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  // ignore: use_build_context_synchronously
                                  print(pickedTime);

                                  print(
                                      "========pickedTime==========$pickedTime============"); //output 10:51 PM
                                  DateTime tempDate = DateFormat.Hms().parse(
                                      pickedTime.hour.toString() +
                                          ":" +
                                          pickedTime.minute.toString() +
                                          ":" +
                                          '0' +
                                          ":" +
                                          '0');
                                  var dateFormat = DateFormat("h:mm a");

                                  var formattedTime =
                                      dateFormat.format(tempDate);

                                  setState(() {
                                    checkInController.text =
                                        formattedTime; //set the value of text field.
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("CheckOut Time"),
                            SizedBox(
                              height: 5,
                            ),
                            SufixIconTextField(
                              hinttext: "10:00AM",
                              maxLength: 255,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please, select checkOut Time";
                                } else {
                                  return null;
                                }
                              },
                              textInputType: TextInputType.name,
                              controller: checkOutController,
                              image: 'images/alarm.png',
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  // ignore: use_build_context_synchronously
                                  print(pickedTime);

                                  print(
                                      "========pickedTime==========$pickedTime============"); //output 10:51 PM
                                  DateTime tempDate = DateFormat.Hms().parse(
                                      pickedTime.hour.toString() +
                                          ":" +
                                          pickedTime.minute.toString() +
                                          ":" +
                                          '0' +
                                          ":" +
                                          '0');
                                  var dateFormat = DateFormat("h:mm a");

                                  var formattedTime =
                                      dateFormat.format(tempDate);
                                  setState(() {
                                    checkOutController.text =
                                        formattedTime; //set the value of text field.
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  Center(
                    child: MyButton(
                      onpress: () {
                        if (validateAndSave()) {
                          createRoom();
                        }
                      },
                      btnname: const Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                        size: 30.0,
                      ),
                      width: 0.16,
                      height: 0.08,
                      btncolor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  bool validateAndSave() {
    final form = _addroomFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
