import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateArrowButton extends StatelessWidget {
  UpdateArrowButton({Key? key, required this.onpress}) : super(key: key);
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Image.asset(
        "images/update.png",
        width: w * 0.4,
        height: h * 0.1,
      ),
      onTap: onpress,
    );
  }
}
