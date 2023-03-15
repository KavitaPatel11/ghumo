import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/allproperty_detail_response.dart';
import 'package:ghumo_24/model/room_detail_model.dart';
import 'package:ghumo_24/screens/address.dart';
import 'package:ghumo_24/screens/authetication.dart';
import 'package:ghumo_24/screens/category_room_floors2.dart';
import 'package:ghumo_24/screens/gst.dart';
import 'package:ghumo_24/screens/hotel_amenities.dart';
import 'package:ghumo_24/screens/hotel_detail_done.dart';
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

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BaseClient baseClient = BaseClient();
  AllPropertyDetailModel? propertyDetailModel;
  RoomDetailModel? roomDetailModel;
  Timer? _timer;

  getproperty() async {
    var response = await baseClient.get(false, Config.apiURL,
        "${Config.getPropertyByUser}${BaseClient.box.read("user_id")}");

    var data1 = jsonDecode(response);

    print(
        "=========data1['success']===================${data1['success']}==========");

    if (data1['success'] == true) {
      var data = allPropertyDetailModelFromJson(response);
      if (data != null) {
        print("-----------daatt is not null---------------");

        print("----------data----$data-----------");
        propertyDetailModel = data;

        print(
            "-----------isPropertStatus ---${BaseClient.box.read("isPropertStatus")}------------");

        print(
            "-----------propertyDetailModel---$propertyDetailModel-----------");
        BaseClient.box
            .write("isPropertStatus", propertyDetailModel!.data!.first.active);
        // BaseClient.box.write("isPropertStatus", true);
        BaseClient.box
            .write("property_id", propertyDetailModel!.data!.first.id);

        BaseClient.box.write("1StUpdate", propertyDetailModel!.data!.first.id);

        BaseClient.box
            .write("2StUpdate", propertyDetailModel!.data!.first.name);
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
    }
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
                            builder: (context) => AddressScreen(propertId: "${BaseClient.box.read("property_id")}",),
                          ),
                        )
                      : amant.isEmpty
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HotelAmenities(propertId: "${BaseClient.box.read("property_id")}",),
                              ),
                            )
                          : BaseClient.box.read("4StUpdate") == null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelDetails(propertId: "${BaseClient.box.read("property_id")}",),
                                  ),
                                )
                              : BaseClient.box.read("5StUpdate") == null
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CategoryRoomFloors(propertId: "${BaseClient.box.read("property_id")}",),
                                      ),
                                    )
                                  : BaseClient.box.read("6StUpdate") == null
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => GstScreen(propertId: "${BaseClient.box.read("property_id")}",),
                                          ),
                                        )
                                      : BaseClient.box.read("7StUpdate") == null
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HotelRoomDetails(propertId: "${BaseClient.box.read("property_id")}",),
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
    var response = await baseClient.get(
        false, Config.apiURL, "${Config.getRoomByPropertId}$propertId");

    var data1 = jsonDecode(response);
    if (data1['success'] == true) {
      var data = roomDetailModelFromJson(response);
      if (data != null) {
        roomDetailModel = data;

        BaseClient.box.write("1StRoomUpdate", roomDetailModel!.room!.first.id);
        BaseClient.box.write("room_id", roomDetailModel!.room!.first.id);

        BaseClient.box
            .write("2StRoomUpdate", roomDetailModel!.room!.first.extraChild);
        BaseClient.box.write(
            "3StRoomUpdate", roomDetailModel!.room!.first.specialFeature);
      }
    }
  }

   @override
  void initState() {
   if(box2.read("logintoken")!=null){
     getproperty();
   }

    start();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("images/splash.png"))),
        ),
      ),
    );
  }
}
