import 'package:flutter/material.dart';
import 'package:ghumo_24/utills/textthem.dart';

class SufixIconTextField extends StatelessWidget {
  final String hinttext;
  final int maxLength;
  final String? Function(String?) validate;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool readOnly;
  final String image;
  final VoidCallback onTap;
  SufixIconTextField(
      {Key? key,
      required this.hinttext,
      required this.maxLength,
      required this.validate,
      required this.textInputType,
      required this.controller,
      required this.image,
      required this.readOnly, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return TextFormField(
    
    
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      maxLength: maxLength,
      keyboardType: textInputType,
      validator: validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintStyle: Texttheme.hintstyle.copyWith(color: Colors.black45),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            image,
            width: 5,
            height: 5,
            color: Colors.grey.shade500,
          ),
        ),
        counterText: "",
        isDense: true,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white, ),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, ),
            borderRadius: BorderRadius.circular(15)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, ),
            borderRadius: BorderRadius.circular(15)),
        hintText: hinttext,
      ),
    );
  }
}
