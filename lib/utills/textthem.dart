import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

class Texttheme {
  static TextStyle mainheading = TextStyle(
    color: HexColor("#384955"),
    fontSize: 52,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: 'Poppins',
  );
  static TextStyle heading1 = TextStyle(
    color: Color(0xff000000),
    fontSize: 22,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontFamily: 'Poppins',
  );

  static TextStyle heading2 = TextStyle(
    color: AppColor.defaultBlackColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontFamily: 'Open Sans',
  );
   static TextStyle subheading = TextStyle(
    color: Color(0xffCC000000),
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontFamily: 'Poppins',
  );

  static TextStyle labletext = const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontFamily: 'Poppins',
  );
  static TextStyle hintstyle = TextStyle(
      color: Color(0xff80000000),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontFamily: 'Poppins');

  static TextStyle titleRegular = TextStyle(
      color: HexColor("#000000"),
      fontSize: 16,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      fontFamily: 'Poppins');

  static TextStyle subTitle = TextStyle(
      color: HexColor("#6E6A7C"),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontFamily: 'Poppins');

  static TextStyle bodyText1 = TextStyle(
    color: HexColor("#000000"),
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontFamily: 'Open Sans',
  );
  static TextStyle bodyText2 = TextStyle(
    color: HexColor("#7B6F72"),
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontFamily: 'Work Sans',
  );
  static TextStyle headingcaption1 = TextStyle(
      color: HexColor("#FFFFFF"),
      fontWeight: FontWeight.w700,
      fontSize: 14,
      fontFamily: 'Poppins');
  static TextStyle buttonTextStyle = TextStyle(
      color: HexColor("#FFFFFF"),
      fontWeight: FontWeight.w700,
      fontSize: 14,
      fontFamily: 'Lato');

  static TextStyle logoTextStyle = TextStyle(
      color: HexColor("#544099"),
      fontWeight: FontWeight.w900,
      fontSize: 24,
      fontStyle: FontStyle.normal,
      fontFamily: 'Lato');
}

const String baseUrl = "https://mvp.booksica.in";
