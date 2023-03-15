import 'package:flutter/material.dart';
import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/dynamic_cart.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/screens/authetication.dart';
import 'package:ghumo_24/screens/royal_hotel.dart';
import 'package:ghumo_24/services/base_client.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import 'package:ghumo_24/services/custum_web_services.dart';

class OtpScreen2 extends StatefulWidget {
  const OtpScreen2({Key? key}) : super(key: key);

  @override
  State<OtpScreen2> createState() => _OtpScreen2State();
}

class _OtpScreen2State extends State<OtpScreen2> {
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  String otp = "";

  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
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
                  top: h * 0.01,
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
                      "OTP is sent to ${box2.read("property_id")}",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthenticationScreen()));
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
                    child: MyButton(
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
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RoyalHotelScreen(),
                                  ),
                                  (route) => false,
                                );
                                // Navigator.pushNamedAndRemoveUntil(
                                //   context,
                                //   '/home',
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
                        onPressed: () {},
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(color: Colors.white),
                        )))
              ],
            )),
      ),
    )));
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
