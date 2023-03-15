import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ghumo_24/utills/colors.dart';
import 'package:ghumo_24/utills/textthem.dart';

class MenuCard extends StatelessWidget {
  final VoidCallback? onpress;

  const MenuCard({super.key, this.onpress});

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
                    color: Colors.blue.shade400,
                    blurRadius: 5.0,
                  ),
                ],
                color: AppColor.blueColor2,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.accentLightGrey)),
            child: InkWell(
              onTap: onpress,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Icon(Icons.done_all,color: Colors.black,), Text("View All Property",style: Texttheme.heading2,)],
              ),
            ),
          ),
        );
  }
}
