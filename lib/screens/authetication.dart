import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/textfileds/out_lined_textfield.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/screens/authentication2.dart';
import 'package:ghumo_24/screens/otp.dart';
import 'package:ghumo_24/screens/splash_screen.dart';

import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:hexcolor/hexcolor.dart';
import '../services/custum_web_services.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      
      extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
             width: w,
              height: h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/bg1.png"))),
            child: Form(
              key: _loginFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Stack(
            children: [
              Container(
              padding: EdgeInsets.only(top: 20),
              width: w,
              height: h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/bg1.png"))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 10,),
                   SizedBox(height: 0.1,),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Image.asset("images/ghumologo.png",
                  //       width: w * 0.5, height: h * 0.1),
                  // ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      width: w,
                      height: h * 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              HexColor("#06B3C4"),
                              HexColor("#B1CBE1")
        
                              //add more colors for gradient
                            ],
                            begin: Alignment
                                .topCenter, //begin of the gradient color
                            end: Alignment
                                .bottomCenter, //end of the gradient color
                            stops: [
                              0.12,
                              1.8,
                            ] //stops for individual color
                            //set the stops number equal to numbers of color
                            ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "HELLO!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: h * 0.035,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "verify your number to unlock more features in",
                            style: TextStyle(
                                color: Colors.white, fontSize: h * 0.018),
                          ),
                          Text(
                            "the app.",
                            style: TextStyle(
                                color: Colors.white, fontSize: h * 0.018),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          OutlinedPrefixIconTextField(
                              hinttext: "Enter Phone Number",
                              maxLength: 10,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Enter phone number";
                                } else if (value.length < 10) {
                                  return "Please enter valid phone number";
                                } else {
                                  return null;
                                }
                              },
                              textInputType: TextInputType.phone,
                              controller: phoneController,
                              image: "images/call.png"),
                          SizedBox(
                            height: 30,
                          ),
                          MyButton(
                            onpress: () {
                              if (validateAndSave()) {
                                setState(() {
                                  isApiCallProcess = true;
                                });
        
                                print(
                                    "============phoneController.text============${phoneController.text}================================");
        
                                APIService.login(phoneController.text, context).then(
                                  (response) {
                                    setState(() {
                                      isApiCallProcess = false;
                                    });
        
                                    if (response) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'OTP send successfully to your registered phone number')));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          
                                          builder: (context) => OtpScreen(),
                                        ),
                                      );
                                      // Navigator.pushNamedAndRemoveUntil(
                                      //   context,
                                      //   '/home',
                                      //   (route) => false,
                                      // );
                                    } else {
                                      // FormHelper.showSimpleAlertDialog(
                                      //   context,
                                      //   Config.appName,
                                      //   "Invalid Username/Password !!",
                                      //   "OK",
                                      //   () {
                                      //     Navigator.of(context).pop();
                                      //   },
                                      // );
                                    }
                                  },
                                );
                              } else {
                                print("==========================");
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => OtpScreen()),
                              // );
                            },
                            btnname: Text(
                              "Send OTP",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            height: 0.05,
                            width: 0.6,
                            btncolor: Color.fromARGB(255, 1, 140, 209),
                          ),
                           Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: TextStyle(),),
                      TextButton(onPressed: (){

                         Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => AuthenticationScreen2()),
                              );

                      },child: Text("Register here",style: TextStyle(color: Colors.red),),)
                    ],
                  )
                        ],
                      ),
                    ),
                  ),

                 
                ],
              )),
            ],
              ),
            ),
          ),
        ));
  }

  bool validateAndSave() {
    final form = _loginFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
