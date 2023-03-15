import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CheckButton extends StatefulWidget {
  const CheckButton({Key? key}) : super(key: key);

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  var img1 = "images/yu.png";
  var img2 = "images/nu.png";
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    bool yes = false;
    bool no = false;

    return Row(
      children: [
        GestureDetector(
          child: Image.asset(
            img1,
            width: w * 0.2,
            height: h * 0.1,
          ),
          onTap: () {
            setState(() {
              yes = true;
              img1 = "images/ys.png";
              img2 = "images/nu.png";
            });
          },
        ),
        GestureDetector(
          child: Image.asset(
            img2,
            width: w * 0.2,
            height: h * 0.1,
          ),
          onTap: () {
            setState(() {
              no = true;
              img2 = "images/ns.png";
              img1 = "images/yu.png";
            });
          },
        ),
      ],
    );
  }
}
