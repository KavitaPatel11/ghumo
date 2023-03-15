import 'package:flutter/material.dart';
import 'package:ghumo_24/utills/colors.dart';
import 'package:ghumo_24/utills/textthem.dart';

class AccordionCardThree extends StatefulWidget {
  final String? title;
 
  final Widget? image;
  final Widget content;
  final VoidCallback? onpress;
  bool showContent;

  AccordionCardThree(
      {Key? key,
      required this.title,
      required this.content,
      required this.showContent,
      this.image,
      this.onpress,
      })
      : super(key: key);
  @override
  _AccordionCardThreeState createState() => _AccordionCardThreeState();
}

class _AccordionCardThreeState extends State<AccordionCardThree> {
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
        
          title: Text(widget.title!,
              style: Texttheme.subheading.copyWith(color: Colors.black45)),
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
              margin: const EdgeInsets.only(top: 0),
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,),
              child: widget.content,
            )
          : Container()
    ]);
  }
}
