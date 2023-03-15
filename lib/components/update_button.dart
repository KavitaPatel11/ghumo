import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateButton extends StatelessWidget {
  UpdateButton({Key? key, required this.onpress}) : super(key: key);
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Image.asset(
        "images/ub2.png",
        width: w * 0.45,
        height: h * 0.12,
      ),
      onTap: onpress,
    );
  }
}
