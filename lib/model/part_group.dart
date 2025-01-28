import 'package:brick_lib/model/brick_part.dart';
import 'package:collection/collection.dart';

class PartGroup<T extends BrickPart> {
  PartGroup();

  List<T> parts = [];

  addPart(T part) {
    final foundPart = parts.firstWhereOrNull((e) => e.color == part.color);
    if (foundPart != null && foundPart.quantity != null) {
      foundPart.quantity = (foundPart.quantity)! + (part.quantity ?? 0);
    } else {
      parts.add(part);
    }
  }

  bool get noMapping => parts.isNotEmpty ? parts.first.noMapping : false;

  String get partName => parts.isNotEmpty && parts?.first?.name?.isNotEmpty == true ? (parts.first.name ?? parts.first.part!) : "-";

  String get partNum => parts.isNotEmpty && parts.first.part?.isNotEmpty == true ? parts.first.part! : "-";

  String get imgUrl => parts.isNotEmpty ? (parts.first.details?.imgUrl ?? "") : "";

  int get quantity => parts.isNotEmpty ? parts.map((e) => e.quantity ?? 0).reduce((value, element) => value + element) : 0;
}
