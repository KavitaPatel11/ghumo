// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDemo extends StatefulWidget {
  final XFile? image;
  final VoidCallback? onpress;

  ImagePickerDemo({
    Key? key,
     this.image,
  this.onpress,
  }) : super();

  @override
  State<ImagePickerDemo> createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Stack(
        children: [
          widget.image == null
              ? GestureDetector(
                  onTap: widget.onpress,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: w * 0.22,
                    height: h * 0.1,
                    decoration: BoxDecoration(
                      color: Color(0xff80707070),
                        border: Border.all(
                            color: const Color.fromARGB(0, 244, 67, 54),
                            width: 0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                        image: DecorationImage(
                            image: AssetImage("images/camera_img.png"),
                            fit: BoxFit.fill)),
                  ),
                )
              : GestureDetector(
                  onTap: widget.onpress,
                  child: Container(
                    width: w * 0.22,
                    height: h * 0.1,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(0, 244, 67, 54),
                            width: 0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                        image: DecorationImage(
                            image: FileImage(
                              File(widget.image!.path),
                            ),
                            fit: BoxFit.cover)),
                  ),
                ),
        ],
      ),
    );
  }
}
