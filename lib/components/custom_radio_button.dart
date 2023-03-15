import 'package:flutter/material.dart';

class CustumRadioButton extends StatefulWidget {
  final String text;
  final bool value;
  final bool index;
  final VoidCallback? onPress;
 
  CustumRadioButton(
      {super.key,
      required this.text,
      required this.value,
     this.onPress, required this.index});

  @override
  State<CustumRadioButton> createState() => _CustumRadioButtonState();
}

class _CustumRadioButtonState extends State<CustumRadioButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        // height: 30,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: (widget.value == widget.index) ? [
                  Color(0Xff018CD1),
                  Color(0Xff018CD1),
                  
                ] : [
                  Color.fromARGB(128, 182, 214, 229),
                  Color.fromARGB(102, 102, 176, 212),
                  Color.fromARGB(255, 240, 219, 219),

                ]),

                boxShadow:[ 
               BoxShadow(
                  color: Color.fromRGBO(158, 158, 158, 1).withOpacity(0.5), //color of shadow
                  spreadRadius: 2, //spread radius
                  blurRadius: 8, // blur radius
                  offset: Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
               ),
               //you can set more BoxShadow() here
              ],
                ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: (widget.value == widget.index) ? Colors.white : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
