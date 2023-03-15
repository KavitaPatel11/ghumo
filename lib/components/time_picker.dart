import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TimePicker();
  }
}

class _TimePicker extends State<TimePicker> {
  TextEditingController timeinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
        height: h * 0.045,
        width: w * 0.4,
        padding: EdgeInsets.only(bottom: 4.0, left: 10.0),
        decoration: BoxDecoration(
          border: (Border.all(
              width: 2.0, color: Color.fromARGB(255, 202, 196, 196))),
          borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
          color: Colors.white,
        ),
        child: TextField(
          controller: timeinput, //editing controller of this TextField
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: 10.0, top: 2.0, bottom: 12.0),
              border: InputBorder.none,
              suffixIcon: Icon(Icons.alarm), //icon of text field
              hintText: "Enter Time" //label text of field
              ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            );

            if (pickedTime != null) {
              print(pickedTime.format(context)); //output 10:51 PM
              DateTime parsedTime =
                  DateFormat.jm().parse(pickedTime.format(context).toString());
              //converting to DateTime so that we can further format on different pattern.
              print(parsedTime); //output 1970-01-01 22:53:00.000
              String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
              print(formattedTime); //output 14:59:00
              //DateFormat() is from intl package, you can format the time on any pattern you need.

              setState(() {
                timeinput.text = formattedTime; //set the value of text field.
              });
            } else {
              print("Time is not selected");
            }
          },
        ));
  }
}
