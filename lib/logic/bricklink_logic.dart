import 'package:brick_lib/model/brick_part.dart';

class BricklinkLogic {
  String generateXml(List<BrickPart> parts) {
    String xml = "<INVENTORY>\n";

    for (var i = 0; i < parts.length; i++) {
      final item = parts[i];
      if (item.bricklinkId?.isEmpty == true) continue;
      xml += "\t<ITEM>\n";

      xml += "\t\t<ITEMTYPE>P</ITEMTYPE>\n";
      xml += "\t\t<ITEMID>${item.bricklinkId ?? item.part}</ITEMID>\n";
      xml += "\t\t<COLOR>${item.bricklinkColor}</COLOR>\n";
      xml += "\t\t<MINQTY>${item.quantity}</MINQTY>\n";

      xml += "\t</ITEM>\n";
    }

    xml += "</INVENTORY>";

    return xml;
  }
}
