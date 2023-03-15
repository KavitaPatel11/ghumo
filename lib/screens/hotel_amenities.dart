import 'dart:convert';
import 'dart:io';
import 'package:ghumo_24/components/accordian_four.dart';
import 'package:ghumo_24/components/accordian_three.dart';
import 'package:ghumo_24/model/property_detail_model.dart';
import 'package:ghumo_24/screens/address.dart';
import 'package:ghumo_24/utills/textthem.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghumo_24/components/button.dart';
import 'package:ghumo_24/components/image_picker.dart';
import 'package:ghumo_24/components/static_cart.dart';
import 'package:ghumo_24/config.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';

import 'package:ghumo_24/screens/hotel_details.dart';

import '../services/base_client.dart';

class HotelAmenities extends StatefulWidget {
  final String propertId;
  HotelAmenities({super.key, required this.propertId});

  @override
  State<HotelAmenities> createState() => _HotelAmenitiesState();
}

class _HotelAmenitiesState extends State<HotelAmenities> {
  bool isProUpdating = false;
  List<XFile> images = [];

  XFile? _image1;
  bool isloading = false;
  final ImagePicker _picker = ImagePicker();
  final scrollController = ScrollController();

  final _headerStyle =
      const TextStyle(fontWeight: FontWeight.w500, color: Colors.black);

  final _contentStyleHeader = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700);

  final _contentStyle = const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);

  bool passpostchecked = false;

  List amientities = [].obs;

  bool aadharchecked = false;

  bool drivinglicensechecked = false;

  bool governmentidchecked = false;

  bool Restaurant = false;

  bool Dining_Area = false;

  bool free_wifi = false;

  bool railway_station_transfer = false;

  bool pickup_drop = false;

  bool laundry_service = false;

  bool laggage_assistance = false;

  bool Message = false;

  bool doctor_on_call = false;

  bool bus_station_transfer = false;

  bool paid_vehicle_transfer = false;

  bool concierge = false;

  bool outdoor_sports = false;

  bool yoga = false;

  bool air_conditioning = false;

  bool activity_center = false;

  bool luggage_storage = false;

  bool sweeming_pool = false;

  bool free_parking = false;

  bool lawn = false;

  bool picnic_area = false;

  bool indoor_games = false;

  bool cctv = false;

  bool reception = false;

  bool outdoor_furniture = false;

  bool safety_and_security = false;

  bool kids_play_area = false;

  bool fire_extinguishers = false;

  bool security = false;

  bool seating_area = false;

  bool pubilc_restorooms = false;

  bool power_backup = false;

  bool isopen1 = false;
  bool isopen2 = false;
  bool isopen3 = false;
  bool isopen4 = false;
  bool isopen5 = false;
  List<XFile> images1 = [];
  final ImagePicker imgpicker = ImagePicker();
  BaseClient baseClient = BaseClient();

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

        print("----------data----$data-----------");

        setState(() {
          propertyDetailModel = data;
        });

        if (propertyDetailModel!.data!.amientities!.isNotEmpty) {
          setState(() {
            amientities =
                propertyDetailModel!.data!.amientities!.first.split(",");
            Restaurant = propertyDetailModel!.data!.amientities!.first
                .contains("Restaurant");

            Dining_Area = propertyDetailModel!.data!.amientities!.first
                .contains("Dining Area");

            railway_station_transfer = propertyDetailModel!
                .data!.amientities!.first
                .contains("Railway Station Transfer");

            free_wifi = propertyDetailModel!.data!.amientities!.first
                .contains("Free Wifi");

            pickup_drop = propertyDetailModel!.data!.amientities!.first
                .contains("Pickup Drop");
            laundry_service = propertyDetailModel!.data!.amientities!.first
                .contains("Laundry Service");
            laggage_assistance = propertyDetailModel!.data!.amientities!.first
                .contains("Laggage Assistance");

            Message = propertyDetailModel!.data!.amientities!.first
                .contains("Message");
            doctor_on_call = propertyDetailModel!.data!.amientities!.first
                .contains("Doctor on Call");
            bus_station_transfer = propertyDetailModel!.data!.amientities!.first
                .contains("Bus Station Transfer");
            concierge = propertyDetailModel!.data!.amientities!.first
                .contains("Concierge");

            outdoor_sports = propertyDetailModel!.data!.amientities!.first
                .contains("Outdoor Sports");
            yoga =
                propertyDetailModel!.data!.amientities!.first.contains("Yoga");
            air_conditioning = propertyDetailModel!.data!.amientities!.first
                .contains("Air Conditioning");
            activity_center = propertyDetailModel!.data!.amientities!.first
                .contains("Activity Center");

            luggage_storage = propertyDetailModel!.data!.amientities!.first
                .contains("Luggage Storage");
            sweeming_pool = propertyDetailModel!.data!.amientities!.first
                .contains("Swimming Pool");
            free_parking = propertyDetailModel!.data!.amientities!.first
                .contains("Free Parking");

            lawn =
                propertyDetailModel!.data!.amientities!.first.contains("Lawn");
            picnic_area = propertyDetailModel!.data!.amientities!.first
                .contains("Picnic area");
            indoor_games = propertyDetailModel!.data!.amientities!.first
                .contains("Indoor Games");
            cctv =
                propertyDetailModel!.data!.amientities!.first.contains("CCTV");

            reception = propertyDetailModel!.data!.amientities!.first
                .contains("Reception");
            outdoor_furniture = propertyDetailModel!.data!.amientities!.first
                .contains("Outdoor Furniture");
            safety_and_security = propertyDetailModel!.data!.amientities!.first
                .contains("Safety and Security");
            kids_play_area = propertyDetailModel!.data!.amientities!.first
                .contains("Kids play Area");

            fire_extinguishers = propertyDetailModel!.data!.amientities!.first
                .contains("Fire Extinguishers");
            security = propertyDetailModel!.data!.amientities!.first
                .contains("Security");
            seating_area = propertyDetailModel!.data!.amientities!.first
                .contains("Seating area");
            paid_vehicle_transfer = propertyDetailModel!
                .data!.amientities!.first
                .contains("Paid Vehicle Rental");

            pubilc_restorooms = propertyDetailModel!.data!.amientities!.first
                .contains("Pubilc restorooms");
            power_backup = propertyDetailModel!.data!.amientities!.first
                .contains("Power Backup");

            print("=========Restaurant============$Restaurant==============");

            print(
                "propertyDetailModel!.data!.amientities!.first========${propertyDetailModel!.data!.amientities!.first}=============");
            isloading = false;
          });
        }
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

  Future pickImages() async {
    // List<XFile> resultList = [];
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        var resultList = pickedfiles;
        setState(() {
          images1.addAll(resultList);
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        // physics:AlwaysScrollableScrollPhysics(),
        controller: scrollController,
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
              SizedBox(
                width: 50,
              ),
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
            child: Column(
              // physics: AlwaysScrollableScrollPhysics(),
              // shrinkWrap: true,
              // controller: scrollController,
              children: [
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
                  child: AccordionCardThree(
                    image: Image.asset(
                      "images/property.png",
                      width: w * 0.055,
                      height: h * 0.055,
                    ),
                    title: "Select Amientities in Hotel",
                    content: Column(children: [
                      AccordionCardThreeFour(
                        title: "Dining",
                        content: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: Restaurant,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        Restaurant = value!;
                                        if (Restaurant) {
                                          amientities.add("Restaurant");
                                        } else {
                                          amientities.remove("Restaurant");
                                        }
                                      });

                                      print(" Restaurant  $Restaurant");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Restaurant")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: Dining_Area,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        Dining_Area = value!;
                                        if (Dining_Area) {
                                          amientities.add("Dining Area");
                                        } else {
                                          amientities.remove("Dining Area");
                                        }
                                      });

                                      print(" Restaurant  $Dining_Area");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Dining Area")
                              ],
                            ),
                          ],
                        ),
                        onpress: () {
                          setState(() {
                            isopen2 = !isopen2;
                            isopen3 = false;
                            isopen4 = false;
                            isopen5 = false;
                          });
                        },
                        showContent: isopen2,
                      ),

                      // 2

                      AccordionCardThreeFour(
                          onpress: () {
                            setState(() {
                              isopen3 = !isopen3;
                              isopen2 = false;
                              isopen4 = false;
                              isopen5 = false;
                            });
                          },
                          showContent: isopen3,
                          title: "Internet",
                          content: Column(children: [
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: free_wifi,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        free_wifi = value!;
                                        if (free_wifi) {
                                          amientities.add("Free Wifi");
                                        } else {
                                          amientities.remove("Free Wifi");
                                        }
                                      });

                                      print(" Restaurant  $free_wifi");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Free Wi-Fi")
                              ],
                            ),
                          ])),

                      // 3

                      AccordionCardThreeFour(
                        title: "Services",
                        content: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: railway_station_transfer,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        railway_station_transfer = value!;
                                        if (railway_station_transfer) {
                                          amientities
                                              .add("Railway Station Transfer");
                                        } else {
                                          amientities.remove(
                                              "Railway Station Transfer");
                                        }
                                      });

                                      print(
                                          " Restaurant  $railway_station_transfer");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Railway Station Transfers")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: pickup_drop,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        pickup_drop = value!;
                                        if (pickup_drop) {
                                          amientities.add("Pickup Drop");
                                        } else {
                                          amientities.remove("Pickup Drop");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Pickup/Drop")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: laundry_service,
                                    onChanged: (bool? value) {
                                      //

                                      setState(() {
                                        laundry_service = value!;
                                        if (laundry_service) {
                                          amientities.add("Laundry Service");
                                        } else {
                                          amientities.remove("Laundry Service");
                                        }
                                      });

                                      print(" Restaurant  $laundry_service");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Laundry Service")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: laggage_assistance,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        laggage_assistance = value!;
                                      });

                                      //
                                      setState(() {
                                        laggage_assistance = value!;
                                        if (laggage_assistance) {
                                          amientities.add("Laggage Assistance");
                                        } else {
                                          amientities
                                              .remove("Laggage Assistance");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Laggage Assistance")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: Message,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        Message = value!;
                                        if (Message) {
                                          amientities.add("Message");
                                        } else {
                                          amientities.remove("Message");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Message")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: doctor_on_call,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        doctor_on_call = value!;
                                        if (doctor_on_call) {
                                          amientities.add("Doctor on Call");
                                        } else {
                                          amientities.remove("Doctor on Call");
                                        }
                                      });

                                      print(" Restaurant  $doctor_on_call");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Doctor on Call")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: bus_station_transfer,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        bus_station_transfer = value!;
                                        if (bus_station_transfer) {
                                          amientities
                                              .add("Bus Station Transfer");
                                        } else {
                                          amientities
                                              .remove("Bus Station Transfer");
                                        }
                                      });

                                      print(
                                          " Restaurant  $bus_station_transfer");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Bus Station Transfer")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: paid_vehicle_transfer,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        paid_vehicle_transfer = value!;
                                        if (paid_vehicle_transfer) {
                                          amientities
                                              .add("Paid Vehicle Rental");
                                        } else {
                                          amientities
                                              .remove("Paid Vehicle Rental");
                                        }
                                      });

                                      print(
                                          " Restaurant  $paid_vehicle_transfer");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Paid Vehicle Rental")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: concierge,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        concierge = value!;
                                        if (concierge) {
                                          amientities.add("Concierge");
                                        } else {
                                          amientities.remove("Concierge");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Concierge")
                              ],
                            ),
                          ],
                        ),
                        onpress: () {
                          setState(() {
                            isopen4 = !isopen4;
                            isopen2 = false;
                            isopen3 = false;
                            isopen5 = false;
                          });
                        },
                        showContent: isopen4,
                      ),
                      // 4

                      AccordionCardThreeFour(
                        title: "General",
                        content: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: outdoor_sports,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        outdoor_sports = value!;
                                        if (outdoor_sports) {
                                          amientities.add("Outdoor Sports");
                                        } else {
                                          amientities.remove("Outdoor Sports");
                                        }
                                      });

                                      print(" Restaurant  $outdoor_sports");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Outdoor Sports")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: yoga,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        yoga = value!;
                                        if (yoga) {
                                          amientities.add("Yoga");
                                        } else {
                                          amientities.remove("Yoga");
                                        }
                                      });

                                      print(" Restaurant  $yoga");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Yoga")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: air_conditioning,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        air_conditioning = value!;
                                        if (air_conditioning) {
                                          amientities.add("Air Conditioning");
                                        } else {
                                          amientities
                                              .remove("Air Conditioning");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Air Conditioning")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: activity_center,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        activity_center = value!;
                                        if (activity_center) {
                                          amientities.add("Activity Center");
                                        } else {
                                          amientities.remove("Activity Center");
                                        }
                                      });

                                      print(" Restaurant  $activity_center");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Activity Center")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: luggage_storage,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        luggage_storage = value!;
                                        if (luggage_storage) {
                                          amientities.add("Luggage Storage");
                                        } else {
                                          amientities.remove("Luggage Storage");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Luggage Storage")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: sweeming_pool,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        sweeming_pool = value!;
                                        if (sweeming_pool) {
                                          amientities.add("Swimming Pool");
                                        } else {
                                          amientities.remove("Swimming Pool");
                                        }
                                      });

                                      print(" Restaurant  $sweeming_pool");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Swimming Pool")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: free_parking,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        free_parking = value!;
                                        if (free_parking) {
                                          amientities.add("Free Parking");
                                        } else {
                                          amientities.remove("Free Parking");
                                        }
                                      });

                                      print(" Restaurant  $free_parking");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Free Parking")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: lawn,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        lawn = value!;
                                        if (lawn) {
                                          amientities.add("Lawn");
                                        } else {
                                          amientities.remove("Lawn");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Lawn")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: picnic_area,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        picnic_area = value!;
                                        if (picnic_area) {
                                          amientities.add("Picnic area");
                                        } else {
                                          amientities.remove("Picnic area");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Picnic area")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: indoor_games,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        indoor_games = value!;
                                        if (indoor_games) {
                                          amientities.add("Indoor Games");
                                        } else {
                                          amientities.remove("Indoor Games");
                                        }
                                      });

                                      print(" Restaurant  $indoor_games");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Indoor Games")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: cctv,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        cctv = value!;
                                        if (cctv) {
                                          amientities.add("CCTV");
                                        } else {
                                          amientities.remove("CCTV");
                                        }
                                      });

                                      print(" Restaurant  $cctv");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("CCTV")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: reception,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        reception = value!;
                                        if (reception) {
                                          amientities.add("Reception");
                                        } else {
                                          amientities.remove("Reception");
                                        }
                                      });

                                      print(" Restaurant  $reception");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Reception")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: outdoor_furniture,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        outdoor_furniture = value!;
                                        if (outdoor_furniture) {
                                          amientities.add("Outdoor Furniture");
                                        } else {
                                          amientities
                                              .remove("Outdoor Furniture");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Outdoor Furniture")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: safety_and_security,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        safety_and_security = value!;
                                        if (safety_and_security) {
                                          amientities
                                              .add("Safety and Security");
                                        } else {
                                          amientities
                                              .remove("Safety and Security");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Safety and Security")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: kids_play_area,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        kids_play_area = value!;
                                        if (kids_play_area) {
                                          amientities.add("Kids play Area");
                                        } else {
                                          amientities.remove("Kids play Area");
                                        }
                                      });

                                      print(" Restaurant  $pickup_drop");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Kids play Area")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: fire_extinguishers,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        fire_extinguishers = value!;
                                        if (fire_extinguishers) {
                                          amientities.add("Fire Extinguishers");
                                        } else {
                                          amientities
                                              .remove("Fire Extinguishers");
                                        }
                                      });

                                      print(
                                          "Fire Extinguishers  $fire_extinguishers");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Fire Extinguishers")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: security,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        security = value!;
                                        if (security) {
                                          amientities.add("Security");
                                        } else {
                                          amientities.remove("Security");
                                        }
                                      });

                                      print(" Security  $security");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Security")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: seating_area,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        seating_area = value!;
                                        if (seating_area) {
                                          amientities.add("Seating area");
                                        } else {
                                          amientities.remove("Seating area");
                                        }
                                      });

                                      print(" seating_area  $seating_area");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Seating area")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: pubilc_restorooms,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        pubilc_restorooms = value!;
                                      });
                                      //
                                      setState(() {
                                        pubilc_restorooms = value!;
                                        if (pubilc_restorooms) {
                                          amientities.add("Pubilc restorooms");
                                        } else {
                                          amientities
                                              .remove("Pubilc restorooms");
                                        }
                                      });

                                      print(
                                          " pubilc_restorooms  $pubilc_restorooms");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Public Restorooms")
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: power_backup,
                                    onChanged: (bool? value) {
                                      //
                                      setState(() {
                                        power_backup = value!;
                                        if (power_backup) {
                                          amientities.add("Power Backup");
                                        } else {
                                          amientities.remove("Power Backup");
                                        }
                                      });

                                      print(" power_backup  $power_backup");
                                      print("  amientities  $amientities");
                                    }),
                                const Text("Power Backup")
                              ],
                            ),
                          ],
                        ),
                        onpress: () {
                          setState(() {
                            isopen5 = !isopen5;
                            isopen2 = false;
                            isopen4 = false;
                            isopen3 = false;
                          });
                        },
                        showContent: isopen5,
                      )
                    ]),
                    onpress: () {
                      setState(() {
                        isopen1 = !isopen1;
                      });
                    },
                    showContent: isopen1,
                  ),
                ),
                SizedBox(
                  height: h * 0.03,
                ),
                const StaticCart(),
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
                                propertyDetailModel!.data!.photos!.length,
                                (index) {
                              var image =
                                  propertyDetailModel!.data!.photos![index];
                              return Stack(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                0, 244, 67, 54),
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
                                        color: const Color.fromARGB(
                                            0, 244, 67, 54),
                                        width: 0.1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15.0)),
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

                // SizedBox(
                //   height: h * 5,
                //   child: GridView.count(
                //     mainAxisSpacing: 5,
                //     crossAxisSpacing: 5,
                //     padding: EdgeInsets.all(5),
                //     crossAxisCount: 3,
                //     children: List.generate(images1.length, (index) {
                //       Asset asset = images1[index];
                //       return AssetThumb(
                //         asset: asset,
                //         width: 300,
                //         height: 300,
                //       );
                //     }),
                //   ),
                // ),
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
                    : Container(
                        width: w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyButton(
                              onpress: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddressScreen(
                                      propertId: widget.propertId,
                                    ),
                                  ),
                                );
                              },
                              btnname: const Icon(
                                Icons.arrow_back,
                                color: Colors.blue,
                                size: 30.0,
                              ),
                              width: 0.16,
                              height: 0.07,
                              btncolor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                            SizedBox(
                              width: w * 0.05,
                            ),
                            MyButton(
                              onpress: () {
                                if (propertyDetailModel!
                                    .data!.amientities!.isEmpty) {
                                  print("fisrt");
                                  if (amientities.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please Select Amientities')));
                                  } else {
                                    print("second");
                                    if (propertyDetailModel!
                                        .data!.photos!.isEmpty) {
                                      if (images1.isEmpty) {
                                        print(
                                            "=======on update click== photos===========");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please upload atleast one property photos')));
                                      } else {
                                        print("last fisrt");
                                        updateProperty();
                                      }
                                    }
                                  }
                                } else {
                                  print(" else fisrt");
                                  if (propertyDetailModel!
                                      .data!.photos!.isEmpty) {
                                    if (images1.isEmpty) {
                                      print(
                                          "=======on update click== photos===========");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please upload atleast one property photos')));
                                    } else {
                                      print("sceond last");
                                      updateProperty();
                                    }
                                  } else {
                                    print("third last");
                                    updateProperty();
                                  }
                                }
                              },
                              btnname: const Icon(
                                Icons.arrow_forward,
                                color: Colors.blue,
                                size: 30.0,
                              ),
                              width: 0.16,
                              height: 0.07,
                              btncolor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: h * 0.026,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  updateProperty() async {
    try {
      setState(() {
        isProUpdating = true;
      });

      var headers = {'Authorization': 'Bearer ${box2.read("logintoken")}'};
      var request = http.MultipartRequest(
          'PUT',
          Uri.parse("${Config.apiURL}" +
              "${Config.updatePropertyType}" +
              "${widget.propertId}"));

      print(
          "====before uploading===========amientities===$amientities=========");

      if (amientities.isNotEmpty) {
        List<String> amentinityList = [];

        for (var am in amientities) {
          print("am--- ${am}");
          amentinityList.add(am);
        }
        request.fields.addAll({'amientities': amentinityList.join(",")});

        print("=====amentinityList======$amentinityList====================");
      }

      List<http.MultipartFile> newList = [];

      for (var img in images1) {
        print("imag---- ${img}");
        File pick = File(img.path);
        print("=========pick=====$pick=========");
        print("=========pick=path====${pick.path}=========");
        // final mimeTypeData =
        //     lookupMimeType(pick.path, headerBytes: [0xFF, 0xD8])?.split('/');
        if (img != "") {
          var multipartFile = await http.MultipartFile.fromPath(
            'photos', pick.path,
            // contentType: MediaType(mimeTypeData![0], mimeTypeData[1])
          );

          newList.add(multipartFile);
        }
      }
      print("========newList=======$newList===============");
      request.files.addAll(newList);

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          isProUpdating = false;
        });
        print(await response.stream.bytesToString());
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Property Update Successfully')));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HotelDetails(
                      propertId: widget.propertId,
                    )));
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
