import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/facility_cart.dart';
import 'package:ghumo_24/components/update_arrow_button.dart';
import 'package:ghumo_24/components/image_picker.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/room_detail_model.dart';
import 'package:ghumo_24/screens/hotel_detail_done.dart';
import 'package:ghumo_24/screens/room_detail_done.dart';
import 'package:ghumo_24/screens/update_room_detail4.dart';
import 'package:ghumo_24/screens/update_room_details.dart';
import 'package:ghumo_24/services/base_client.dart';
import 'package:ghumo_24/utills/textthem.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RoomDetails3 extends StatefulWidget {
  const RoomDetails3({Key? key}) : super(key: key);

  @override
  State<RoomDetails3> createState() => _RoomDetails3State();
}

class _RoomDetails3State extends State<RoomDetails3> {
  bool isAc = false;
  bool isWifi = false;
  bool isTv = false;
  bool isTel = false;
  bool isIron = false;
  bool isBooks = false;

  XFile? _image1;
  XFile? _image2;
  XFile? _image3;
  XFile? _image4;
  XFile? _image5;
  XFile? _image6;
  XFile? _image7;
  bool isProUpdating = false;
  List<XFile> images = [];
  List<XFile> images1 = [];
  final ImagePicker imgpicker = ImagePicker();
  final ImagePicker _picker = ImagePicker();

  bool passpostchecked = false;

  List amientities = [];
  List specialFeatures = [];

  bool aadharchecked = false;

  bool drivinglicensechecked = false;

  bool governmentidchecked = false;

  bool accoundation = false;

  bool breakfast = false;

  bool dinner = false;

  bool lunch = false;
  bool lunchanddinner = false;

  bool yoga = false;

  bool ishow = false;
  bool isloading = false;

  BaseClient baseClient = BaseClient();

  RoomDetailModel? propertyDetailModel;

  getroom() async {
    setState(() {
      isloading = true;
    });
    var response = await baseClient.get(false, Config.apiURL,
        "${Config.getRoomByPropertId}${box2.read("property_id")}");

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
    getroom();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Image.asset(
            "images/ghumologo.png",
            width: w * 0.6,
            height: h * 0.07,
          ),
          Divider(
            height: 10,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 13),
            child: Center(
                child: Text(
              "Add Room Details",
              style: Texttheme.heading1,
            )),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text("Special in this room",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500)),
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  children: [
                    Facilitycart(
                        value: isAc,
                        onPress: () {
                          setState(() {
                            isAc = !isAc;
                            if (isAc) {
                              specialFeatures.add("A/C");
                            } else {
                              specialFeatures.remove("A/C");
                            }
                          });

                          print(
                              "====specialFeatures======$specialFeatures================");
                        },
                        image: "images/ac.png",
                        text: "A/C"),
                    Facilitycart(
                        value: isWifi,
                        onPress: () {
                          setState(() {
                            isWifi = !isWifi;
                            if (isWifi) {
                              specialFeatures.add("Wifi");
                            } else {
                              specialFeatures.remove("Wifi");
                            }
                          });
                          print(
                              "====specialFeatures======$specialFeatures================");
                        },
                        image: "images/wifi.png",
                        text: "Wifi"),
                    Facilitycart(
                        value: isTv,
                        onPress: () {
                          setState(() {
                            isTv = !isTv;
                            if (isTv) {
                              specialFeatures.add("TV");
                            } else {
                              specialFeatures.remove("TV");
                            }
                          });
                          print(
                              "====specialFeatures======$specialFeatures================");
                        },
                        image: "images/tv.png",
                        text: "TV"),
                    Facilitycart(
                        value: isBooks,
                        onPress: () {
                          setState(() {
                            isBooks = !isBooks;
                            if (isBooks) {
                              specialFeatures.add("Books");
                            } else {
                              specialFeatures.remove("Books");
                            }
                          });
                          print(
                              "====specialFeatures======$specialFeatures================");
                        },
                        image: "images/book.png",
                        text: "Books"),
                    Facilitycart(
                        value: isTel,
                        onPress: () {
                          setState(() {
                            isTel = !isTel;
                            if (isTel) {
                              specialFeatures.add("Telephone");
                            } else {
                              specialFeatures.remove("Telephone");
                            }
                          });
                          print(
                              "====specialFeatures======$specialFeatures================");
                        },
                        image: "images/telephone.png",
                        text: "Telephone"),
                    Facilitycart(
                        value: isIron,
                        onPress: () {
                          setState(() {
                            isIron = !isIron;
                            if (isIron) {
                              specialFeatures.add("Iron");
                            } else {
                              specialFeatures.remove("Iron");
                            }
                          });
                          print(
                              "====specialFeatures======$specialFeatures================");
                        },
                        image: "images/iron.png",
                        text: "Iron"),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                    decoration: BoxDecoration(
                      border: (Border.all(
                          width: 0.1,
                          color: const Color.fromARGB(0, 255, 255, 255))),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(15.0)),
                      color: const Color.fromARGB(221, 255, 255, 255),
                    ),
                    width: w * 0.9,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          ishow = !ishow;
                        });
                      },
                      title: const Text(
                        "Select Amientities in Room",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: Image.asset(
                        "images/property.png",
                        width: w * 0.055,
                        height: h * 0.055,
                      ),
                      trailing: Icon(Icons.arrow_drop_down),
                    )),
                ishow ? mealOtption() : SizedBox(),
              ],
            ),
          ),
          SizedBox(
            height: h * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text("Tap to image to uplode Room photos"),
          ),
          SizedBox(
            height: h * 0.04,
          ),
          images1.isEmpty
              ? isloading
                  ? SizedBox()
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: List.generate(
                          propertyDetailModel!.room!.first.roomPhoto!.length,
                          (index) {
                        var image =
                            propertyDetailModel!.room!.first.roomPhoto![index];
                        return Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          const Color.fromARGB(0, 244, 67, 54),
                                      width: 0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          Config.apiURL + "/" + image),
                                      fit: BoxFit.cover)),
                            ),
                            // Positioned(
                            //     right: 0,
                            //     top: 0,
                            //     child: InkWell(
                            //       onTap: () {
                            //         images1.removeAt(index);
                            //         setState(() {});
                            //       },
                            //       child: CircleAvatar(
                            //           radius: 13,
                            //           backgroundColor: Colors.red,
                            //           child: Icon(
                            //             Icons.close,
                            //             color: Colors.white,
                            //           )),
                            //     ))
                          ],
                        );
                      }),
                    )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  children: List.generate(images1.length, (index) {
                    XFile image = images1[index];
                    return Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(0, 244, 67, 54),
                                  width: 0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15.0)),
                              image: DecorationImage(
                                  image: FileImage(
                                    File(image.path),
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: InkWell(
                              onTap: () {
                                images1.removeAt(index);
                                setState(() {});
                              },
                              child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  )),
                            ))
                      ],
                    );
                  }),
                ),
          SizedBox(
            height: h * 0.04,
          ),
          Center(
              child: ImagePickerDemo(
            image: _image1,
            onpress: pickImages,
          )),
          SizedBox(
            height: h * 0.07,
          ),
          isProUpdating
              ? const SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //               MyButton(
                    //                 onpress: () {
                    //                   Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => UpdateRoomDetail(propertId: '', roomId: '${box2.read("room_id")}',),
                    //   ),
                    // );
                    //                 },
                    //                 btnname: const Icon(
                    //                   Icons.arrow_back,
                    //                   color: Colors.blue,
                    //                   size: 30.0,
                    //                 ),
                    //                 width: 0.16,
                    //                 height: 0.075,
                    //                 btncolor: const Color.fromARGB(255, 255, 255, 255),
                    //               ),
                    //               SizedBox(
                    //                 width: w * 0.05,
                    //               ),
                    //               SizedBox(
                    //                 width: 10,
                    //               ),
                    UpdateArrowButton(onpress: () {
                      updateRoom();
                    })
                  ],
                )
        ],
      )),
    );
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
        } else if (val == 2) {
          _image2 = img;
        } else if (val == 3) {
          _image3 = img;
        } else if (val == 4) {
          _image4 = img;
        } else if (val == 5) {
          _image5 = img;
        } else if (val == 6) {
          _image6 = img;
        } else {
          _image7 = img;
        }

        images.add(img);
      });
    }
    print("========images===========$images==========");

    Navigator.of(context).pop();
  }

  updateRoom() async {
    try {
      setState(() {
        isProUpdating = true;
      });

      var headers = {'Authorization': 'Bearer ${box2.read("logintoken")}'};
      var request = http.MultipartRequest(
          'PUT',
          Uri.parse("${Config.apiURL}" +
              "${Config.updateRoom}" +
              "${box2.read("room_id")}"));

      if (amientities.isNotEmpty) {
        request.fields.addAll({"amientities": amientities.join(",")});
      }

      if (specialFeatures.isNotEmpty) {
        request.fields.addAll({"specialFeature": specialFeatures.join(",")});
      }

      List<http.MultipartFile> newList = [];

      for (var img in images1) {
        print("imag---- ${img.path}");
        File pick = File(img.path);
        // final mimeTypeData =
        //     lookupMimeType(pick.path, headerBytes: [0xFF, 0xD8])?.split('/');
        if (img != "") {
          var multipartFile = await http.MultipartFile.fromPath(
            'roomPhoto', pick.path,
            // contentType: MediaType(mimeTypeData![0], mimeTypeData[1])
          );

          newList.add(multipartFile);
        }
      }

      request.files.addAll(newList);

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          isProUpdating = false;
        });
        print(await response.stream.bytesToString());
        BaseClient.box.write("isRoomStatus", true);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Property Update Successfully')));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => RoomDoneScreen()),
            ((route) => false));
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

  mealOtption() {
    // final h = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            width: 0.1, color: const Color.fromARGB(255, 255, 255, 255)),
        // borderRadius: const BorderRadius.all(const Radius.circular(15.0)
        // ),
      ),
      // height: h * 0.25,
      // ignore: prefer_const_literals_to_create_immutables
      child: Column(children: [
        ListTile(
          leading: Checkbox(
            value: accoundation,
            onChanged: (bool? value) {
              setState(() {
                accoundation = !accoundation;
              });
            },
          ),
          onTap: () {
            setState(() {
              accoundation = !accoundation;
              if (accoundation) {
                amientities.add("Accommodation only");
              } else {
                amientities.remove("Accommodation only");
              }
            });

            print(" Restaurant  $accoundation");
            print("  amientities  $amientities");
          },
          title: Text("Accommodation only"),
        ),
        const Divider(
          height: 5,
        ),
        ListTile(
          leading: Checkbox(
            value: breakfast,
            onChanged: (bool? value) {
              setState(() {
                breakfast = !breakfast;
              });
            },
          ),
          onTap: () {
            setState(() {
              breakfast = !breakfast;
              if (breakfast) {
                amientities.add("Free Breakfast");
              } else {
                amientities.remove("Free Breakfast");
              }
            });

            print(" Restaurant  $accoundation");
            print("  amientities  $amientities");
          },
          title: Text("Free Breakfast"),
        ),
        const Divider(
          height: 5,
        ),
        ListTile(
          leading: Checkbox(
            value: dinner,
            onChanged: (bool? value) {
              setState(() {
                dinner = !dinner;
              });
            },
          ),
          onTap: () {
            setState(() {
              dinner = !dinner;
              if (dinner) {
                amientities.add("Free Breakfast and Dinner");
              } else {
                amientities.remove("Free Breakfast and Dinner");
              }
            });

            print(" Restaurant  $dinner");
            print("  amientities  $dinner");
          },
          title: const Text("Free Breakfast and Dinner"),
        ),
        const Divider(
          height: 5,
        ),
        ListTile(
          leading: Checkbox(
            value: lunch,
            onChanged: (bool? value) {
              setState(() {
                lunch = !lunch;
              });
            },
          ),
          onTap: () {
            setState(() {
              lunch = !lunch;
              if (lunch) {
                amientities.add("Free Breakfast and Lunch");
              } else {
                amientities.remove("Free Breakfast and Lunch");
              }
            });

            print(" Restaurant  $lunch");
            print("  amientities  $lunch");
          },
          title: const Text("Free Breakfast and Lunch"),
        ),
        const Divider(
          height: 5,
        ),
        ListTile(
          leading: Checkbox(
            value: lunchanddinner,
            onChanged: (bool? value) {
              setState(() {
                lunchanddinner = !lunchanddinner;
              });
            },
          ),
          onTap: () {
            setState(() {
              lunchanddinner = !lunchanddinner;
              if (lunchanddinner) {
                amientities.add("Free Breakfast,Lunch and Dinner");
              } else {
                amientities.remove("Free Breakfast,Lunch and Dinner");
              }
            });

            print(" Restaurant  $lunchanddinner");
            print("  amientities  $lunchanddinner");
          },
          title: const Text("Free Breakfast,Lunch and Dinner"),
        ),
      ]),
    );
  }

  Future pickImages() async {
    // List<XFile> resultList = [];
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        // v  resultList = pickedfiles;
        setState(() {
          images1.addAll(pickedfiles);
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }
}
