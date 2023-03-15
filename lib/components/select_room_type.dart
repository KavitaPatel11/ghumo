import 'package:flutter/material.dart';

class SelectRoomType extends StatefulWidget {
  SelectRoomType({Key? key}) : super(key: key);

  @override
  State<SelectRoomType> createState() => _SelectRoomTypeState();
}

class _SelectRoomTypeState extends State<SelectRoomType> {
  bool classic = false;
  bool delux = false;
  bool sea_view_room = false;
  bool hill_view_room = false;
  String bedvalue = "CLASSIC";

  BottomSheet() {
    final h = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border:
            (Border.all(width: 0.1, color: Color.fromARGB(255, 255, 255, 255))),
        borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
      ),
      height: h * 0.25,
      child: Column(children: [
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: classic,
                onChanged: (bool? value) {
                  classic = true;
                  setState(() {
                    classic = value!;
                  });
                }),
            Text("Classic"),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: delux,
                onChanged: (bool? value) {
                  setState(() {
                    delux = value!;
                    bedvalue = "Delux";
                  });
                }),
            Text("Delux"),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: sea_view_room,
                onChanged: (bool? value) {
                  sea_view_room = value!;
                  setState(() {
                    sea_view_room = value;
                    bedvalue = "Sea view rooms";
                  });
                }),
            Text("Sea view rooms"),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: hill_view_room,
                onChanged: (bool? value) {
                  setState(() {
                    hill_view_room = value!;
                    bedvalue = "Hill view rooms";
                  });
                }),
            Text("Hill view rooms"),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        width: w * 0.9,
        height: h * 0.05,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: (Border.all(width: 0.1, color: Colors.white)),
          borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Image.asset("images/rn.png", width: w * 0.05, height: h * 0.05),
            SizedBox(
              width: w * 0.05,
            ),
            Text(bedvalue,
                style: TextStyle(
                  color: Color.fromARGB(255, 122, 121, 121),
                  fontSize: 15.0,
                )),
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: ((builder) => BottomSheet()),
        );
      },
    );
  }
}
