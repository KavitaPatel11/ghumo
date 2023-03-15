import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/allproperty_detail_response.dart';
import 'package:ghumo_24/model/room_detail_model.dart';

import 'package:ghumo_24/services/base_client.dart';

class RoyalHotelScreen extends StatefulWidget {
  RoyalHotelScreen({Key? key}) : super(key: key);
  @override
  State<RoyalHotelScreen> createState() => _RoyalHotelScreenState();
}

class _RoyalHotelScreenState extends State<RoyalHotelScreen> {
  BaseClient baseClient = BaseClient();
  AllPropertyDetailModel? propertyDetailModel;
  RoomDetailModel? roomDetailModel;
  bool isloading = false;
  bool isRloading = false;

  getproperty() async {
    setState(() {
      isloading = true;
    });

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

        getroom(propertyDetailModel!.data!.first.id!);
      }
    }

    setState(() {
      isloading = false;
    });
  }

  start() async {
    debugPrint(
        "=====BaseClient.box.read isPropertStatus===${BaseClient.box.read("isPropertStatus")}============================");

    // Timer(Duration(seconds: 3), () {
    //   BaseClient.box.read("isPropertStatus") == true
    //       ? Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => RoomCategoryScreen(),
    //           ),
    //           (route) => false,
    //         )
    //       : BaseClient.box.read("1StUpdate") == null
    //           ? Navigator.pushAndRemoveUntil(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => PropertyScreen(),
    //               ),
    //               (route) => false,
    //             )
    //           : BaseClient.box.read("2StUpdate") == null
    //               ? Navigator.pushAndRemoveUntil(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => AddressScreen(),
    //                   ),
    //                   (route) => false,
    //                 )
    //               : BaseClient.box.read("3StUpdate") == null
    //                   ? Navigator.pushAndRemoveUntil(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => HotelAmenities(),
    //                       ),
    //                       (route) => false,
    //                     )
    //                   : BaseClient.box.read("4StUpdate") == null
    //                       ? Navigator.pushAndRemoveUntil(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => HotelDetails(),
    //                           ),
    //                           (route) => false,
    //                         )
    //                       : BaseClient.box.read("5StUpdate") == null
    //                           ? Navigator.pushAndRemoveUntil(
    //                               context,
    //                               MaterialPageRoute(
    //                                 builder: (context) => CategoryRoomFloors(),
    //                               ),
    //                               (route) => false,
    //                             )
    //                           : BaseClient.box.read("6StUpdate") == null
    //                               ? Navigator.pushAndRemoveUntil(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (context) => GstScreen(),
    //                                   ),
    //                                   (route) => false,
    //                                 )
    //                               : BaseClient.box.read("7StUpdate") == null
    //                                   ? Navigator.pushAndRemoveUntil(
    //                                       context,
    //                                       MaterialPageRoute(
    //                                         builder: (context) =>
    //                                             HotelRoomDetails(),
    //                                       ),
    //                                       (route) => false,
    //                                     )
    //                                   : BaseClient.box.read("1StRoomUpdate") ==
    //                                           null
    //                                       ? Navigator.pushAndRemoveUntil(
    //                                           context,
    //                                           MaterialPageRoute(
    //                                             builder: (context) =>
    //                                                 RoomCategoryScreen(),
    //                                           ),
    //                                           (route) => false,
    //                                         )
    //                                       : BaseClient.box
    //                                                   .read("2StRoomUpdate") ==
    //                                               null
    //                                           ? Navigator.pushAndRemoveUntil(
    //                                               context,
    //                                               MaterialPageRoute(
    //                                                 builder: (context) =>
    //                                                     UpdateRoomDetail(),
    //                                               ),
    //                                               (route) => false,
    //                                             )
    //                                           : BaseClient.box.read(
    //                                                       "3StRoomUpdate") ==
    //                                                   null
    //                                               ? Navigator
    //                                                   .pushAndRemoveUntil(
    //                                                   context,
    //                                                   MaterialPageRoute(
    //                                                     builder: (context) =>
    //                                                         RoomDetails3(),
    //                                                   ),
    //                                                   (route) => false,
    //                                                 )
    //                                               : Navigator
    //                                                   .pushAndRemoveUntil(
    //                                                   context,
    //                                                   MaterialPageRoute(
    //                                                     builder: (context) =>
    //                                                         UpdateRoomDetailFour(),
    //                                                   ),
    //                                                   (route) => false,
    //                                                 );
    // });
  }

  getroom(String propertId) async {
    setState(() {
      isRloading = true;
    });
    var response = await baseClient.get(
        false, Config.apiURL, "${Config.getRoomByPropertId}$propertId");

    var data1 = jsonDecode(response);
    if (data1['success'] == true) {
      var data = roomDetailModelFromJson(response);
      if (data != null) {
        roomDetailModel = data;

        BaseClient.box.write("1StRoomUpdate", roomDetailModel!.room!.first.id);
        BaseClient.box.write("room_idR", roomDetailModel!.room!.first.id);

        BaseClient.box
            .write("2StRoomUpdate", roomDetailModel!.room!.first.extraChild);
        BaseClient.box.write(
            "3StRoomUpdate", roomDetailModel!.room!.first.specialFeature);
      }
    }
    setState(() {
      isRloading = false;
    });
  }

  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  String otp = "";

  bool isApiCallProcess = false;
  @override
  void initState() {
    getproperty();
    // TODO: implement initState
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            body: Container(
                width: w * 1.0,
                height: h * 1.0,
                child: Stack(
                  children: [
                    Container(
                      width: w * 1.0,
                      height: h * 1.0,
                      child: Image.asset(
                        "images/rh.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: h * 0.27,
                      left: w * 0.21,
                      child: Image.asset(
                        "images/rhl.png",
                        width: w * 0.645,
                        height: h * 0.445,
                      ),
                    )
                  ],
                ))));
  }
}
