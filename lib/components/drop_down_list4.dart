import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:ghumo_24/components/dynamic_cart.dart';
import 'package:ghumo_24/components/image_picker.dart';
import 'package:ghumo_24/components/static_cart.dart';
import 'package:ghumo_24/components/text_field_cart.dart';

class DropDownList4 extends StatefulWidget {
  DropDownList4({Key? key}) : super(key: key);

  @override
  State<DropDownList4> createState() => _DropDownList4State();
}

class _DropDownList4State extends State<DropDownList4> {
  bool passpostchecked = false;
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
  bool massage = false;
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
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: h * 0.008,
            child: Container(
              width: w * 0.9,
              height: h * 0.055,
              decoration: BoxDecoration(
                border: (Border.all(width: 0.1, color: Colors.white)),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(15.0)),
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: (Border.all(
                  width: 0.1, color: Color.fromARGB(0, 255, 255, 255))),
              borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
              color: Color.fromARGB(0, 255, 255, 255),
            ),
            width: w * 0.9,
            child: ExpansionTile(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              leading: Image.asset(
                "images/property.png",
                width: w * 0.055,
                height: h * 0.055,
              ),
              title: Text(
                "Select Amientities in Hotel",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              children: [
                ExpansionTile(
                  title: Container(child: Text("Dining")),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: Restaurant,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      Restaurant = value!;
                                    });
                                  }),
                              Text("Restaurant")
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
                                    });
                                  }),
                              Text("Dining Area")
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ExpansionTile(
                  title: Container(child: Text("Internet")),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: free_wifi,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      free_wifi = value!;
                                    });
                                  }),
                              Text("Free Wi-Fi")
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ExpansionTile(
                  title: Container(child: Text("Services")),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: railway_station_transfer,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      railway_station_transfer = value!;
                                    });
                                  }),
                              Text("Railway Station Transfers")
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
                                    });
                                  }),
                              Text("Pickup/Drop")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: laundry_service,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      laundry_service = value!;
                                    });
                                  }),
                              Text("Laundry Service")
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
                                  }),
                              Text("Laggage Assistance")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: massage,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      massage = value!;
                                    });
                                  }),
                              Text("Massage")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: doctor_on_call,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      doctor_on_call = value!;
                                    });
                                  }),
                              Text("Doctor on Call")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: bus_station_transfer,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      bus_station_transfer = value!;
                                    });
                                  }),
                              Text("Bus Station Transfer")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: paid_vehicle_transfer,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      passpostchecked = value!;
                                    });
                                  }),
                              Text("Paid Vehicle Rental")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: concierge,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      concierge = value!;
                                    });
                                  }),
                              Text("Concierge")
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ExpansionTile(
                  title: Container(child: Text("General")),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: outdoor_sports,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      outdoor_sports = value!;
                                    });
                                  }),
                              Text("Outdoor Sports")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: yoga,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      yoga = value!;
                                    });
                                  }),
                              Text("Yoga")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: air_conditioning,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      air_conditioning = value!;
                                    });
                                  }),
                              Text("Air Conditioning")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: activity_center,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      activity_center = value!;
                                    });
                                  }),
                              Text("Activity Center")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: luggage_storage,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      luggage_storage = value!;
                                    });
                                  }),
                              Text("Luggage Storage")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: sweeming_pool,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      sweeming_pool = value!;
                                    });
                                  }),
                              Text("Swimming Pool")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: free_parking,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      free_parking = value!;
                                    });
                                  }),
                              Text("Free Parking")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: lawn,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      lawn = value!;
                                    });
                                  }),
                              Text("Lawn")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: picnic_area,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      picnic_area = value!;
                                    });
                                  }),
                              Text("Picnic area")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: indoor_games,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      indoor_games = value!;
                                    });
                                  }),
                              Text("Indoor Games")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: cctv,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      cctv = value!;
                                    });
                                  }),
                              Text("CCTV")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: reception,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      reception = value!;
                                    });
                                  }),
                              Text("Reception")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: outdoor_furniture,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      outdoor_furniture = value!;
                                    });
                                  }),
                              Text("Outdoor Furniture")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: safety_and_security,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      safety_and_security = value!;
                                    });
                                  }),
                              Text("Safety and Security")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: kids_play_area,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      kids_play_area = value!;
                                    });
                                  }),
                              Text("Kids play Area")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: fire_extinguishers,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      fire_extinguishers = value!;
                                    });
                                  }),
                              Text("Fire Extinguishers")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: security,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      security = value!;
                                    });
                                  }),
                              Text("Security")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: seating_area,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      passpostchecked = value!;
                                    });
                                  }),
                              Text("Seating area")
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
                                  }),
                              Text("Public Restorooms")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  value: passpostchecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      passpostchecked = value!;
                                    });
                                  }),
                              Text("Power Backup")
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
