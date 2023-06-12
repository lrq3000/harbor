import 'package:test/test.dart';
import 'package:fixnum/fixnum.dart' as fixnum;

import 'package:harbor_flutter/ranges.dart' as ranges;

ranges.Range makeRange(int low, int high) {
  return ranges.Range(
    low: fixnum.Int64(low),
    high: fixnum.Int64(high),
  );
}

void main() {
  const List<ranges.Range> emptyranges = [];

  group("insert", () {
    test('singleton', () {
      final List<ranges.Range> actual = [];
      ranges.insert(actual, fixnum.Int64(5));
      expect(actual, [makeRange(5, 5)]);
    });

    test('sequential', () {
      final List<ranges.Range> actual = [];
      ranges.insert(actual, fixnum.Int64(5));
      ranges.insert(actual, fixnum.Int64(6));
      expect(actual, [makeRange(5, 6)]);
    });

    test('reverse', () {
      final List<ranges.Range> actual = [];
      ranges.insert(actual, fixnum.Int64(6));
      ranges.insert(actual, fixnum.Int64(5));
      expect(actual, [makeRange(5, 6)]);
    });

    test('merge', () {
      final List<ranges.Range> actual = [];
      ranges.insert(actual, fixnum.Int64(5));
      ranges.insert(actual, fixnum.Int64(7));
      ranges.insert(actual, fixnum.Int64(6));
      expect(actual, [makeRange(5, 7)]);
    });

    test('disconnected insert', () {
      final List<ranges.Range> actual = [];
      ranges.insert(actual, fixnum.Int64(1));
      ranges.insert(actual, fixnum.Int64(5));
      ranges.insert(actual, fixnum.Int64(3));
      expect(actual, [
        makeRange(1, 1),
        makeRange(3, 3),
        makeRange(5, 5),
      ]);
    });
  });

  group("subtractRange", () {
    test('both empty are empty', () {
      expect(ranges.subtractRange([], []), emptyranges);
    });

    test('left empty result empty', () {
      expect(ranges.subtractRange([], [makeRange(5, 10)]), emptyranges);
    });

    test('right empty is identity', () {
      expect(
        ranges.subtractRange([makeRange(5, 10)], []),
        [makeRange(5, 10)],
      );
    });

    test('right totally subtracts left', () {
      expect(
        ranges.subtractRange([makeRange(5, 10)], [makeRange(5, 10)]),
        emptyranges,
      );
    });

    test('right subtracts lower portion of left', () {
      expect(
        ranges.subtractRange([makeRange(5, 10)], [makeRange(3, 7)]),
        [makeRange(8, 10)],
      );
    });

    test('right subtracts higher portion of left', () {
      expect(
        ranges.subtractRange([makeRange(5, 10)], [makeRange(7, 15)]),
        [makeRange(5, 6)],
      );
    });

    test('right splits middle of left', () {
      expect(
        ranges.subtractRange([makeRange(1, 10)], [makeRange(3, 6)]),
        [makeRange(1, 2), makeRange(7, 10)],
      );
    });

    test('complex', () {
      expect(
        ranges.subtractRange(
            [makeRange(1, 10), makeRange(20, 30), makeRange(50, 50)],
            [makeRange(0, 5), makeRange(8, 12), makeRange(31, 60)]),
        [makeRange(6, 7), makeRange(20, 30)],
      );
    });
  });

  group("takeRangeMaxItems", () {
    test('empty returns empty', () {
      expect(ranges.takeRangesMaxItems([], fixnum.Int64(10)), emptyranges);
    });

    test('zero and non empty returns empty', () {
      expect(
        ranges.takeRangesMaxItems(
          [makeRange(51, 70)],
          fixnum.Int64(0),
        ),
        emptyranges,
      );
    });

    test('less than total truncates', () {
      expect(
        ranges.takeRangesMaxItems(
          [makeRange(5, 10), makeRange(12, 16), makeRange(20, 25)],
          fixnum.Int64(8),
        ),
        [makeRange(5, 10), makeRange(12, 14)],
      );
    });

    test('more than total uses all', () {
      expect(
        ranges.takeRangesMaxItems(
          [makeRange(5, 10), makeRange(12, 15), makeRange(20, 25)],
          fixnum.Int64(50),
        ),
        [makeRange(5, 10), makeRange(12, 15), makeRange(20, 25)],
      );
    });
  });
}
