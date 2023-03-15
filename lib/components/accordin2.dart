import 'package:flutter/material.dart';
import 'package:ghumo_24/utills/colors.dart';
import 'package:ghumo_24/utills/textthem.dart';

class AccordionCardTwo extends StatefulWidget {

  final String? subtitle;
  final Widget? image;
  final Widget content;
  final VoidCallback? onpress;
  bool showContent;

  AccordionCardTwo(
      {Key? key,

      required this.content,
      required this.showContent,
      this.image,
      this.onpress,
      required this.subtitle})
      : super(key: key);
  @override
  _AccordionCardTwoState createState() => _AccordionCardTwoState();
}

class _AccordionCardTwoState extends State<AccordionCardTwo> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        // margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          onTap: (){
             widget.onpress;
          },
          minLeadingWidth: 10,
          minVerticalPadding: 6,
          leading: widget.image,
          selectedTileColor: Colors.white,
          tileColor: Colors.white,
          
          title:Text(widget.subtitle!,
              style: Texttheme.labletext),
          trailing: InkWell(
            onTap:  widget.onpress,
            child: Icon(widget.showContent
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
          )
             
            
          
          ),
        ),
      
      widget.showContent
          ? Container(
              margin: const EdgeInsets.only(top: 5),
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(15),
                  color: Colors.white),
              child: widget.content,
            )
          : Container()
    ]);
  }
}
