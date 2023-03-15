import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';
import 'package:ghumo_24/components/group_card.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/allproperty_detail_response.dart';
import 'package:ghumo_24/model/room_detail_model.dart';
import 'package:ghumo_24/screens/address.dart';
import 'package:ghumo_24/screens/category_room_floors2.dart';
import 'package:ghumo_24/screens/drawer/drawer_screen.dart';
import 'package:ghumo_24/screens/gst.dart';
import 'package:ghumo_24/screens/home_screen.dart';
import 'package:ghumo_24/screens/hotel_amenities.dart';
import 'package:ghumo_24/screens/hotel_detail_done.dart';
import 'package:ghumo_24/screens/hotel_details.dart';
import 'package:ghumo_24/screens/hotel_room_details.dart';
import 'package:ghumo_24/screens/menu/menu_card_two.dart';
import 'package:ghumo_24/screens/propertytype.dart';
import 'package:ghumo_24/screens/room_category.dart';
import 'package:ghumo_24/screens/room_details3.dart';
import 'package:ghumo_24/screens/splash_screen.dart';
import 'package:ghumo_24/screens/update_room_detail4.dart';
import 'package:ghumo_24/screens/update_room_details.dart';
import 'package:ghumo_24/utills/colors.dart';
import 'package:ghumo_24/utills/textthem.dart';

import '../../../../services/base_client.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  BaseClient baseClient = BaseClient();
  Timer? _timer;
  AllPropertyDetailModel? categoryModel;
  bool isLoading = true;
  bool isloading2 = false;
  RoomDetailModel? roomDetailModel;

  AllPropertyDetailModel? propertyDetailModel;

  fetchCategory() async {
    print(
        "=========${Config.getPropertyByUser}${BaseClient.box.read("user_id")}==========================");
    var response = await baseClient.get(
      false,
      Config.apiURL,
      "${Config.getPropertyByUser}${BaseClient.box.read("user_id")}",
    );
    categoryModel = allPropertyDetailModelFromJson(response);

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: AppColor.neturalGreen,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PropertyScreen(),
              ),
            );
          },
          icon: Icon(Icons.add),
          label: Text("Add New Property"),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
        backgroundColor: AppColor.accentWhite,
        title: Text(
          "All Properties",
          style: Texttheme.labletext,
        ),
        actions: [
          PopupMenuButton(onSelected: (value) {
            print("=====value======$value==============");

            if (value == "logout") {
              var box2 = GetStorage();
              box2.erase();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false,
              );
            } else {
              Navigator.of(context).pop();
            }

            // Navigator.pushNamed(context, value.toString());
          }, itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                onTap: () {},
                child: Text("My Account"),
                value: 'my_account',
              ),
              PopupMenuItem(
                child: Text("Privacy Policy"),
                value: 'privacy_policy',
              ),
              PopupMenuItem(
                child: Text("Help"),
                value: 'help',
              ),
              PopupMenuItem(
                child: Text("Logout"),
                value: 'logout',
              )
            ];
          })
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 50),
              child: isloading2
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 180,
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0),
                      itemCount: categoryModel!.data!.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                            onTap: () {
                              print(
                                  "===========${BaseClient.box.read("user_id")}=================================");
                              print(
                                  "=========${Config.apiURL}/api/${categoryModel!.data![index].photos == null}===============================");
                              print(
                                  "===========================================");

                              categoryModel!.data![index].name == null
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddressScreen(
                                          propertId:
                                              categoryModel!.data![index].id!,
                                        ),
                                      ),
                                    )
                                  : categoryModel!
                                          .data![index].amientities!.isEmpty
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HotelAmenities(
                                                    propertId: categoryModel!
                                                        .data![index].id!),
                                          ),
                                        )
                                      : categoryModel!
                                                  .data![index].personalEmail ==
                                              null
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HotelDetails(
                                                        propertId:
                                                            categoryModel!
                                                                .data![index]
                                                                .id!),
                                              ),
                                            )
                                          : categoryModel!.data![index]
                                                      .totalRooms ==
                                                  null
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CategoryRoomFloors(
                                                            propertId:
                                                                categoryModel!
                                                                    .data![
                                                                        index]
                                                                    .id!),
                                                  ),
                                                )
                                              : categoryModel!.data![index]
                                                          .gstNumber ==
                                                      null
                                                  ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            GstScreen(
                                                                propertId:
                                                                    categoryModel!
                                                                        .data![
                                                                            index]
                                                                        .id!),
                                                      ),
                                                    )
                                                  : categoryModel!.data![index]
                                                              .propertyRestriction ==
                                                          null
                                                      ? Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                HotelRoomDetails(
                                                                    propertId: categoryModel!
                                                                        .data![
                                                                            index]
                                                                        .id!),
                                                          ),
                                                        )
                                                      : categoryModel!
                                                                  .data![index]
                                                                  .active ==
                                                              false
                                                          ? Navigator
                                                              .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          HotelDoneScreen()),
                                                              // (route) => false,
                                                            )
                                                          : getroom(
                                                              categoryModel!
                                                                  .data![index]
                                                                  .id!);
                            },
                            child: GriupCard(
                                name:
                                    "${categoryModel!.data![index].name == null ? " " : categoryModel!.data![index].name}",
                                image:
                                    "${Config.apiURL}/api/${categoryModel!.data![index].photos == null ? " " : categoryModel!.data![index].photos!.first}"));
                      }),
            ),
    );
  }

  getroom(String propertId) async {
    setState(() {
      isloading2 = true;
    });

    print("===============room detail===by=====property id =========");

    print(
        "======${Config.getRoomByPropertId}=========room detail===by=====property id ===$propertId======");

    var response = await baseClient.get(
        true, Config.apiURL, "${Config.getRoomByPropertId}$propertId");

    print("=======response============${response.hashCode}================");

    if (response.hashCode == 475313437) {
      BaseClient.box.write("1StRoomUpdate", null);
    } else {
      var data1 = jsonDecode(response);
      if (data1['success'] == true) {
        print("-------------------------------------------------");
        var data = roomDetailModelFromJson(response);
        if (data != null) {
          roomDetailModel = data;

          for (int i = 0; i < roomDetailModel!.room!.length; i++) {
            roomDetailModel!.room![i].extraChild == null
                // ignore: use_build_context_synchronously
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateRoomDetail(
                          roomId: "${roomDetailModel!.room![i].id}",
                          propertId: "${propertId}"),
                    ),
                  )
                : roomDetailModel!.room![i].specialFeature!.isEmpty
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomDetails3(),
                        ),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateRoomDetailFour(
                              roomId: "${roomDetailModel!.room![i].id}",
                              propertId: "${propertId}"),
                        ),
                      );
          }
        }
      } else {
        BaseClient.box.write("1StRoomUpdate", null);
      }
    }

    setState(() {
      isloading2 = false;
    });
  }

  menuPicker() {
    // final h = MediaQuery.of(context).size.height;
    return Wrap(children: [
      Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          border: Border.all(
              width: 0.1, color: const Color.fromARGB(255, 255, 255, 255)),
          borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
        ),
        // height: h * 0.25,
        // ignore: prefer_const_literals_to_create_immutables
        child: Center(
          child: MenuCardTwoTwo(
              onpress: () {
                var box2 = GetStorage();
                box2.erase();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              icns: Icons.logout,
              text: "Logout"),
        ),
      ),
    ]);
  }
}
