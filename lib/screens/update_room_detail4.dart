import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import 'package:flutter/material.dart';
import 'package:ghumo_24/components/text_field_cart.dart';
import 'package:ghumo_24/components/update_button.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/allproperty_detail_response.dart';
import 'package:ghumo_24/model/room_category_model.dart';
import 'package:ghumo_24/model/room_detail_model.dart';
import 'package:ghumo_24/screens/home_screen.dart';
import 'package:ghumo_24/screens/menu/menu_card.dart';
import 'package:ghumo_24/screens/menu/menu_card_two.dart';
import 'package:ghumo_24/screens/profile/views/profile_view.dart';
import 'package:ghumo_24/services/base_client.dart';
import 'package:ghumo_24/utills/textthem.dart';
import "package:http/http.dart" as http;

import '../components/textfileds/suffix_icontextformfiled.dart';

class UpdateRoomDetailFour extends StatefulWidget {
  final String roomId;
  final String propertId;
  const UpdateRoomDetailFour(
      {super.key, required this.roomId, required this.propertId});

  @override
  State<UpdateRoomDetailFour> createState() => _UpdateRoomDetailFourState();
}

class _UpdateRoomDetailFourState extends State<UpdateRoomDetailFour> {
  BaseClient baseClient = BaseClient();
  TextEditingController timeinput = TextEditingController();
  GlobalKey<FormState> _addroomFormKey = GlobalKey<FormState>();

  int roomVal = 1;
  bool discount = false;
  bool soldOut = true;

  //text editing controller for text field

  @override
  void initState() {
    getroom();
    getCategory(); //set the initial value of text field
    super.initState();
  }

  TextEditingController roomNameController = TextEditingController();

  TextEditingController propertyNameController = TextEditingController();

  TextEditingController categoryController = TextEditingController();
  TextEditingController roomPriceController = TextEditingController();
  TextEditingController discountedController = TextEditingController();
  TextEditingController addonController = TextEditingController();
  RoomDetailModel? roomDetailModel;

  bool isRloading = false;

  bool king = false;
  bool queen = false;
  bool twoSingleBed = false;
  bool fourBedFamilyroom = false;
  String bedvalue = "classic";
  AllPropertyDetailModel? propertyDetailModel;

  RoomCategoryModel? roomCategoryModel;
  bool isloading = false;
  bool isProp = false;
  bool isUloading = false;

  getproperty() async {
    setState(() {
      isProp = true;
    });
    var response = await baseClient.get(false, Config.apiURL,
        "${Config.getPropertyByUser}${BaseClient.box.read("user_id")}");

    var data1 = jsonDecode(response);

    print(
        "=========data1['success']===================${data1['success']}==========");

    if (data1['success'] == true) {
      var data = allPropertyDetailModelFromJson(response);
      if (data != null) {
        print("-----------daatt is not null---------------");

        print("----------data----$data-----------");
        propertyDetailModel = data;

        print(
            "-----------isPropertStatus ---${BaseClient.box.read("isPropertStatus")}------------");

        print(
            "-----------propertyDetailModel---$propertyDetailModel-----------");
        // BaseClient.box
        //     .write("isPropertStatus", propertyDetailModel!.data!.first.active);

      }
    }
    setState(() {
      isProp = false;
    });
  }

  getroom2() async {
    var response = await baseClient.get(false, Config.apiURL,
        "${Config.getRoomByPropertId}${widget.propertId}");
    var data = roomDetailModelFromJson(response);
    if (data != null) {
      roomDetailModel = data;
      setState(() {
        categoryController.text =
            roomDetailModel!.room!.first.roomCategory!.name == null
                ? ""
                : roomDetailModel!.room!.first.roomCategory!.name!;
        roomVal = roomDetailModel!.room!.first.availableRoom == null
            ? 0
            : roomDetailModel!.room!.first.availableRoom!;
        soldOut = roomDetailModel!.room!.first.soldOut == null
            ? false
            : roomDetailModel!.room!.first.soldOut!;
        roomPriceController.text =
            "${roomDetailModel!.room!.first.actualPrice == null ? "" : roomDetailModel!.room!.first.actualPrice!.toString()}";

        soldOut = roomDetailModel!.room!.first.soldOut == null
            ? false
            : roomDetailModel!.room!.first.soldOut!;

        discountedController.text =
            "${roomDetailModel!.room!.first.discountPrice == null ? "" : roomDetailModel!.room!.first.discountPrice!.toString()}";

        addonController.text = roomDetailModel!.room!.first.addOn == null
            ? ""
            : roomDetailModel!.room!.first.addOn.toString();
      });
    }
  }

  getroom() async {
    var response = await baseClient.get(false, Config.apiURL,
        "${Config.getRoomByPropertId}${widget.propertId}");
    var data = roomDetailModelFromJson(response);
    if (data != null) {
      roomDetailModel = data;
      setState(() {
        categoryController.text =
            roomDetailModel!.room!.first.roomCategory!.name == null
                ? ""
                : roomDetailModel!.room!.first.roomCategory!.name!;
        roomVal = roomDetailModel!.room!.first.availableRoom == null
            ? 0
            : roomDetailModel!.room!.first.availableRoom!;
        soldOut = roomDetailModel!.room!.first.soldOut == null
            ? false
            : roomDetailModel!.room!.first.soldOut!;
        roomPriceController.text =
            "${roomDetailModel!.room!.first.actualPrice == null ? "" : roomDetailModel!.room!.first.actualPrice!.toString()}";

        soldOut = roomDetailModel!.room!.first.soldOut == null
            ? false
            : roomDetailModel!.room!.first.soldOut!;

        discountedController.text =
            "${roomDetailModel!.room!.first.discountPrice == null ? "" : roomDetailModel!.room!.first.discountPrice!.toString()}";

        addonController.text = roomDetailModel!.room!.first.addOn == null
            ? ""
            : roomDetailModel!.room!.first.addOn.toString();
      });
    }
  }

  getCategory() async {
    setState(() {
      isloading = true;
    });

    var response =
        await baseClient.get(false, Config.apiURL, "${Config.getCategory}");
    var data = roomCategoryModelFromJson(response);
    if (data != null) {
      roomCategoryModel = data;
    }

    setState(() {
      isloading = false;
    });
  }

  updateRoom() async {
    try {
      setState(() {
        isUloading = true;
      });
      var headers = {
        'Authorization': 'Bearer ${BaseClient.box.read("logintoken")}',
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'PUT',
          Uri.parse(
            "${Config.apiURL}${Config.updateRoomDetail}${widget.roomId}",
          ));
      request.body = json.encode({
        "roomCategory": "${categoryController.text.toString()}",
        "availableRoom": roomVal.toInt(),
        "soldOut": soldOut,
        "actualPrice": double.parse(roomPriceController.text.toString()),
        "discountPrice": double.parse(discountedController.text.toString()),
        "addOn": "${addonController.text.toString()}"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          isUloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Update Room Detail Successfully')));
        getroom();
        print(await response.stream.bytesToString());
      } else {
        setState(() {
          isUloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to Update room')));
        // getroom();
        print(response.reasonPhrase);
      }
    } finally {
      setState(() {
        isUloading = false;
      });
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
        child: isloading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : roomCategoryModel!.data!.isEmpty
                ? Center(child: Text("No Room Category Exist"))
                : Column(
                    children: roomCategoryModel!.data!.map((e) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            setState(() {
                              categoryController.text = "${e.name}";
                            });

                            Navigator.of(context).pop();
                          },
                          title: Text("${e.name}"),
                        ),
                        Divider(
                          height: 5,
                        )
                      ],
                    );
                  }).toList()),
      ),
    ]);
  }

  propertPicker() {
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
        child: isProp
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : roomCategoryModel!.data!.isEmpty
                ? Center(child: Text("No Property Exist"))
                : Column(
                    children: propertyDetailModel!.data!.map((e) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            setState(() {
                              propertyNameController.text = "${e.name}";
                            });

                            Navigator.of(context).pop();
                          },
                          title: Text("${e.name}"),
                        ),
                        Divider(
                          height: 5,
                        )
                      ],
                    );
                  }).toList()),
      ),
    ]);
  }

  menuPicker() {
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfileView()));
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
                  } else if (value == "home") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileView(),
                      ),
                      // (route) => false,
                    );
                  } else {
                    Navigator.of(context).pop();
                  }

                  // Navigator.pushNamed(context, value.toString());
                }, itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      onTap: () {},
                      child: Text("Home"),
                      value: 'home',
                    ),
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
                //         builder: (BuildContext) => menuPicker(),
                //       );
                //     },
                //     icon: Icon(Icons.menu))
              ],
            ),
            const Divider(
              height: 10,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 13),
              child: Center(
                  child: Text(
                "Update your Room Details",
                style: Texttheme.heading1,
              )),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 50, bottom: 40),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SufixIconTextField(
                    hinttext: "classic",
                    maxLength: 255,
                    // validate: () {},
                    textInputType: TextInputType.name,
                    controller: categoryController,
                    image: 'images/ddicon.png',
                    readOnly: true,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Select room category";
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
                  Text(
                    "Number of available Rooms",
                    style: Texttheme.labletext,
                  ),
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

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sold Out",
                          style: Texttheme.labletext,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      buildSwitch()
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Color(0Xff0082C2),
                        value: discount,
                        onChanged: (bool? value) {
                          setState(() {
                            discount = !discount;
                          });

                          print(
                              "=========discount==========$discount=========");
                        },
                      ),
                      Text(
                        "Run a Discount Offers",
                        style: Texttheme.labletext,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0Xff4D018CD1)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Room Price in ₹",
                                style:
                                    Texttheme.labletext.copyWith(fontSize: 12),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              MyTextFormField(
                                hinttxt: "5000",
                                color: Colors.white,
                                textInputType: TextInputType.number,
                                mycontroller: roomPriceController,
                                valiadte: (value) {
                                  if (value!.isEmpty) {
                                    return "Select room price";
                                  } else {
                                    return null;
                                  }
                                },
                              )
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
                              Text(
                                "Discounted Price in ₹",
                                style:
                                    Texttheme.labletext.copyWith(fontSize: 12),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              MyTextFormField(
                                hinttxt: "3000",
                                color: Colors.white,
                                textInputType: TextInputType.number,
                                mycontroller: discountedController,
                                valiadte: (value) {
                                  if (value!.isEmpty) {
                                    return "Select room discounted price";
                                  } else {
                                    return null;
                                  }
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  MyTextFormField(
                    mxline: null,
                    prefixicon: Image.asset(
                      "images/hd.png",
                      width: w * 0.1,
                      height: h * 0.1,
                    ),
                    minline: 3,
                    hinttxt: "Add On",
                    color: Colors.white,
                    textInputType: TextInputType.text,
                    mycontroller: addonController,
                    valiadte: (value) {
                      if (value!.isEmpty) {
                        return "Select room price";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  Center(
                      child: isUloading
                          ? Container(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(),
                            )
                          : UpdateButton(onpress: () {
                              if (validateAndSave()) {
                                updateRoom();
                              }
                            }))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget buildSwitch() => Transform.scale(
        scale: 1.5,
        child: Switch.adaptive(
          // thumbColor:
          //     MaterialStateProperty.all(Color.fromARGB(255, 15, 100, 143)),
          // trackColor: MaterialStateProperty.all(Color(0Xff81D5FF)),

          activeColor: Colors.blueAccent,
          activeTrackColor: Colors.blue.withOpacity(0.4),
          inactiveThumbColor: Color.fromARGB(255, 107, 112, 116),
          inactiveTrackColor: Color.fromARGB(221, 27, 26, 26),
          splashRadius: 30,
          value: soldOut,
          onChanged: (value) => setState(() {
            soldOut = !soldOut;
            print("=========soldOut==========$soldOut=========");
          }),
        ),
      );

  bool validateAndSave() {
    final form = _addroomFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
