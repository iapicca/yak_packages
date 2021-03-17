import 'package:archivist/archivist.dart';
import 'package:test/test.dart';

const key = 'foo';
const wrongKey = 'bar';
const value = 1;
final archive = Archive.stach({'foo': 1});

void main() {
  group('Archive', () {
    test(
        'GIVEN `Archive.stach(map)`'
        'WHEN map contains `key`'
        'THEN archive[key] return value', () {
      expect(
        archive[key],
        value,
        reason: 'archive[key] should return value',
      );
    });
    test(
        'GIVEN `Archive.stach(map)`'
        'WHEN map !contains `key`'
        'THEN archive[key] return null', () {
      expect(
        archive[wrongKey],
        null,
        reason: 'archive[wrongKey] should return null',
      );
    });
  });
}
