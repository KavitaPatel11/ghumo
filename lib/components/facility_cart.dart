// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Facilitycart extends StatefulWidget {
  final String? image;
  final String? text;
  final VoidCallback? onPress;
  final bool? value;

  Facilitycart({
    Key? key,
    required this.image,
    required this.text,
    this.onPress,
    this.value,
  }) : super(key: key);

  @override
  State<Facilitycart> createState() => _FacilitycartState();
}

class _FacilitycartState extends State<Facilitycart> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
    
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: widget.value!
            ? Color(0Xff018CD1)
            : Color(0XffFFFFFF),
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          GestureDetector(
              child:
                  Image.asset(widget.image!, width: w * 0.1, height: h * 0.041,color: widget.value!?Color(0XffFFFFFF):Color(0Xff0000000),
                  ),
              onTap: widget.onPress),
          Text(
            widget.text!,
            style: TextStyle(fontWeight: FontWeight.w500,color: widget.value!?Color(0XffFFFFFF):Color(0Xff0000000),),
          )
        ],
      ),
    );
  }
}
