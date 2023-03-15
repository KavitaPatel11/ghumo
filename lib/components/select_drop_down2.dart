import 'package:flutter/material.dart';

class SelectDropDown2 extends StatefulWidget {
  SelectDropDown2({Key? key}) : super(key: key);

  @override
  State<SelectDropDown2> createState() => _SelectDropDown2State();
}

class _SelectDropDown2State extends State<SelectDropDown2> {
  bool Accommodationonly = false;
  bool FreeBreakfast = false;
  bool FreeBreakfastanddinner = false;
  bool FreeBreakfastandlunch = false;
  bool FreeBreakfastlunchanddinner = false;
  String bedvalue = "Select Meal Option";
  BottomSheet() {
    final h = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border:
            (Border.all(width: 0.1, color: Color.fromARGB(255, 255, 255, 255))),
        borderRadius: const BorderRadius.all(const Radius.circular(15.0)),
      ),
      height: h * 0.3,
      child: Column(children: [
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: Accommodationonly,
                onChanged: (bool? value) {
                  setState(() {
                    Accommodationonly = value!;
                    bedvalue = "Accommodation Only";
                  });
                }),
            Text("Accommodation Only"),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: FreeBreakfast,
                onChanged: (bool? value) {
                  setState(() {
                    FreeBreakfast = value!;
                    bedvalue = "Free Breakfast";
                  });
                }),
            Text("Free Breakfast"),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: FreeBreakfastanddinner,
                onChanged: (bool? value) {
                  setState(() {
                    FreeBreakfastanddinner = value!;
                    bedvalue = "Free Breakfast and Dinner";
                  });
                }),
            Text("Free Breakfast and Dinner"),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: FreeBreakfastandlunch,
                onChanged: (bool? value) {
                  setState(() {
                    FreeBreakfastandlunch = value!;
                    bedvalue = "Free Breakfast and lunch";
                  });
                }),
            Text("Free Breakfast and lunch"),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: FreeBreakfastlunchanddinner,
                onChanged: (bool? value) {
                  setState(() {
                    FreeBreakfastlunchanddinner = value!;
                    bedvalue = "Free Breakfast lunch and dinner";
                  });
                }),
            Text("Free Breakfast lunch and dinner"),
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
