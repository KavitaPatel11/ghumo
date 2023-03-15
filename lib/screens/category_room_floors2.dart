import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/text_field_cart.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/property_detail_model.dart';
import 'package:ghumo_24/screens/gst.dart';
import 'package:ghumo_24/screens/hotel_details.dart';
import 'package:ghumo_24/screens/menu/menu.dart';
import 'package:ghumo_24/services/base_client.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ghumo_24/utills/textthem.dart';

import 'package:flutter/services.dart';
import 'package:material_tag_editor/tag_editor.dart';

class CategoryRoomFloors extends StatefulWidget {
  final String propertId;
  const CategoryRoomFloors({Key? key, required this.propertId}) : super(key: key);

  @override
  State<CategoryRoomFloors> createState() => _CategoryRoomFloorsState();
}

class _CategoryRoomFloorsState extends State<CategoryRoomFloors> {
  final TextEditingController totalFloorController = TextEditingController();
  final TextEditingController totalRoomsController = TextEditingController();
  final TextEditingController nearFamousPlaceController =
      TextEditingController();

  GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();

  Map<String, dynamic> address = {};

  BaseClient baseClient = BaseClient();
  DateTime? _selected1;

  List<String> _values = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

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
        print("-----------daatt is not null----${data.data!.nearFamousPlace}-----------");

        var data3=data1['data'];
       
        propertyDetailModel = data;

        if(data.data!.nearFamousPlace!=null){


        
        
        
        setState(() {
          print(
              "=========propertyDetailModel!.data!.nearFamousPlace!.length======${propertyDetailModel!.data!.nearFamousPlace!.length}===========================");

               var d=propertyDetailModel!.data!.nearFamousPlace!.split(",");

               print("=========d====$d==========");

          for (var m in d) {        

            _values.add(m);
          }

          totalFloorController.text =
              "${propertyDetailModel!.data!.totalFloor == null ? "" : propertyDetailModel!.data!.totalFloor!}";
          totalRoomsController.text =
              "${propertyDetailModel!.data!.totalRooms == null ? "" : propertyDetailModel!.data!.totalRooms}";
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

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  _onPressedModifyTextField() {
    final text = 'Test';
    _textEditingController.text = text;
    _textEditingController.value = _textEditingController.value.copyWith(
      text: text,
      selection: TextSelection(
        baseOffset: text.length,
        extentOffset: text.length,
      ),
    );
  }

  updatepropertyt() async {
    String places = _values.join(",");
    print("===========places=====$places============");
    var data = {
      'nearFamousPlace': places,
      'totalFloor': totalFloorController.text,
      'totalRooms': totalRoomsController.text,
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
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GstScreen(propertId: widget.propertId,),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to Upadate Property')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _updateFormKey,
          child: Container(
              width: w,
              height: h,
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
                  Divider(
                    height: 10,
                    color: Colors.black,
                  ),
                  SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36, vertical: 20),
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
                          mycontroller: totalRoomsController,
                          radius: 15.0,
                          textcolor: Colors.black,
                          hts: 15.0,
                          bordercolor: Color.fromARGB(255, 255, 255, 255),
                          borderwidth: 0.0,
                          width: 0.9,
                          contentpadding: 45.0,
                          height: 0.05,
                          hinttxt: "Total number of rooms",
                          prefixicon: Image.asset(
                            "images/room.png",
                            width: w * 0.06,
                            height: h * 0.06,
                          ),
                          color: Colors.white,
                          textInputType: TextInputType.number,
                          length: 40,
                          hintcolor: Color.fromARGB(255, 126, 122, 122),
                          valiadte: (value) {
                            if (value!.isEmpty) {
                              return "Enter number of rooms";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyTextFormField(
                          mycontroller: totalFloorController,
                          radius: 15.0,
                          bordercolor: Color.fromARGB(255, 255, 255, 255),
                          borderwidth: 0.0,
                          textcolor: Colors.black,
                          width: 0.9,
                          contentpadding: 45.0,
                          height: 0.05,
                          hinttxt: "Total number of floors in hotel",
                          prefixicon: Image.asset(
                            "images/room.png",
                            width: w * 0.06,
                            height: h * 0.06,
                          ),
                          color: Colors.white,
                          textInputType: TextInputType.number,
                          length: 10,
                          hintcolor: Color.fromARGB(255, 126, 122, 122),
                          hts: 15.0,
                          valiadte: (value) {
                            if (value!.isEmpty) {
                              return "Enter number of floors";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyTextFormField(
                          readOnly: true,
                          radius: 15.0,
                          bordercolor: Color.fromARGB(255, 255, 255, 255),
                          borderwidth: 0.0,
                          textcolor: Colors.black,
                          width: 0.9,
                          contentpadding: 45.0,
                          height: 0.05,
                          hinttxt: "Femous places near your property",
                          prefixicon: Image.asset(
                            "images/room.png",
                            width: w * 0.06,
                            height: h * 0.06,
                          ),
                          color: Colors.white,
                          textInputType: TextInputType.number,
                          length: 10,
                          hintcolor: Color.fromARGB(255, 126, 122, 122),
                          hts: 15.0,
                        ),
                        TagEditor(
                          length: _values.length,
                          controller: _textEditingController,
                          focusNode: _focusNode,
                          delimiters: [','],
                          hasAddButton: true,
                          resetTextOnSubmitted: true,

                          // This is set to grey just to illustrate the `textStyle` prop
                          textStyle: const TextStyle(color: Colors.grey),
                          onSubmitted: (outstandingValue) {
                            setState(() {
                              _values.add(outstandingValue);
                            });
                          },
                          inputDecoration: const InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'Add PLace.',
                          ),
                          onTagChanged: (newValue) {
                            setState(() {
                              _values.add(newValue);
                            });
                          },
                          tagBuilder: (context, index) => _Chip(
                            index: index,
                            label: _values[index],
                            onDeleted: _onDelete,
                          ),
                          // InputFormatters example, this disallow \ and /
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                          ],
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
                                    builder: (context) => HotelDetails(propertId: widget.propertId,),
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
                              width: 16,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
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

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
