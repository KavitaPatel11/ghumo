import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ghumo_24/utills/colors.dart';
import 'package:ghumo_24/utills/textthem.dart';

class MenuCardTwoTwo extends StatelessWidget {
  final VoidCallback? onpress;
  final IconData icns;
  final String text;

  const MenuCardTwoTwo({super.key, this.onpress, required this.icns, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                // shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5.0,
                  ),
                ],
                color: AppColor.accentLightGrey,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.accentLightGrey)),
            child: InkWell(
              onTap: onpress,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Icon(icns,color: Colors.red,), Text("$text",style: Texttheme.heading2.copyWith(color: Colors.red),)],
              ),
            ),
          ),
        );
  }
}
