import 'package:flutter/material.dart';

import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/custom_radio_button.dart';
import 'package:ghumo_24/components/text_field_cart.dart';

import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/room_category_model.dart';
import 'package:ghumo_24/model/room_detail_model.dart';
import 'package:ghumo_24/screens/home_screen.dart';
import 'package:ghumo_24/screens/menu/menu.dart';
import 'package:ghumo_24/screens/room_details3.dart';

import 'package:ghumo_24/services/base_client.dart';
import 'package:ghumo_24/utills/textthem.dart';
// ignore: depend_on_referenced_packages
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

// ignore: depend_on_referenced_packages
import 'package:future_progress_dialog/future_progress_dialog.dart';

class UpdateRoomDetail extends StatefulWidget {
  final String roomId;
  final String propertId;
  UpdateRoomDetail({
    Key? key,
    required this.roomId,
    required this.propertId,
  }) : super(key: key);

  @override
  State<UpdateRoomDetail> createState() => _UpdateRoomDetailState();
}

class _UpdateRoomDetailState extends State<UpdateRoomDetail> {
  BaseClient baseClient = BaseClient();
  TextEditingController timeinput = TextEditingController();
  GlobalKey<FormState> _addroomFormKey = GlobalKey<FormState>();

  int adultNo = 0;
  int childNo = 0;
  //text editing controller for text field

  @override
  void initState() {
     getroom2();
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  TextEditingController extraAdultPriceController = TextEditingController();
  TextEditingController bedTypeController = TextEditingController();
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();
  TextEditingController mealController = TextEditingController();
  TextEditingController extraChildPriceController = TextEditingController();

  bool addBed = false;
  bool addPerson = false;
  bool twoSingleBed = false;
  bool fourBedFamilyroom = false;
  RoomCategoryModel? roomCategoryModel;
  RoomDetailModel? roomDetailModel;
  String bedvalue = "Select Bed Type";
  bool isloading = false;

  

  getroom2() async {
    var response = await baseClient.get(false, Config.apiURL,
        "${Config.getRoomByPropertId}${widget.propertId}");
    var data = roomDetailModelFromJson(response);
    if (data != null) {
      roomDetailModel = data;
      setState(() {
        extraAdultPriceController.text =
            roomDetailModel!.room!.first.extraAdult == null
                ? ""
                : roomDetailModel!.room!.first.extraAdult!.toString();
        addBed = roomDetailModel!.room!.first.additionalBed == null
            ? false
            : roomDetailModel!.room!.first.additionalBed!;
        addPerson = roomDetailModel!.room!.first.additionalMatress == null
            ? false
            : roomDetailModel!.room!.first.additionalMatress!;
        extraChildPriceController.text =
            "${roomDetailModel!.room!.first.extraChildPrice == null ? "" : roomDetailModel!.room!.first.extraChildPrice.toString()}";
      });
    }
  }

  updateRoom() async {
    setState(() {
      isloading = true;
    });
    var headers = {
      'Authorization': 'Bearer ${BaseClient.box.read("logintoken")}',
    };
    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
          "${Config.apiURL}${Config.updateRoom}${widget.roomId}",
        ));
    request.fields.addAll({
      'extraAdult': '${adultNo}',
      'extraAdultPrice': '${extraAdultPriceController.text}',
      'extraChild': '${childNo}',
      'extraChildPrice': '${extraChildPriceController.text}',
      'additionalBed': '${addBed}',
      'additionalMatress': '${addPerson}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update Room Detail Successfully')));
      // // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RoomDetails3()));

      print(await response.stream.bytesToString());
    } else {
      setState(() {
        isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed  to Update Property')));
      print(response.reasonPhrase);
    }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "images/ghumologo.png",
                  width: w * 0.6,
                  height: h * 0.07,
                ),
                SizedBox(
                  width: 30,
                ),
                 PopupMenuButton(onSelected: (value) {
            print("=====value======$value==============");

            if (value == "logout") {
              var box2 = GetStorage();
              box2.erase();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false,
              );
            } else {
              Navigator.of(context).pop();
            }

            // Navigator.pushNamed(context, value.toString());
          }, itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                onTap: () {},
                child: Text("My Account"),
                value: 'my_account',
              ),
              PopupMenuItem(
                child: Text("Privacy Policy"),
                value: 'privacy_policy',
              ),
              PopupMenuItem(
                child: Text("Help"),
                value: 'help',
              ),
              PopupMenuItem(
                child: Text("Logout"),
                value: 'logout',
              )
            ];
          })
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
                "Update your Room Details",
                style: Texttheme.heading1,
              )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
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
                            adultNo > 1 ? adultNo -= 1 : adultNo = 1;
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
                              adultNo.toString(),
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
                            adultNo = adultNo + 1;
                          });
                        },
                      ),
                    ],
                  ),

                  MyTextFormField(
                    mycontroller: extraAdultPriceController,
                    radius: 15.0,
                    bordercolor: const Color.fromARGB(255, 255, 255, 255),
                    borderwidth: 0.0,
                    width: 0.9,
                    height: 0.055,
                    contentpadding: 45.0,
                    hinttxt: "Enter Extra adult Price",
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
                        return "Enter Enter Extra adult Price";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Number of Extra Child allowed "),
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
                            childNo > 1 ? childNo -= 1 : childNo = 1;
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
                              childNo.toString(),
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
                            childNo = childNo + 1;
                          });
                        },
                      ),
                    ],
                  ),
                  //  const SizedBox(
                  //   height: 20,
                  // ),
                  MyTextFormField(
                    mycontroller: extraChildPriceController,
                    radius: 15.0,
                    bordercolor: const Color.fromARGB(255, 255, 255, 255),
                    borderwidth: 0.0,
                    width: 0.9,
                    height: 0.055,
                    contentpadding: 45.0,
                    hinttxt: "Enter Extra Child Price",
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
                        return "Please enter Extra Child Price";
                      } else {
                        return null;
                      }
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Text("Additional bed for additional Person",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      CustumRadioButton(
                          onPress: () {
                            setState(() {
                              addBed = true;
                            });

                            print("===addBed======$addBed=========");
                          },
                          text: "Yes",
                          index: true,
                          value: addBed),
                      SizedBox(
                        width: 10,
                      ),
                      CustumRadioButton(
                          onPress: () {
                            setState(() {
                              addBed = false;
                            });

                            print("===addBed======$addBed=========");
                          },
                          text: "NO",
                          index: false,
                          value: addBed)
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Text("Additional mattress provided for additional person",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      CustumRadioButton(
                          onPress: () {
                            setState(() {
                              addPerson = true;
                            });
                            print(
                                "======addPerson==========$addPerson=============");
                          },
                          text: "Yes",
                          index: true,
                          value: addPerson),
                      SizedBox(
                        width: 10,
                      ),
                      CustumRadioButton(
                          onPress: () {
                            setState(() {
                              addPerson = false;
                            });
                            print(
                                "======addPerson==========$addPerson=============");
                          },
                          text: "NO",
                          index: false,
                          value: addPerson)
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  isloading
                      ? Container(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // MyButton(
                            //   onpress: () {
                            //     Navigator.of(context).pop();
                            //   },
                            //   btnname: const Icon(
                            //     Icons.arrow_back,
                            //     color: Colors.blue,
                            //     size: 30.0,
                            //   ),
                            //   width: 0.16,
                            //   height: 0.08,
                            //   btncolor:
                            //       const Color.fromARGB(255, 255, 255, 255),
                            // ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            MyButton(
                              onpress: () {
                                if (validateAndSave()) {
                                  updateRoom();
                                }
                              },
                              btnname: const Icon(
                                Icons.arrow_forward,
                                color: Colors.blue,
                                size: 30.0,
                              ),
                              width: 0.16,
                              height: 0.08,
                              btncolor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 25,
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
