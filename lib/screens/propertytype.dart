import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghumo_24/components/dynamic_cart.dart';
import 'package:ghumo_24/components/property_type_card.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/create_property_response.dart';
import 'package:ghumo_24/screens/address.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ghumo_24/screens/royal_hotel.dart';
import 'package:ghumo_24/services/base_client.dart';
import 'package:ghumo_24/services/shared_services.dart';
import 'package:ghumo_24/utills/colors.dart';
import 'package:ghumo_24/utills/textthem.dart';

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({Key? key}) : super(key: key);

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  BaseClient baseClient = BaseClient();

  propertytype(String type) async {
    var loginDetails = await SharedService.loginDetails();
    var data = {"hotelType": "$type"};
    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.post(
        true,
        "${Config.apiURL}",
        "${Config.propertyType}${box2.read("user_id")}",
        data,
      )),
    );

    var msg = jsonDecode(apiResponse);

    print("=======apiResponse=======${msg['success']}====================");

    if (msg['success'] == false) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${msg['message']}')));
    } else {
      var data = createPropertyModelFromJson(apiResponse);

      print("property id apiResponse  $data");
      box2.write("property_id", data.property!.id);
      // var propertyId=apiResponse

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AddressScreen(propertId: data.property!.id!),
        ),
        (route) => false,
      );
    }
  }

  bool isLoading = true;
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
          color: AppColor.defaultBlackColor,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Center(
                child: Text(
              "Which Property Type Would You Like to List?",
              textAlign: TextAlign.center,
              style: Texttheme.heading1.copyWith(fontSize: 20),
            ))),
        Container(
          height: h * 0.8,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: Center(
                      child: Text(
                    "Proceed By Selecting One Option.",
                    textAlign: TextAlign.center,
                    style: Texttheme.heading1.copyWith(fontSize: 15),
                  ))),
              PropertyTypeCard(
                  image: "images/hotelimg.png",
                  title: "Hotel",
                  subtitle:
                      "Accommodations with facilities like dinig venues,meeting rooms & more.",
                  onpress: () {
                    propertytype("Hotel");
                  }),
              SizedBox(
                height: 30,
              ),
              PropertyTypeCard(
                  image: "images/homeimg.png",
                  title: "Homestay",
                  subtitle:
                      "large independent homes/bungalows for guests that can be rented entriely or by room",
                  onpress: () {
                    propertytype("homestay");
                  })
            ],
          ),
        )
      ],
    )));
  }
}
