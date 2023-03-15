import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/dynamic_cart.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/allproperty_detail_response.dart';
import 'package:ghumo_24/model/room_detail_model.dart';
import 'package:ghumo_24/screens/add_room.dart';
import 'package:ghumo_24/screens/address.dart';
import 'package:ghumo_24/screens/category_room_floors2.dart';
import 'package:ghumo_24/screens/gst.dart';
import 'package:ghumo_24/screens/home_screen.dart';
import 'package:ghumo_24/screens/hotel_amenities.dart';
import 'package:ghumo_24/screens/hotel_details.dart';
import 'package:ghumo_24/screens/hotel_room_details.dart';
import 'package:ghumo_24/screens/profile/views/profile_view.dart';
import 'package:ghumo_24/screens/propertytype.dart';
import 'package:ghumo_24/screens/room_category.dart';
import 'package:ghumo_24/screens/room_details3.dart';
import 'package:ghumo_24/screens/royal_hotel.dart';
import 'package:ghumo_24/screens/splash_screen.dart';
import 'package:ghumo_24/screens/update_room_detail4.dart';
import 'package:ghumo_24/screens/update_room_details.dart';
import 'package:ghumo_24/services/base_client.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:ghumo_24/services/custum_web_services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'hotel_detail_done.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? _timer;
  BaseClient baseClient = BaseClient();
  AllPropertyDetailModel? propertyDetailModel;
  RoomDetailModel? roomDetailModel;
  bool isloading = false;
  bool isRloading = false;

  getproperty() async {
    setState(() {
      isloading = true;
    });

    var response = await baseClient.get(false, Config.apiURL,
        "${Config.getPropertyByUser}${BaseClient.box.read("user_id")}");
    var data = allPropertyDetailModelFromJson(response);
    if (data != null) {
      print("-----------daatt is not null---------------");

      print("----------data----$data-----------");
      propertyDetailModel = data;

      print("-----------propertyDetailModel---$propertyDetailModel-----------");
      BaseClient.box
          .write("isPropertStatus", propertyDetailModel!.data!.first.active);
      // BaseClient.box.write("isPropertStatus", true);
      BaseClient.box.write("property_id", propertyDetailModel!.data!.first.id);

      BaseClient.box.write("1StUpdate", propertyDetailModel!.data!.first.id);

      BaseClient.box.write("2StUpdate", propertyDetailModel!.data!.first.name);
      BaseClient.box
          .write("3StUpdate", propertyDetailModel!.data!.first.amientities);
      BaseClient.box
          .write("4StUpdate", propertyDetailModel!.data!.first.personalEmail);
      BaseClient.box
          .write("5StUpdate", propertyDetailModel!.data!.first.totalRooms);
      BaseClient.box
          .write("6StUpdate", propertyDetailModel!.data!.first.gstNumber);

      BaseClient.box
          .write("6StUpdate", propertyDetailModel!.data!.first.gstNumber);
      BaseClient.box.write(
          "7StUpdate", propertyDetailModel!.data!.first.propertyRestriction);

      if (BaseClient.box.read("7StUpdate") != null) {
        BaseClient.box.write("propertycreated",
            propertyDetailModel!.data!.first.propertyRestriction);
      }

      getroom(propertyDetailModel!.data!.first.id!);
    }

    setState(() {
      isloading = false;
    });
  }

  start() {
    _timer = Timer(Duration(seconds: 3), () {
      var amant = BaseClient.box.read("3StUpdate");
      var specialFeature = BaseClient.box.read("3StRoomUpdate");
      print(
          "-----------isPropertStatus ---${BaseClient.box.read("isPropertStatus")}------------");

      print(
          "-----------isPropertStatus ---${BaseClient.box.read("logintoken")}------------");

      BaseClient.box.read("logintoken") == null
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SplashScreen(),
              ),
            )
          : BaseClient.box.read("propertycreated") == null
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  ),
                )
              : BaseClient.box.read("1StUpdate") == null
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyScreen(),
                      ),
                    )
                  : BaseClient.box.read("2StUpdate") == null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddressScreen(
                              propertId:
                                  "${BaseClient.box.read("property_id")}",
                            ),
                          ),
                        )
                      : amant.isEmpty
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HotelAmenities(
                                  propertId:
                                      "${BaseClient.box.read("property_id")}",
                                ),
                              ),
                            )
                          : BaseClient.box.read("4StUpdate") == null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelDetails(
                                      propertId:
                                          "${BaseClient.box.read("property_id")}",
                                    ),
                                  ),
                                )
                              : BaseClient.box.read("5StUpdate") == null
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CategoryRoomFloors(
                                          propertId:
                                              "${BaseClient.box.read("property_id")}",
                                        ),
                                      ),
                                    )
                                  : BaseClient.box.read("6StUpdate") == null
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => GstScreen(
                                              propertId:
                                                  "${BaseClient.box.read("property_id")}",
                                            ),
                                          ),
                                        )
                                      : BaseClient.box.read("7StUpdate") == null
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HotelRoomDetails(
                                                  propertId:
                                                      "${BaseClient.box.read("property_id")}",
                                                ),
                                              ),
                                            )
                                          : BaseClient.box.read(
                                                      "isPropertStatus") ==
                                                  false
                                              ? Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileView()),
                                                  // (route) => false,
                                                )
                                              : BaseClient.box.read(
                                                          "1StRoomUpdate") ==
                                                      null
                                                  ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            RoomCategoryScreen(
                                                          property_id:
                                                              "${BaseClient.box.read("property_id")}",
                                                        ),
                                                      ),
                                                    )
                                                  : BaseClient.box.read(
                                                              "2StRoomUpdate") ==
                                                          null
                                                      ? Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                UpdateRoomDetail(
                                                                    roomId:
                                                                        "${BaseClient.box.read("room_id")}",
                                                                    propertId:
                                                                        "${BaseClient.box.read("property_id")}"),
                                                          ),
                                                        )
                                                      : specialFeature.isEmpty
                                                          ? Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RoomDetails3(),
                                                              ),
                                                            )
                                                          : Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    UpdateRoomDetailFour(
                                                                        roomId:
                                                                            "${BaseClient.box.read("room_id")}",
                                                                        propertId:
                                                                            "${BaseClient.box.read("property_id")}"),
                                                              ),
                                                            );
    });
  }

  getroom(String propertId) async {
    setState(() {
      isRloading = true;
    });
    var response = await baseClient.get(
        false, Config.apiURL, "${Config.getRoomByPropertId}$propertId");
    var data = roomDetailModelFromJson(response);
    if (data != null) {
      roomDetailModel = data;

      BaseClient.box.write("1StRoomUpdate", roomDetailModel!.room!.first.id);
      BaseClient.box.write("room_idR", roomDetailModel!.room!.first.id);

      BaseClient.box
          .write("2StRoomUpdate", roomDetailModel!.room!.first.extraChild);
      BaseClient.box
          .write("3StRoomUpdate", roomDetailModel!.room!.first.specialFeature);
    }
    setState(() {
      isRloading = false;
    });
  }

  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  String otp = "";

  bool isApiCallProcess = false;
  @override
  void initState() {
    getproperty();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _otpFormKey,
        child: Container(
            width: w * 1.0,
            height: h * 1.0,
            child: Stack(
              children: [
                Positioned(
                  top: h * 0.0,
                  left: w * 0.0,
                  child: Container(
                    width: w * 1.0,
                    height: h * 0.5,
                    child: Image.asset(
                      "images/upshlash2.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: h * 0.09,
                  left: w * 0.25,
                  child: Image.asset("images/ghumologo.png",
                      width: w * 0.5, height: h * 0.1),
                ),
                Positioned(
                    top: h * 0.48,
                    left: w * 0.0,
                    child: MyCart(
                        0.55,
                        1.0,
                        20.0,
                        20.0,
                        0.0,
                        0.0,
                        Color.fromARGB(255, 86, 218, 228),
                        Color.fromARGB(255, 238, 188, 216),
                        Color.fromARGB(0, 255, 255, 255))),
                Positioned(
                    top: h * 0.52,
                    left: w * 0.38,
                    child: Text(
                      "Verify",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: h * 0.035,
                          fontWeight: FontWeight.w500),
                    )),
                Positioned(
                    top: h * 0.58,
                    left: w * 0.25,
                    child: Text(
                      "OTP is sent to ${box2.read("phone")}",
                      style:
                          TextStyle(color: Colors.white, fontSize: h * 0.018),
                    )),
                Positioned(
                    top: h * 0.563,
                    left: w * 0.75,
                    child: GestureDetector(
                      child: Image.asset(
                        "images/edit.png",
                        width: w * 0.05,
                        height: h * 0.05,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )),
                Positioned(
                    top: h * 0.61,
                    left: w * 0.3,
                    child: Text(
                      "Please enter it below",
                      style:
                          TextStyle(color: Colors.white, fontSize: h * 0.018),
                    )),
                Positioned(
                  top: h * 0.655,
                  left: w * 0.04,
                  child: OtpTextField(
                    fieldWidth: 55.0,
                    filled: true,
                    fillColor: Colors.white,
                    margin: EdgeInsets.all(16.0),
                    keyboardType: TextInputType.number,
                    numberOfFields: 4,

                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      setState(() {
                        otp = code;
                      });
                      print("otp $otp");
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      setState(() {
                        otp = verificationCode;
                      });
                      print("otp $otp");
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return AlertDialog(
                      //         title: Text("Verification Code"),
                      //         content:
                      //             Text('Code entered is $verificationCode'),
                      //       );
                      //     });
                    }, // end onSubmit
                  ),
                ),
                Positioned(
                    top: h * 0.8,
                    left: w * 0.2,
                    child: isApiCallProcess
                        ? Container(
                            height: 60,
                            width: w * 0.6,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : MyButton(
                            onpress: () {
                              if (validateAndSave()) {
                                setState(() {
                                  isApiCallProcess = true;
                                });

                                print(
                                    "============phoneController.text============${otp}================================");

                                APIService.otpverification(otp).then(
                                  (response) {
                                    setState(() {
                                      isApiCallProcess = false;
                                    });

                                    if (response) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Login successfully')));
                                      start();
                                      // Navigator.pushAndRemoveUntil(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => HomeScreen(),
                                      //   ),
                                      //   (route) => false,
                                      // );
                                    } else {
                                      FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "Incorrect OTP CODE !!",
                                        "OK",
                                        () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }
                                  },
                                );
                              } else {
                                print("==========================");
                              }
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => PropertyScreen()));
                            },
                            btnname: Text(
                              "Verify",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            height: 0.05,
                            width: 0.6,
                            btncolor: Color.fromARGB(255, 1, 140, 209),
                          )),
                Positioned(
                    top: h * 0.85,
                    left: w * 0.38,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            isApiCallProcess = true;
                          });

                          APIService.login(
                                  "${BaseClient.box.read("phone")}", context)
                              .then(
                            (response) {
                              setState(() {
                                isApiCallProcess = false;
                              });

                              if (response) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'OTP Resend successfully to your registered phone number ')));
                              } else {
                                FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Invalid Phone Number !!",
                                  "OK",
                                  () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            },
                          );
                        },
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(color: Colors.white),
                        )))
              ],
            )),
      ),
    ));
  }

  bool validateAndSave() {
    final form = _otpFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
