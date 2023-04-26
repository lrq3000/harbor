import 'package:test/test.dart';
import 'package:fixnum/fixnum.dart' as FixNum;

import 'package:neopass_flutter/ranges.dart' as Ranges;

Ranges.Range makeRange(int low, int high) {
  return Ranges.Range(
    low: FixNum.Int64(low),
    high: FixNum.Int64(high),
  );
}

void main() {
  group("insert", () {
    test('singleton', () {
      final List<Ranges.Range> ranges = [];
      Ranges.insert(ranges, FixNum.Int64(5));
      expect(ranges, [makeRange(5, 5)]);
    });

    test('sequential', () {
      final List<Ranges.Range> ranges = [];
      Ranges.insert(ranges, FixNum.Int64(5));
      Ranges.insert(ranges, FixNum.Int64(6));
      expect(ranges, [makeRange(5, 6)]);
    });

    test('reverse', () {
      final List<Ranges.Range> ranges = [];
      Ranges.insert(ranges, FixNum.Int64(6));
      Ranges.insert(ranges, FixNum.Int64(5));
      expect(ranges, [makeRange(5, 6)]);
    });

    test('merge', () {
      final List<Ranges.Range> ranges = [];
      Ranges.insert(ranges, FixNum.Int64(5));
      Ranges.insert(ranges, FixNum.Int64(7));
      Ranges.insert(ranges, FixNum.Int64(6));
      expect(ranges, [makeRange(5, 7)]);
    });

    test('disconnected insert', () {
      final List<Ranges.Range> ranges = [];
      Ranges.insert(ranges, FixNum.Int64(1));
      Ranges.insert(ranges, FixNum.Int64(5));
      Ranges.insert(ranges, FixNum.Int64(3));
      expect(ranges, [
        makeRange(1, 1),
        makeRange(3, 3),
        makeRange(5, 5),
      ]);
    });
  });

  group("takeRangeMaxItems", () {
    test('empty returns empty', () {
      expect(Ranges.takeRangesMaxItems([], FixNum.Int64(10)), []);
    });

    test('zero and non empty returns empty', () {
      expect(
        Ranges.takeRangesMaxItems(
          [makeRange(51, 70)],
          FixNum.Int64(0),
        ),
        [],
      );
    });

    test('less than total truncates', () {
      expect(
        Ranges.takeRangesMaxItems(
          [makeRange(5, 10), makeRange(12, 16), makeRange(20, 25)],
          FixNum.Int64(8),
        ),
        [makeRange(5, 10), makeRange(12, 14)],
      );
    });

    test('more than total uses all', () {
      expect(
        Ranges.takeRangesMaxItems(
          [makeRange(5, 10), makeRange(12, 15), makeRange(20, 25)],
          FixNum.Int64(50),
        ),
        [makeRange(5, 10), makeRange(12, 15), makeRange(20, 25)],
      );
    });
  });
}

