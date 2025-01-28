import 'package:brick_lib/brick_lib.dart';
import 'package:brick_lib/model/part_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GroupColors extends StatelessWidget {
  final PartGroup group;
  final Function? onColorClick;

  const GroupColors(this.group, this.onColorClick, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sorted = <BrickPart>[];
    sorted.addAll(group.parts);
    sorted.sort((a, b) {
      if (a.quantity > b.quantity) {
        return -1;
      } else if (b.quantity > a.quantity) {
        return 1;
      }

      return 0;
    });

    return Row(
      children: sorted.map((e) {
        var hex = HexColor.fromHex(e.rgb!);
        return Expanded(
          child: GestureDetector(
            onTap: () {
              if (onColorClick != null) {
                onColorClick!(e);
              }
            },
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
          ),
        );
      }).toList(growable: false),
    );
  }
}
