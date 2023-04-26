library ranges;

import 'package:fixnum/fixnum.dart' as fixnum;

class Range {
  Range({required this.low, required this.high});

  fixnum.Int64 low;
  fixnum.Int64 high;

  @override
  int get hashCode => Object.hash(low, high);

  @override
  bool operator ==(Object other) {
    if (other is! Range) {
      return false;
    }
    return low == other.low && high == other.high;
  }
}

void insert(List<Range> ranges, fixnum.Int64 item) {
  for (var i = 0; i < ranges.length; i++) {
    // within existing range
    if (item >= ranges[i].low && item <= ranges[i].high) {
      return;
    }

    // merging range
    if (i < (ranges.length - 1) &&
        item == (ranges[i].high + 1) &&
        item == (ranges[i + 1].low - 1)) {
      ranges[i].high = ranges[i + 1].high;
      ranges.removeAt(i + 1);
      return;
    }

    //low adjacent
    if (item == (ranges[i].low - 1)) {
      ranges[i].low = item;
      return;
    }

    // high adjacent
    if (item == (ranges[i].high + 1)) {
      ranges[i].high = item;
      return;
    }

    if (item > ranges[i].high &&
        i < (ranges.length - 1) &&
        item < ranges[i + 1].low) {
      ranges.insert(i + 1, Range(low: item, high: item));
      return;
    }
  }

  ranges.add(Range(low: item, high: item));
}

List<Range> subtractRange(List<Range> left, List<Range> right) {
  final List<Range> result = [];

  for (final range in left) {
    result.add(Range(low: range.low, high: range.high));
  }

  for (final range in right) {
    for (var i = result.length - 1; i >= 0; i--) {
      if (range.high < result[i].low || range.low > result[i].high) {
        continue;
      } else if (range.low <= result[i].low && range.high >= result[i].high) {
        result.removeAt(i);
      } else if (range.low <= result[i].low) {
        result[i].low = range.high + 1;
      } else if (range.high >= result[i].high) {
        result[i].high = range.low - 1;
      } else if (range.low > result[i].low && range.high < result[i].high) {
        final current = result[i];
        result.removeAt(i);
        result.add(Range(
          low: current.low,
          high: range.low - 1,
        ));
        result.add(Range(
          low: range.high + 1,
          high: current.high,
        ));
      } else {
        throw Exception("impossible");
      }
    }
  }

  return result;
}

List<Range> takeRangesMaxItems(List<Range> ranges, fixnum.Int64 limit) {
  if (limit == 0) {
    return [];
  }

  var sum = fixnum.Int64(0);
  final List<Range> result = [];

  for (final range in ranges) {
    final count = range.high - range.low + 1;

    final maxItems = limit - sum;

    if (count <= maxItems) {
      result.add(range);
      sum += count;
    } else {
      result.add(Range(high: range.low + maxItems, low: range.low));
      break;
    }
  }

  return result;
}
