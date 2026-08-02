import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class BuildMatch {
  BuildMatch({
    required this.setNum,
    this.matchPercent,
    this.partsOwned,
    this.partsTotal,
  });

  final String setNum;

  /// Rebrickable's "Build Match %" for the user's whole collection, or null if
  /// the response did not carry one.
  final double? matchPercent;
  final int? partsOwned;
  final int? partsTotal;

  bool get hasMatch => matchPercent != null;
}

/// How much of a set (or MOC - Rebrickable accepts MOC numbers as set_num in
/// several places) the user can build from their collection.
///
/// The response shape is parsed defensively: this endpoint is documented but its
/// exact field names are not, and an unknown shape should degrade to "no match
/// info" rather than throwing and killing the whole alternates list.
class GetBuildMatch extends Request<BuildMatch?> {
  @override
  String get path => '/users/$userToken/build/$setNum/';

  final String userToken;
  final String setNum;

  GetBuildMatch(this.userToken, this.setNum);

  @override
  BuildMatch? handleResponse(Response response) {
    final data = response.data;
    if (data is! Map) return BuildMatch(setNum: setNum);

    double? asDouble(Object? v) {
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v);
      return null;
    }

    int? asInt(Object? v) {
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v);
      return null;
    }

    return BuildMatch(
      setNum: setNum,
      matchPercent: asDouble(data['match_percent'] ?? data['pct_owned'] ?? data['build_match']),
      partsOwned: asInt(data['num_owned'] ?? data['parts_owned'] ?? data['owned']),
      partsTotal: asInt(data['num_parts'] ?? data['parts_total'] ?? data['total']),
    );
  }
}
