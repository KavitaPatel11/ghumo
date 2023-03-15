import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ApplyButton extends StatelessWidget {
  ApplyButton({Key? key, required this.onpress}) : super(key: key);
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Image.asset(
        "images/apply.png",
        width: w * 0.4,
        height: h * 0.1,
      ),
      onTap: onpress,
    );
  }
}
