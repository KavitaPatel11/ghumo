import 'package:flutter/material.dart';
import 'package:ghumo_24/utills/textthem.dart';

class MyTextFormField extends StatefulWidget {
  MyTextFormField({
    Key? key,
    this.radius,
    this.color,
    this.textcolor,
    this.hintcolor,
    this.bordercolor,
    this.borderwidth,
    this.width,
    this.height,
    this.length,
    this.contentpadding,
    this.inptype,
    this.hinttxt,
    this.hts,
    this.prefixicon,
    this.valiadte,
    this.maxLength,
    this.textInputType,
    this.mycontroller,
    this.onSubmit,
    this.onEditingComplete,
    this.readOnly = false,
    this.ontab,
    this.onChanged, this.minline=1,
    this.mxline=1
  }) : super(key: key);
  final String? hinttxt;
  final Widget? prefixicon;
  final bool readOnly;
  final int? minline;
    final int? mxline;

  final Function()? ontab;
  Color? textcolor;
  double? radius;
  double? hts;
  double? borderwidth;
  double? width;
  double? height;
  double? contentpadding;
  Color? color;
  Color? hintcolor;

  int? length;
  TextInputType? inptype;
  Color? bordercolor;
  final String? Function(String?)? valiadte;
  final String? Function(String?)? onSubmit;
  final String? Function(String?)? onChanged;
  final String? Function()? onEditingComplete;
  final int? maxLength;

  final TextInputType? textInputType;
  final TextEditingController? mycontroller;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return TextFormField(
      
      minLines:widget.minline ,
      maxLines: widget.mxline,
      onTap: widget.ontab,
      readOnly: widget.readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: widget.length,
      controller: widget.mycontroller,
      keyboardType: widget. textInputType,
      style: TextStyle(color: widget.textcolor),
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onSubmit,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.prefixicon,
        ),
        counterText: "",
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        fillColor: widget.color,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        hintText: widget.hinttxt,
        hintStyle: Texttheme.hintstyle.copyWith(color: Colors.black54),
      ),
      validator: widget.valiadte,
    );
  }
}
