import 'package:brick_lib/model/brick_part.dart';
import 'package:collection/collection.dart';


class PartGroup {
  PartGroup();

  List<BrickPart> parts = [];

  addPart(BrickPart part) {
    final foundPart = parts.firstWhereOrNull((e) => e.color == part.color);
    if (foundPart != null) {
      foundPart.quantity += part.quantity;
    } else {
      parts.add(part);
    }
  }

  bool get noMapping => parts.isNotEmpty ? parts.first.noMapping : false;

  String get partName => parts.isNotEmpty ? (parts.first.name ?? parts.first.part) : "-";

  String get partNum => parts.isNotEmpty ? parts.first.part : "-";

  String get imgUrl => parts.isNotEmpty ? (parts.first.details?.imgUrl ?? "") : "";

  int get quantity => parts.isNotEmpty
      ? parts.map((e) => e.quantity).reduce((value, element) => value + element)
      : 0;
}
