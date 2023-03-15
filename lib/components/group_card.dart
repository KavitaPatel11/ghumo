import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghumo_24/utills/colors.dart';
import 'package:ghumo_24/utills/textthem.dart';

class GriupCard extends StatelessWidget {
  final String name;
  final String image;
  const GriupCard({Key? key, required this.name, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        height: 146,
        width: 143,
        decoration: BoxDecoration(
          color: AppColor.accentWhite,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 5  horizontally
                5.0, // Move to bottom 5 Vertically
              ),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) {
                return CircleAvatar(
                    radius: 40, backgroundImage: AssetImage("images/hotelimg.png"));
              },
              errorWidget: (context, url, error) {
                return CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("images/hotelimg.png"),
                );
              },
              imageBuilder: (context, image) {
                return CircleAvatar(
                  radius: 40,
                  backgroundImage: image,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                name,
                style: Texttheme.labletext,
              ),
            )
          ],
        ));
  }
}
