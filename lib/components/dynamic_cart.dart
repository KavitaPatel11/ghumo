import 'package:flutter/material.dart';

class MyCart extends StatelessWidget {
  MyCart(
    this.height,
    this.width,
    this.tlr,
    this.trr,
    this.blr,
    this.brr,
    this.fcolor,
    this.scolor,
    this.bordercolor,
  ) : super();
  final double height;
  final double width;
  final Color bordercolor;
  final double tlr;
  final double trr;
  final double blr;
  final double brr;
  final Color fcolor;
  final Color scolor;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      height: h * height,
      width: w * width,
      decoration: BoxDecoration(
          border: (Border.all(width: 1.0, color: bordercolor)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(tlr),
              topRight: Radius.circular(trr),
              bottomLeft: Radius.circular(blr),
              bottomRight: Radius.circular(brr)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              fcolor,
              scolor,
            ],
          )),
    );
  }
}
