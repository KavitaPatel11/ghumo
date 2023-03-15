import 'package:flutter/material.dart';

class SelectDropDown extends StatefulWidget {
  SelectDropDown({Key? key}) : super(key: key);

  @override
  State<SelectDropDown> createState() => _SelectDropDownState();
}

class _SelectDropDownState extends State<SelectDropDown> {
  bool king = false;
  bool queen = false;
  bool twoSingleBed = false;
  bool fourBedFamilyroom = false;
  String bedvalue = "Select Bed Type";

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
                value: king,
                onChanged: (bool? value) {
                  setState(() {
                    king = value!;
                    bedvalue = "King";
                  });
                }),
            Text("King"),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: queen,
                onChanged: (bool? value) {
                  setState(() {
                    queen = value!;
                    bedvalue = "Queen";
                  });
                }),
            Text("Queen"),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: twoSingleBed,
                onChanged: (bool? value) {
                  setState(() {
                    twoSingleBed = value!;
                    bedvalue = "2 Single bed";
                  });
                }),
            Text("2 Single bed"),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: fourBedFamilyroom,
                onChanged: (bool? value) {
                  setState(() {
                    fourBedFamilyroom = value!;
                    bedvalue = "4 Bed Family Room";
                  });
                }),
            Text("4 Bed Family Room"),
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
