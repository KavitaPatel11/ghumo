import 'package:flutter/material.dart';

class PolicyCard extends StatefulWidget {
  final String? title;

  final Widget content;
  final VoidCallback onPress;
   final bool showContent;

  PolicyCard({
    Key? key,
    required this.title,
    required this.content,
    required this.showContent,
    required this.onPress,
  }) : super(key: key);
  @override
  _PolicyCardState createState() => _PolicyCardState();
}

class _PolicyCardState extends State<PolicyCard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          // margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.title!,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14.0),
                ),
              ),
              IconButton(
                  onPressed: widget.onPress,
                  icon: Icon(widget.showContent
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down))
            ],
          )),
      widget.showContent
          ? Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(117, 175, 208, 221)),
              child: widget.content,
            )
          : Container()
    ]);
  }
}
