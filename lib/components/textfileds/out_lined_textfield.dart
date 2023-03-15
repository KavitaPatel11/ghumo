import 'package:flutter/material.dart';

class OutlinedPrefixIconTextField extends StatelessWidget {
  final String hinttext;
  final int maxLength;
  final String? Function(String?)? validate;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String image;
  OutlinedPrefixIconTextField(
      {Key? key,
      required this.hinttext,
      required this.maxLength,
      required this.validate,
      required this.textInputType,
      required this.controller,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      maxLength: maxLength,
      keyboardType: textInputType,
      validator: validate,
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 12),
        prefixIcon: Icon(Icons.call),
        counterText: "",
        isDense: true,
        fillColor: Colors.white,
        // filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(15)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(15)),
        hintText: hinttext,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
