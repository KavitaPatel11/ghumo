import 'package:flutter/material.dart';
import 'package:ghumo_24/components/dynamic_cart.dart';

class CounterButton extends StatefulWidget {
  CounterButton({Key? key}) : super(key: key);

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int numvalue = 1;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Row(
      children: [
        GestureDetector(
          child: Image.asset(
            "images/minus.png",
            width: w * 0.1,
            height: h * 0.1,
          ),
          onTap: () {
            setState(() {
              numvalue > 1 ? numvalue -= 1 : numvalue = 1;
            });
          },
        ),
        SizedBox(
          width: w * 0.03,
        ),
        Container(
            width: w * 0.13,
            height: h * 0.045,
            decoration: BoxDecoration(
              border: (Border.all(
                  width: 1.0, color: Color.fromARGB(255, 173, 166, 166))),
              borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                numvalue.toString(),
                style: TextStyle(fontSize: 18.0),
              ),
            )),
        SizedBox(
          width: w * 0.03,
        ),
        GestureDetector(
          child: Image.asset(
            "images/plus.png",
            width: w * 0.1,
            height: h * 0.1,
          ),
          onTap: () {
            setState(() {
              numvalue = numvalue + 1;
            });
          },
        ),
      ],
    );
  }
}
