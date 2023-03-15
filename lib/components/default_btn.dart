import 'package:flutter/material.dart';

class DefaultBtn extends StatelessWidget {
  final String btntext;
  final VoidCallback onTab;
  final double width;
  const DefaultBtn(
      {super.key,
      required this.btntext,
      required this.onTab,
      required this.width});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: onTab,
        child: Container(
          height: h * 0.06,
          width: width,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              btntext,
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 218, 70, 12),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
