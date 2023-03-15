import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/dynamic_cart.dart';
import 'package:ghumo_24/components/text_field_cart.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/property_detail_model.dart';
import 'package:ghumo_24/screens/category_room_floors2.dart';
import 'package:ghumo_24/screens/hotel_amenities.dart';
import 'package:ghumo_24/screens/menu/menu.dart';
import 'package:ghumo_24/services/shared_services.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ghumo_24/utills/textthem.dart';

import '../services/base_client.dart';

class HotelDetails extends StatefulWidget {
  final String propertId;
  const HotelDetails({Key? key, required this.propertId}) : super(key: key);

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  final TextEditingController personalEmailController = TextEditingController();
  final TextEditingController hotelEmailController = TextEditingController();
  final TextEditingController personalContactController =
      TextEditingController();

  final TextEditingController hotelContactController = TextEditingController();

  final TextEditingController otherDetailsController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();

  Map<String, dynamic> address = {};

  BaseClient baseClient = BaseClient();
  DateTime? _selected1;

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
        setState(() {
       
         personalContactController.text =
              "${propertyDetailModel!.data!.personalContact == null ? "" : propertyDetailModel!.data!.personalContact}";

          personalEmailController.text =
              "${propertyDetailModel!.data!.personalEmail == null ? "" : propertyDetailModel!.data!.personalEmail!}";
         hotelContactController.text =
              "${propertyDetailModel!.data!.hotelContact == null ? "" : propertyDetailModel!.data!.hotelContact}";
          hotelEmailController.text =
              "${propertyDetailModel!.data!.hotelEmail == null ? "" : propertyDetailModel!.data!.hotelEmail}";
        
         
        });
      }
    }
  }


  updatepropertyt() async {
    var data = {
      'personalContact': personalContactController.text,
      'personalEmail': personalEmailController.text,
      'hotelContact': hotelContactController.text,
      'otherDetails':"",
      'hotelEmail': hotelEmailController.text,
      'hotelType': "rental"
    };

    print("============data=========$data===========");
    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.put(
        true,
        "${Config.apiURL}",
        "${Config.updatePropertyType}${widget.propertId}",
        data,
      )),
    );

    print("===============apiResponse=======$apiResponse=========");
    if (apiResponse != null) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Property Update Successfully')));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryRoomFloors(propertId: widget.propertId),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Failed to Update Property')));
    }
  }

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

    return SafeArea(
        child: Scaffold(
      body: Form(
          key: _updateFormKey,
         
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/ghumologo.png",
                    width: w * 0.6,
                    height: h * 0.07,
                  ),
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
              const Divider(
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
                  children: [
                    MyTextFormField(
                      mycontroller: personalEmailController,
                      radius: 15.0,
                      hts: 15.0,
                      contentpadding: 45.0,
                      bordercolor: Color.fromARGB(255, 255, 255, 255),
                      borderwidth: 0.0,
                      width: 0.9,
                      height: 0.05,
                      textcolor: Colors.black,
                      hinttxt: "Personal email id",
                      prefixicon: Image.asset(
                        "images/msg.png",
                        width: w * 0.06,
                        height: h * 0.06,
                      ),
                      color: Colors.white,
                      inptype: TextInputType.name,
                      length: 40,
                      hintcolor: Color.fromARGB(255, 126, 122, 122),
                      valiadte: (value) {
                        final bool isValid = EmailValidator.validate(value!);
                        if (value != null && value.trim().length < 3) {
                          return 'Email required';
                        } else if (isValid == false) {
                          return 'Enter valid email ';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MyTextFormField(
                      textInputType: TextInputType.phone,
                      mycontroller: personalContactController,
                      radius: 15.0,
                      hts: 15.0,
                      textcolor: Colors.black,
                      bordercolor: Color.fromARGB(255, 255, 255, 255),
                      borderwidth: 0.0,
                      width: 0.9,
                      height: 0.05,
                      contentpadding: 45.0,
                      hinttxt: "Personal contact number",
                      prefixicon: Image.asset(
                        "images/call.png",
                        width: w * 0.06,
                        height: h * 0.06,
                      ),
                      color: Colors.white,
                    
                      length: 10,
                      hintcolor: Color.fromARGB(255, 126, 122, 122),
                      valiadte: (value) {
                        if (value!.isEmpty) {
                          return "Enter your personal conatct number";
                        } else if (value.length != 10) {
                          return "Enter valid phone number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MyTextFormField(
                      radius: 15.0,
                      mycontroller: hotelEmailController,
                      hts: 15.0,
                      bordercolor: Color.fromARGB(255, 255, 255, 255),
                      borderwidth: 0.0,
                      width: 0.9,
                      height: 0.05,
                      textcolor: Colors.black,
                      contentpadding: 45.0,
                      hinttxt: "Hotel email id",
                      prefixicon: Image.asset(
                        "images/msg.png",
                        width: w * 0.06,
                        height: h * 0.06,
                      ),
                      color: Colors.white,
                      inptype: TextInputType.name,
                      length: 40,
                      hintcolor: Color.fromARGB(255, 126, 122, 122),
                      valiadte: (value) {
                        final bool isValid = EmailValidator.validate(value!);
                        if (value != null && value.trim().length < 3) {
                          return 'Email required';
                        } else if (isValid == false) {
                          return 'Enter valid email ';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MyTextFormField(
                      maxLength: 10,
                      
                      mycontroller: hotelContactController,
                      contentpadding: 45.0,
                      textcolor: Colors.black,
                      radius: 15.0,
                      hts: 15.0,
                      bordercolor: Color.fromARGB(255, 255, 255, 255),
                      borderwidth: 0.0,
                      width: 0.9,
                      height: 0.05,
                      hinttxt: "Hotel contact number",
                      prefixicon: Image.asset(
                        "images/call.png",
                        width: w * 0.06,
                        height: h * 0.06,
                      ),
                      color: Colors.white,
                      textInputType: TextInputType.phone,
                      length: 10,
                      hintcolor: Color.fromARGB(255, 126, 122, 122),
                      valiadte: (value) {
                        if (value!.isEmpty) {
                          return "Enter your hotel contact number";
                        } else if (value.length != 10) {
                          return "Enter valid phone number";
                        } else {
                          return null;
                        }
                      },
                    ),
                   
                  
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyButton(
                          onpress: () {
                             Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HotelAmenities(propertId: widget.propertId,),
                                    ),
                                  );
                          },
                          btnname: Icon(
                            Icons.arrow_back,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                          width: 0.16,
                          height: 0.075,
                          btncolor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MyButton(
                          onpress: () {
                            if (validateAndSave()) {
                              updatepropertyt();
                            }
                          },
                          btnname: Icon(
                            Icons.arrow_forward,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                          width: 0.16,
                          height: 0.075,
                          btncolor: Color.fromARGB(255, 255, 255, 255),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    ));
  }

  bool validateAndSave() {
    final form = _updateFormKey.currentState;
    if (form!.validate()) {
      form.save();

      return true;
    }
    return false;
  }
}
