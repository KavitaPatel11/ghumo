import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/text_field_cart.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/google_map/address_search.dart';
import 'package:ghumo_24/model/allproperty_detail_response.dart';
import 'package:ghumo_24/model/pincode_model.dart';
import 'package:ghumo_24/model/property_detail_model.dart';
import 'package:ghumo_24/screens/hotel_amenities.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ghumo_24/screens/menu/menu.dart';
import 'package:ghumo_24/utills/textthem.dart';
import "package:http/http.dart" as http;

import '../services/base_client.dart';

class AddressScreen extends StatefulWidget {
  final String propertId;
  const AddressScreen({Key? key, required this.propertId}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController propertNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  final TextEditingController areaController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController startedDateController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();

  Map<String, dynamic> address = {};

  BaseClient baseClient = BaseClient();

  DateTime? _selected1;

  double? _rating;

  PinCodeModel? pinCodeModel;

  PropertyDetailModel? propertyDetailModel;

  getproperty() async {
    print(
        "===========property id=============================${box2.read("property_id")}=====================");
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
          BaseClient.box.write("longitude",
              "${propertyDetailModel!.data!.longitude == null ? "" : propertyDetailModel!.data!.longitude}");
          BaseClient.box.write("latitude",
              "${propertyDetailModel!.data!.latitude == null ? "" : propertyDetailModel!.data!.latitude}");
          propertNameController.text =
              "${propertyDetailModel!.data!.name == null ? "" : propertyDetailModel!.data!.name}";

          pincodeController.text =
              "${propertyDetailModel!.data!.pincode == null ? "" : propertyDetailModel!.data!.pincode}";
          stateController.text =
              "${propertyDetailModel!.data!.state == null ? "" : propertyDetailModel!.data!.state}";
          cityController.text =
              "${propertyDetailModel!.data!.city == null ? "" : propertyDetailModel!.data!.city}";
          addressController.text =
              "${propertyDetailModel!.data!.address == null ? "" : propertyDetailModel!.data!.address}";
          areaController.text =
              "${propertyDetailModel!.data!.area == null ? "" : propertyDetailModel!.data!.area}";
          landmarkController.text =
              "${propertyDetailModel!.data!.landmark == null ? "" : propertyDetailModel!.data!.landmark}";
          startedDateController.text =
              "${propertyDetailModel!.data!.hoteStarted == null ? "" : propertyDetailModel!.data!.hoteStarted}";
          _rating = double.parse(
              "${propertyDetailModel!.data!.hotelStar == null ? "" : propertyDetailModel!.data!.hotelStar}");
        });
      }
    }
  }

  @override
  void initState() {
    getproperty();
    // TODO: implement initState
    super.initState();
  }

  updatepropertyt() async {
    setState(() {});
    var data = {
      'name': propertNameController.text,
      'longitude': '${BaseClient.box.read('longitude')}',
      'latitude': '${BaseClient.box.read('latitude')}',
      'pincode': pincodeController.text.toString(),
      'state': stateController.text.toString(),
      'city': cityController.text.toString(),
      'address': addressController.text.toString(),
      'area': areaController.text.toString(),
      'landmark': landmarkController.text.toString(),
      'hoteStarted': startedDateController.text.toString(),
      'hotelStar': "$_rating"
    };

    print("=======rating==========$_rating===========");
    print("======data========$data================");

    print(
        "=========================+++++++++++++++++++++==ggglatitude====${BaseClient.box.read('latitude')}====hhhlongitude==${BaseClient.box.read('longitude')}==data=========$data===========");
    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.put(
        true,
        "${Config.apiURL}",
        "${Config.updatePropertyType}${widget.propertId}",
        data,
      )),
    );

    print(
        "===  propertid====${box2.read("property_id")}========apiResponse=======$apiResponse=========");
    if (apiResponse != null) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Property Update Successfully')));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HotelAmenities(
            propertId: widget.propertId,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update property')));
    }
  }

  @override
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
            // SizedBox(
            //   width: 60,
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
          height: 8,
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
              const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 40),
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
          child: Form(
            key: _updateFormKey,
            child: Column(
              children: [
                MyTextFormField(
                  mycontroller: propertNameController,
                  radius: 15.0,
                  bordercolor: const Color.fromARGB(255, 255, 255, 255),
                  borderwidth: 0.0,
                  width: 0.9,
                  height: 0.055,
                  contentpadding: 45.0,
                  hinttxt: "Property Name",
                  prefixicon: Image.asset(
                    "images/property.png",
                    width: 10,
                    height: 10,
                  ),
                  color: Colors.white,
                  inptype: TextInputType.name,
                  // length: 40,
                  hts: 15.0,
                  hintcolor: const Color.fromARGB(255, 126, 122, 122),
                  textcolor: Colors.black,
                  valiadte: (value) {
                    if (value!.isEmpty) {
                      return "Enter your property name";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            onTap: () async {
                              Map<String, dynamic> dataFromSecondPage =
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MapUiBody(
                                          mydata: address,
                                        ),
                                      ));
                              setState(() {
                                address = dataFromSecondPage == null
                                    ? address
                                    : dataFromSecondPage;
                                addressController.text =
                                    "${address.isEmpty ? "" : "${address['address']}"}";

                                pincodeController.text =
                                    "${address.isEmpty ? "" : "${address['pincode']}"}";

                                stateController.text =
                                    "${address.isEmpty ? "" : "${address['state']}"}";
                                cityController.text =
                                    "${address.isEmpty ? "" : "${address['city']}"}";
                              });
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: "Google map",
                                hintStyle: const TextStyle(color: Colors.white),
                                isDense: true,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "images/map.png",
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color(0XFF018CD1),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0XFF018CD1)),
                                    borderRadius: BorderRadius.circular(20))))),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: MyTextFormField(
                      maxLength: 6,
                      mycontroller: pincodeController,
                      radius: 15.0,
                      textcolor: Colors.black,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      hintcolor: const Color.fromARGB(255, 126, 122, 122),
                      bordercolor: Colors.white,
                      borderwidth: 0.0,
                      width: 0.44,
                      contentpadding: 45.0,
                      height: 0.055,
                      length: 6,
                      hts: 15.0,
                      inptype: TextInputType.number,
                      hinttxt: "Pin code",
                      prefixicon: Image.asset(
                        "images/location.png",
                        width: 6,
                        height: 6,
                      ),
                      onSubmit: (value) {
                        _getaddress2(pincodeController.text);
                      },
                      onEditingComplete: () {
                        _getaddress2(pincodeController.text);
                      },
                      valiadte: (value) {
                        bool isZipValid = RegExp(
                                r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$",
                                caseSensitive: false)
                            .hasMatch(value!);
                        if (isZipValid == false) {
                          return "Enter valid zip code";
                        } else if (value.length != 6) {
                          return "Enter valid zip code";
                        } else {
                          return null;
                        }
                      },
                    ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: MyTextFormField(
                      mycontroller: stateController,
                      radius: 15.0,
                      textcolor: Colors.black,
                      contentpadding: 45.0,
                      hts: 15.0,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      hintcolor: const Color.fromARGB(255, 126, 122, 122),
                      bordercolor: Colors.white,
                      borderwidth: 0.0,
                      width: 0.44,
                      height: 0.055,
                      length: 20,
                      inptype: TextInputType.name,
                      hinttxt: "State",
                      prefixicon: Image.asset(
                        "images/location.png",
                        width: 6,
                        height: 6,
                      ),
                      valiadte: (value) {
                        if (value!.isEmpty) {
                          return "Enter your state";
                        } else {
                          return null;
                        }
                      },
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: MyTextFormField(
                      mycontroller: cityController,
                      radius: 15.0,
                      textcolor: Colors.black,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      hintcolor: const Color.fromARGB(255, 126, 122, 122),
                      bordercolor: Colors.white,
                      borderwidth: 0.0,
                      width: 0.44,
                      contentpadding: 45.0,
                      height: 0.055,
                      length: 6,
                      hts: 15.0,
                      inptype: TextInputType.text,
                      hinttxt: "City",
                      prefixicon: Image.asset(
                        "images/location.png",
                        width: 6,
                        height: 6,
                      ),
                      valiadte: (value) {
                        if (value!.isEmpty) {
                          return "Enter your city";
                        } else {
                          return null;
                        }
                      },
                    ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                MyTextFormField(
                  mycontroller: addressController,
                  radius: 15.0,
                  contentpadding: 45.0,
                  textcolor: Colors.black,
                  hts: 15.0,
                  bordercolor: const Color.fromARGB(255, 255, 255, 255),
                  borderwidth: 0.0,
                  width: 0.9,
                  height: 0.055,
                  hinttxt: "Enter hotel/property address",
                  color: Colors.white,
                  inptype: TextInputType.name,
                  hintcolor: const Color.fromARGB(255, 126, 122, 122),
                  valiadte: (value) {
                    if (value!.isEmpty) {
                      return "Enter hotel/property address";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                MyTextFormField(
                  mycontroller: areaController,
                  radius: 15.0,
                  contentpadding: 45.0,
                  textcolor: Colors.black,
                  hts: 15.0,
                  bordercolor: const Color.fromARGB(255, 255, 255, 255),
                  borderwidth: 0.0,
                  width: 0.9,
                  height: 0.055,
                  hinttxt: "Road name,Area,Colony",
                  color: Colors.white,
                  inptype: TextInputType.name,
                  length: 20,
                  hintcolor: const Color.fromARGB(255, 126, 122, 122),
                  valiadte: (value) {
                    if (value!.isEmpty) {
                      return "Road name,Area,Colony";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                MyTextFormField(
                  mycontroller: landmarkController,
                  radius: 15.0,
                  textcolor: Colors.black,
                  hts: 15.0,
                  bordercolor: const Color.fromARGB(255, 255, 255, 255),
                  borderwidth: 0.0,
                  width: 0.9,
                  contentpadding: 45.0,
                  height: 0.055,
                  hinttxt: "Near by Femous /Landmark",
                  color: Colors.white,
                  inptype: TextInputType.name,
                  length: 20,
                  hintcolor: const Color.fromARGB(255, 126, 122, 122),
                  valiadte: (value) {
                    if (value!.isEmpty) {
                      return "Near by Femous /Landmark";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  child: MyTextFormField(
                    ontab: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Select Year"),
                              content: Container(
                                // Need to use container to add size constraint.
                                width: 300,
                                height: 300,
                                child: YearPicker(
                                  firstDate:
                                      DateTime(DateTime.now().year - 100, 1),
                                  lastDate: DateTime.now(),
                                  initialDate: DateTime.now(),
                                  // save the selected date to _selectedDate DateTime variable.
                                  // It's used to set the previous selected date when
                                  // re-showing the dialog.
                                  selectedDate: _selected1 == null
                                      ? DateTime.now()
                                      : _selected1!,
                                  onChanged: (DateTime dateTime) {
                                    setState(() {
                                      startedDateController.text =
                                          dateTime.year.toString();
                                    });
                                    // close the dialog when year is selected.
                                    Navigator.pop(context);

                                    // Do something with the dateTime selected.
                                    // Remember that you need to use dateTime.year to get the year
                                  },
                                ),
                              ),
                            );
                          });
                    },
                    readOnly: true,
                    mycontroller: startedDateController,
                    textcolor: Colors.black,
                    radius: 15.0,
                    bordercolor: const Color.fromARGB(255, 255, 255, 255),
                    borderwidth: 0.0,
                    width: 0.9,
                    height: 0.055,
                    hinttxt: "Hotel Started Since",
                    prefixicon: Image.asset(
                      "images/since.png",
                      width: 10,
                      height: 10,
                    ),
                    color: Colors.white,
                    hts: 15.0,
                    inptype: TextInputType.datetime,
                    length: 20,
                    contentpadding: 45.0,
                    hintcolor: const Color.fromARGB(255, 126, 122, 122),
                    valiadte: (value) {
                      if (value!.isEmpty) {
                        return "Enter Hotel Started Since";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Select Star Rating of the Property"),
                    )),
                SizedBox(
                  width: double.infinity,
                  child: RatingBar.builder(
                    initialRating: _rating == null ? 3 : _rating!,
                    minRating: 0,
                    direction: Axis.horizontal,
                    // allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                MyButton(
                  onpress: () {
                    if (validateAndSave()) {
                      updatepropertyt();
                    }
                  },
                  btnname: const Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  width: 0.16,
                  height: 0.075,
                  btncolor: const Color.fromARGB(255, 255, 255, 255),
                )
              ],
            ),
          ),
        )
      ],
    )));
  }

  bool validateAndSave() {
    final form = _updateFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<String?> _getaddress2(pincode) async {
    try {
      print(" pinCodeModel==  ${pincodeController}=");
      await http
          .get(
        Uri.parse(
            "https://server.tieceeindia.com/api/getCityStateCountry/${pincode}"),
      )
          .then((response) {
        var data = json.decode(response.body);

        print(" sub catrgory data====$data}");
        setState(() {
          pinCodeModel = pinCodeModelFromJson(response.body);
          pincodeController.text = pinCodeModel!.data!.pincode!;
          stateController.text = pinCodeModel!.data!.state!;
          cityController.text = pinCodeModel!.data!.city!;

          print(" pinCodeModel====$pinCodeModel");
          // print("")
        });
      });
      return null;
    } finally {}
  }
}
