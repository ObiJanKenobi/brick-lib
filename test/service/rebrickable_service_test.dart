import 'package:brick_lib/service/rebrickable_service.dart';
import 'package:flutter_test/flutter_test.dart';

const USER = "obijankenobi";
const PASSWORD = "Rebrickable@121";
const PART = "3005"; // 1x1 Brick
const PART_2 = "3004"; // 1x2 Brick
const PART_NAME = "Brick 1 x 1";
const PART_NAME_2 = "Brick 1 x 2";

const USER_TOKEN = "744667e2a7272f0765fcc6031c0850dfa8ec2e91700eb48f8f7c9ad226572e89";

void main() {
  test('Should get token', () async {
    final service = RebrickableService();

    final token = await service.login(USER, PASSWORD);

    expect(token, isNotNull);
  });
  test('Should get part detail', () async {
    final service = RebrickableService();

    final part = await service.getPartDetail(PART);

    expect(part?.partNum, PART);
    expect(part?.name, PART_NAME);
  });
  test('Should get part detail from list', () async {
    final service = RebrickableService();

    final part = await service.getPartsDetail([PART, PART_2]);

    expect(part, isList);
    expect(part, isNotEmpty);
  });
  test('Should get part categories', () async {
    final service = RebrickableService();

    final categories = await service.getPartCategories();

    expect(categories, isList);
    expect(categories, isNotEmpty);
  });
  test('Should get user part lists', () async {
    final service = RebrickableService();

    final part = await service.getUserPartLists();

    expect(part, isList);
    expect(part, isNotEmpty);
  });
  test('Should get colors', () async {
    final service = RebrickableService();

    final part = await service.getColors();

    expect(part, isList);
    expect(part, isNotEmpty);
  });
}
