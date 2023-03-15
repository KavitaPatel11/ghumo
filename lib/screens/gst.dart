import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:ghumo_24/components/textfileds/txtfiled2.dart';
import 'package:ghumo_24/model/property_detail_model.dart';
import 'package:ghumo_24/screens/category_room_floors2.dart';
import 'package:ghumo_24/screens/menu/menu.dart';
import 'package:ghumo_24/utills/textthem.dart';
import 'package:govt_documents_validator/govt_documents_validator.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:mime/mime.dart';

import 'package:ghumo_24/components/accordincard.dart';
import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/image_picker.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/screens/hotel_room_details.dart';
import 'package:ghumo_24/services/base_client.dart';

class GstScreen extends StatefulWidget {
  final String propertId;
  const GstScreen({Key? key, required this.propertId}) : super(key: key);

  @override
  State<GstScreen> createState() => _GstScreenState();
}

class _GstScreenState extends State<GstScreen> {
  final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();
  TextEditingController gstController = TextEditingController();
  TextEditingController m50 = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  bool? isGSTNum;

  BaseClient baseClient = BaseClient();
  GSTValidator gstValidator = GSTValidator();

  XFile? _image1;
  XFile? _image2;
  XFile? _image3;
  XFile? _image4;

  var aadhar1;
  var aadhar2;
  var passbook;
  var pan;

  bool isProUpdating = false;
  List<XFile> images = [];
  final ImagePicker _picker = ImagePicker();
  bool isopen1 = false;
  bool isopen2 = false;
  bool isopen3 = false;
  bool isloading = false;

  PropertyDetailModel? propertyDetailModel;

  getproperty() async {
    setState(() {
      isloading = true;
    });
    var response = await baseClient.get(false, Config.apiURL,
        "${Config.getdetailByPropertId}${widget.propertId}");

    var data1 = jsonDecode(response);

    print(
        "=========data1['success']===================${data1['success']}==========");

    if (data1['success'] == true) {
      var data = propertyDetailModelFromJson(response);
      if (data != null) {
        print("-----------daatt is not null---------------");

        print("----------data----${data.data!.aadharCardImage1}-----------");

        propertyDetailModel = data;
        setState(() {
          aadhar1 = data.data!.aadharCardImage1;
          aadhar2 = data.data!.aadharCardImage2;
          pan = data.data!.panCardImage;
          passbook = data.data!.bankAccount;

          var details = {
            "aadhar1": aadhar1,
            "aadhar2": aadhar2,
            "pan": pan,
            "passbook": passbook
          };
          print("=========details======$details=======================");
          gstController.text =
              "${propertyDetailModel!.data!.gstNumber == null ? "" : propertyDetailModel!.data!.gstNumber}";

          accountNumberController.text =
              "${propertyDetailModel!.data!.bankAccount == null ? "" : propertyDetailModel!.data!.bankAccount!.accountNumber}";
          ifscCodeController.text =
              "${propertyDetailModel!.data!.bankAccount == null ? "" : propertyDetailModel!.data!.bankAccount!.ifscCode}";
          bankNameController.text =
              "${propertyDetailModel!.data!.bankAccount == null ? "" : propertyDetailModel!.data!.bankAccount!.bankName}";
          isloading = false;
        });
      }
    }
    setState(() {
      isloading = false;
    });
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
      body: SizedBox(
        // height: h,
        child: isloading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _updateFormKey,
                child: ListView(
                  shrinkWrap: true,
                  // reverse: true,
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
                    Divider(
                      height: 10,
                      color: Colors.black,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36, vertical: 20),
                        child: Center(
                            child: Text(
                          "Tell us about your Property",
                          style: Texttheme.heading1,
                        ))),
                    Container(
                      // height: 600,
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
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: gstController,
                            // textcolor: Colors.black,
                            // radius: 15.0,
                            // bordercolor: Color.fromARGB(255, 255, 255, 255),
                            // borderwidth: 0.0,
                            // width: 0.9,
                            // height: 0.05,
                            maxLength: 15,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                RegExp regExp = RegExp(
                                  r"^[0-9]{2}[A-Z]{5}[0-9]{4}" +
                                      "[A-Z]{1}[1-9A-Z]{1}" +
                                      "Z[0-9A-Z]{1}",
                                  caseSensitive: false,
                                  multiLine: false,
                                );
                                print("hasMatch : " +
                                    regExp.hasMatch(value!).toString());

                                if (value.isNotEmpty) {
                                  if (regExp.hasMatch(value)) {
                                    return null;
                                  }
                                  return "Incorrect GST Number";
                                }
                              }
                              return "GST required";
                            },
                            decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
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
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                hintText: "Hotel GST number",
                                prefixIcon: Image.asset(
                                  "images/gsti.png",
                                  width: w * 0.06,
                                  height: h * 0.06,
                                ),
                                hintStyle: Texttheme.hintstyle
                                    .copyWith(color: Colors.black45)),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          // GSTDropDownList(),

                          AccordionCard(
                              onpress: () {
                                if (isopen1) {
                                  setState(() {
                                    isopen1 = false;
                                  });
                                } else {
                                  setState(() {
                                    isopen1 = true;
                                    isopen3 = false;
                                    isopen2 = false;
                                  });
                                }
                              },
                              image: Image.asset(
                                "images/ai.png",
                                width: w * 0.06,
                                height: h * 0.06,
                              ),
                              title: "Tap to image  to upload aadhar",
                              content: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      _image1 == null
                                          ? Stack(
                                              children: [
                                                aadhar1 ==
                                                        null
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                ((builder) =>
                                                                    BottomSheet(
                                                                        1)),
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          width: w * 0.22,
                                                          height: h * 0.1,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff80707070),
                                                              border: Border.all(
                                                                  color:
                                                                      const Color.fromARGB(
                                                                          0,
                                                                          244,
                                                                          67,
                                                                          54),
                                                                  width: 0.1),
                                                              borderRadius:
                                                                  const BorderRadius.all(
                                                                      Radius.circular(
                                                                          15.0)),
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      "images/camera_img.png"),
                                                                  fit: BoxFit
                                                                      .fill)),
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                ((builder) =>
                                                                    BottomSheet(
                                                                        1)),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: w * 0.22,
                                                          height: h * 0.1,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      const Color.fromARGB(
                                                                          0,
                                                                          244,
                                                                          67,
                                                                          54),
                                                                  width: 0.1),
                                                              borderRadius:
                                                                  const BorderRadius.all(
                                                                      Radius.circular(
                                                                          15.0)),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(Config.apiURL +
                                                                      "/" +
                                                                      propertyDetailModel!
                                                                          .data!
                                                                          .aadharCardImage1!),
                                                                  fit: BoxFit.cover)),
                                                        ),
                                                      )
                                              ],
                                            )
                                          : ImagePickerDemo(
                                              image: _image1,
                                              onpress: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: ((builder) =>
                                                      BottomSheet(1)),
                                                );
                                              },
                                            ),
                                      SizedBox(
                                        width: w * 0.1,
                                      ),
                                      _image2 == null
                                          ? Stack(
                                              children: [
                                                aadhar2 ==
                                                        null
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                ((builder) =>
                                                                    BottomSheet(
                                                                        2)),
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          width: w * 0.22,
                                                          height: h * 0.1,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff80707070),
                                                              border: Border.all(
                                                                  color:
                                                                      const Color.fromARGB(
                                                                          0,
                                                                          244,
                                                                          67,
                                                                          54),
                                                                  width: 0.1),
                                                              borderRadius:
                                                                  const BorderRadius.all(
                                                                      Radius.circular(
                                                                          15.0)),
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      "images/camera_img.png"),
                                                                  fit: BoxFit
                                                                      .fill)),
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                ((builder) =>
                                                                    BottomSheet(
                                                                        2)),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: w * 0.22,
                                                          height: h * 0.1,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      const Color.fromARGB(
                                                                          0,
                                                                          244,
                                                                          67,
                                                                          54),
                                                                  width: 0.1),
                                                              borderRadius:
                                                                  const BorderRadius.all(
                                                                      Radius.circular(
                                                                          15.0)),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(Config.apiURL +
                                                                      "/" +
                                                                      propertyDetailModel!
                                                                          .data!
                                                                          .aadharCardImage2!),
                                                                  fit: BoxFit.cover)),
                                                        ),
                                                      )
                                              ],
                                            )
                                          : ImagePickerDemo(
                                              image: _image2,
                                              onpress: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: ((builder) =>
                                                      BottomSheet(2)),
                                                );
                                              },
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              showContent: isopen1,
                              subtitle: "Aadhar card"),

                          SizedBox(
                            height: 16,
                          ),

                          AccordionCard(
                              onpress: () {
                                if (isopen2) {
                                  setState(() {
                                    isopen2 = false;
                                  });
                                } else {
                                  setState(() {
                                    isopen2 = true;
                                    isopen1 = false;
                                    isopen3 = false;
                                  });
                                }
                              },
                              image: Image.asset(
                                "images/ai.png",
                                width: w * 0.06,
                                height: h * 0.06,
                              ),
                              title: "Tap to image  to upload pan",
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _image3 == null
                                      ? Stack(
                                          children: [
                                           pan ==
                                                    null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: ((builder) =>
                                                            BottomSheet(3)),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      width: w * 0.22,
                                                      height: h * 0.1,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xff80707070),
                                                          border: Border.all(
                                                              color:
                                                                  const Color.fromARGB(
                                                                      0,
                                                                      244,
                                                                      67,
                                                                      54),
                                                              width: 0.1),
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                                  Radius.circular(
                                                                      15.0)),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "images/camera_img.png"),
                                                              fit: BoxFit.fill)),
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: ((builder) =>
                                                            BottomSheet(3)),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: w * 0.22,
                                                      height: h * 0.1,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color.fromARGB(
                                                                  0, 244, 67, 54),
                                                              width: 0.1),
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                                  Radius.circular(
                                                                      15.0)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  Config.apiURL +
                                                                      "/" +
                                                                      propertyDetailModel!
                                                                          .data!
                                                                          .panCardImage!),
                                                              fit: BoxFit.cover)),
                                                    ),
                                                  )
                                          ],
                                        )
                                      : ImagePickerDemo(
                                          image: _image3,
                                          onpress: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: ((builder) =>
                                                  BottomSheet(3)),
                                            );
                                          },
                                        ),
                                ],
                              ),
                              showContent: isopen2,
                              subtitle: "Pan card"),
                          SizedBox(
                            height: 16,
                          ),
                          AccordionCard(
                            subtitle: "Bank Account",
                            image: Image.asset(
                              "images/ai.png",
                              width: w * 0.06,
                              height: h * 0.06,
                            ),
                            onpress: () {
                              if (isopen3) {
                                setState(() {
                                  isopen3 = false;
                                });
                              } else {
                                setState(() {
                                  isopen3 = true;
                                  isopen1 = false;
                                  isopen2 = false;
                                });
                              }
                            },
                            title: 'Tap to image to upload Passbook',
                            content: Column(
                              children: [
                                MyTextFormFieldTwo(
                                  mycontroller: accountNumberController,
                                  radius: 5.0,
                                  hts: 12.0,
                                  color: Colors.white,
                                  hintcolor: Color.fromARGB(255, 126, 122, 122),
                                  bordercolor:
                                      Color.fromARGB(255, 126, 122, 122),
                                  borderwidth: 0.5,
                                  width: 0.8,
                                  height: 0.04,
                                  textcolor: Colors.black,
                                  contentpadding: 15.0,
                                  length: 20,
                                  inptype: TextInputType.number,
                                  hinttxt: "Bank account number",
                                  valiadte: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter bank account number";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: MyTextFormFieldTwo(
                                        onChanged: (val) {
                                          setState(() {
                                            isopen3 = true;
                                            isopen2 = false;
                                            isopen1 = false;
                                          });
                                        },
                                        valiadte: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter IFSC Code";
                                          } else {
                                            return null;
                                          }
                                        },
                                        mycontroller: ifscCodeController,
                                        hts: 10.0,
                                        radius: 5.0,
                                        contentpadding: 15.0,
                                        textcolor: Colors.black,
                                        color: Colors.white,
                                        hintcolor:
                                            Color.fromARGB(255, 126, 122, 122),
                                        bordercolor:
                                            Color.fromARGB(255, 182, 175, 175),
                                        borderwidth: 0.5,
                                        width: 0.365,
                                        height: 0.04,
                                        length: 20,
                                        inptype: TextInputType.name,
                                        hinttxt: "IFSC code",
                                      ),
                                    ),
                                    SizedBox(width: w * 0.01),
                                    Expanded(
                                      child: MyTextFormFieldTwo(
                                        mycontroller: bankNameController,
                                        contentpadding: 0,
                                        textcolor: Colors.black,
                                        radius: 5.0,
                                        color: Colors.white,
                                        hintcolor:
                                            Color.fromARGB(255, 126, 122, 122),
                                        bordercolor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderwidth: 0.5,
                                        inptype: TextInputType.name,
                                        hinttxt: "Bank name",
                                        valiadte: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter bank name";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                _image4 == null
                                    ? Stack(
                                        children: [
                                         passbook==null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: ((builder) =>
                                                          BottomSheet(4)),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    width: w * 0.22,
                                                    height: h * 0.1,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff80707070),
                                                        border: Border.all(
                                                            color: const Color
                                                                    .fromARGB(
                                                                0, 244, 67, 54),
                                                            width: 0.1),
                                                        borderRadius:
                                                            const BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0)),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "images/camera_img.png"),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: ((builder) =>
                                                          BottomSheet(4)),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: w * 0.22,
                                                    height: h * 0.1,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: const Color.fromARGB(
                                                                0, 244, 67, 54),
                                                            width: 0.1),
                                                        borderRadius:
                                                            const BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0)),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                Config.apiURL +
                                                                    "/" +
                                                                    propertyDetailModel!
                                                                        .data!
                                                                        .bankAccount!
                                                                        .passBookImage!),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                )
                                        ],
                                      )
                                    : ImagePickerDemo(
                                        image: _image4,
                                        onpress: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) =>
                                                BottomSheet(4)),
                                          );
                                        },
                                      ),
                              ],
                            ),
                            showContent: isopen3,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          isProUpdating
                              ? const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    MyButton(
                                      onpress: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryRoomFloors(propertId: widget.propertId,),
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
                                      btncolor:
                                          Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    MyButton(
                                      onpress: () {
                                        if (_updateFormKey.currentState!
                                            .validate()) {
                                          if(aadhar1 ==
                                                  null ||
                                              aadhar2 ==
                                                  null) {
                                            if (_image1 == null ||
                                                _image2 == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Please upload Aadhar front and back side both')));
                                            }
                                          } else {
                                            if (pan ==
                                                null) {
                                              if (_image3 == null) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Please upload pancard')));
                                              }
                                            } else {
                                              if(passbook ==
                                                  null) {
                                                if (_image4 == null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please upload bank passbook')));
                                                }
                                              } else {
                                                updateProperty();
                                              }
                                            }
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Red highlighted field required')));
                                          return;
                                        }
                                      },
                                      btnname: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      width: 0.16,
                                      height: 0.075,
                                      btncolor:
                                          Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    ));
  }

  Widget BottomSheet(int intVal) {
    final h = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: (Border.all(
            width: 0.1, color: const Color.fromARGB(255, 255, 255, 255))),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      height: h * 0.2,
      child: Wrap(children: [
        SizedBox(height: h * 0.01),
        const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Choose Picture from",
              style: TextStyle(
                  color: Color.fromARGB(255, 137, 201, 221),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 137, 201, 221))),
          onPressed: () {
            getimage(ImageSource.camera, intVal);
          },
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Icon(Icons.camera),
              const SizedBox(width: 15.0),
              const Text("Camera"),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 137, 201, 221))),
          onPressed: () {
            getimage(ImageSource.gallery, intVal);
          },
          child: Row(
            children: [
              const Icon(Icons.photo),
              const SizedBox(width: 15.0),
              const Text("Gallary"),
            ],
          ),
        ),
      ]),
    );
  }

  Future getimage(ImageSource source, int val) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;
    {
      print("===================");
      setState(() {
        XFile img = XFile(image.path);
        if (val == 1) {
          _image1 = img;
           aadhar1=_image1;
        } else if (val == 2) {
          _image2 = img;
          aadhar2=_image2;
        } else if (val == 3) {
          _image3 = img;
          pan=_image3;
        } else if (val == 4) {
          _image4 = img;
          passbook=_image4;
        } else {}

        images.add(img);
      });
    }
    print("========images===========$images==========");

    Navigator.of(context).pop();
    if (val == 3) {
      setState(() {
        isopen3 = true;
      });
    } else if (val == 4) {
      setState(() {
        isopen3 = true;
      });
    } else {
      setState(() {
        isopen1 = true;
      });
    }
  }

  updateProperty() async {
    try {
      setState(() {
        isProUpdating = true;
      });

      var headers = {'Authorization': 'Bearer ${box2.read("logintoken")}'};
      print("=======headers======$headers============");

      print("=======url==========${box2.read("property_id")}========");
      var request = http.MultipartRequest(
          'PUT',
          Uri.parse("${Config.apiURL}" +
              "${Config.updatePropertyType}" +
              "${widget.propertId}"));

      var data = {
        'gstNumber': gstController.text.toString(),
        'bankAccount[accountNumber]': accountNumberController.text.toString(),
        'bankAccount[ifscCode]': ifscCodeController.text.toString(),
        'bankAccount[bankName]': bankNameController.text.toString()
      };

      print("===data========$data============");

      request.fields.addAll({
        'gstNumber': gstController.text.toString(),
        'bankAccount[accountNumber]': accountNumberController.text.toString(),
        'bankAccount[ifscCode]': ifscCodeController.text.toString(),
        'bankAccount[bankName]': bankNameController.text.toString()
      });

      if (_image1 != null) {
        final mimeTypeData =
            lookupMimeType(_image1!.path, headerBytes: [0xFF, 0xD8])
                ?.split('/');
        request.files.add(await http.MultipartFile.fromPath(
          'aadharCardImage1', _image1!.path,
          // contentType: MediaType(mimeTypeData![0], mimeTypeData[1]
          // )
        ));
      }
      if (_image2 != null) {
        final mimeTypeData2 =
            lookupMimeType(_image2!.path, headerBytes: [0xFF, 0xD8])
                ?.split('/');
        request.files.add(await http.MultipartFile.fromPath(
          'aadharCardImage2', _image2!.path,
          // contentType: MediaType(mimeTypeData2![0], mimeTypeData2[1])
        ));
      }
      if (_image3 != null) {
        final mimeTypeData3 =
            lookupMimeType(_image3!.path, headerBytes: [0xFF, 0xD8])
                ?.split('/');
        request.files.add(await http.MultipartFile.fromPath(
          'panCardImage', _image3!.path,
          // contentType: MediaType(mimeTypeData3![0], mimeTypeData3[1])
        ));
      }
      if (_image4 != null) {
        final mimeTypeData4 =
            lookupMimeType(_image4!.path, headerBytes: [0xFF, 0xD8])
                ?.split('/');
        request.files.add(await http.MultipartFile.fromPath(
          'bankAccount[passBookImage]', _image4!.path,
          // contentType: MediaType(mimeTypeData4![0], mimeTypeData4[1])
        ));
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          isProUpdating = false;
        });
        print(await response.stream.bytesToString());
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Property Update Successfully')));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HotelRoomDetails(propertId: widget.propertId,)));
      } else {
        setState(() {
          isProUpdating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed  to Update Property')));
        print(response.reasonPhrase);
      }
    } finally {
      setState(() {
        isProUpdating = false;
      });
    }
  }
}
