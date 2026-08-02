import 'package:brick_lib/request/GetSetAlternates.dart';
import 'package:flutter_test/flutter_test.dart';

/// Hits the live catalogue endpoint (API key only, no user token) to pin the
/// alternates contract: Rebrickable returns the MOC id in a `set_num` field,
/// which is easy to mistake for a real set number.
void main() {
  test('parses alternate builds for a set', () async {
    final result = await GetSetAlternates('75192-1', pageSize: 5).send();

    expect(result, isNotNull);
    expect(result!.items, isNotEmpty);

    final moc = result.items.first;
    expect(moc.setNum, startsWith('MOC-'));
    expect(moc.name, isNotEmpty);
    expect(moc.numParts, greaterThan(0));
    expect(moc.mocUrl, contains('rebrickable.com/mocs/'));
  }, timeout: const Timeout(Duration(minutes: 1)));
}
