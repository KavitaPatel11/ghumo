import 'package:flutter/material.dart';
import 'package:ghumo_24/config.dart';
import 'package:ghumo_24/model/room_category_model.dart';
import 'package:ghumo_24/screens/add_room.dart';
import 'package:ghumo_24/screens/hotel_details.dart';

import 'package:ghumo_24/screens/update_room_details.dart';
import 'package:ghumo_24/services/base_client.dart';

class RoomSelection extends StatefulWidget {
  final String propertId;
  RoomSelection({
    Key? key,
    required this.propertId,
  }) : super(key: key);

  @override
  State<RoomSelection> createState() => _RoomSelectionState();
}

class _RoomSelectionState extends State<RoomSelection> {
  BaseClient baseClient = BaseClient();
  RoomCategoryModel? roomCategoryModel;
  bool isloading = false;

  getCategory() async {
    setState(() {
      isloading = true;
    });

    var response =
        await baseClient.get(false, Config.apiURL, "${Config.getCategory}");
    var data = roomCategoryModelFromJson(response);
    if (data != null) {
      roomCategoryModel = data;
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    getCategory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return isloading == true
        ? Container(
            height: h,
            width: w,
            child: Center(
              child: CircularProgressIndicator(),
            ))
        : roomCategoryModel!.data!.isEmpty
            ? Center(
                child: Text("No Room Category Exist"),
              )
            : Container(
                alignment: Alignment.center,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 20),
                // color: Colors.amber,
                height: h,
                width: w,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: roomCategoryModel!.data!.map((e) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                              // minLeadingWidth: w * 0.3,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tileColor: Color(0Xff9C9C9C),
                              title: Text("${e.name == null ? "" : e.name}"),
                              leading: Container(
                                  height: h,
                                  width: w * 0.2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage("images/cat.png")))),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddRoomDetail(
                                              categoryName:
                                                  '${e.name == null ? "" : e.name}',
                                              propertyId: "${widget.propertId}",
                                            )));
                              }),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }).toList()),
              );
  }
}
