import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {Key? key,
      required this.onpress,
      required this.btnname,
      required this.width,
      required this.btncolor,
      required this.height})
      : super(key: key);
  final VoidCallback onpress;
  final Widget btnname;
  double width;
  double height;
  Color btncolor;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * width,
      height: h * height,
      child: ElevatedButton(
        onPressed: onpress,
        child: btnname,
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shadowColor: Color.fromARGB(255, 255, 166, 255),
          primary: btncolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0), // <-- Radius
          ),
        ),
      ),
    );
  }
}
