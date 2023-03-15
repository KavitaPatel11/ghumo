import 'package:flutter/material.dart';
import 'package:advance_expansion_tile/advance_expansion_tile.dart';

class ExpensionTile extends StatefulWidget {
  ExpensionTile({Key? key}) : super(key: key);

  @override
  State<ExpensionTile> createState() => _ExpensionTileState();
}

class _ExpensionTileState extends State<ExpensionTile> {
  final GlobalKey<AdvanceExpansionTileState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      width: w * 0.9,
      height: h * 0.2,
      child: AdvanceExpansionTile(
        key: _globalKey,
        title: const Text("Expansion Tile Title"),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Container(
              height: 50,
              color: Colors.green,
            ),
          ),
        ],
        onTap: () {},
      ),
    );
  }
}
