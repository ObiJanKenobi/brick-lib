import 'package:brick_lib/brick_lib.dart';
import 'package:brick_lib/model/part_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GroupColors extends StatelessWidget {
  final PartGroup group;

  const GroupColors(this.group, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: group.parts.map((e) {
        var hex = HexColor.fromHex(e.rgb);
        return Expanded(
          child: Container(
            alignment: Alignment.center,
            color: hex,
            child: Stack(
              children: <Widget>[
                // Stroked text as border.
                Text(
                  e.quantity.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.grey,
                  ),
                ),
                // Solid text as fill.
                Text(
                  e.quantity.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: hex == Colors.white ? Colors.black12 : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(growable: false),
    );
  }
}
