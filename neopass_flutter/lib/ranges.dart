library ranges;

import 'package:fixnum/fixnum.dart' as FixNum;

class Range {
  Range({required this.low, required this.high});

  FixNum.Int64 low;
  FixNum.Int64 high;

  bool operator ==(Object other) {
    if (other is! Range) {
      return false;
    }
    return this.low == other.low && this.high == other.high;
  }
}

void insert(List<Range> ranges, FixNum.Int64 item) {
  for(var i = 0; i < ranges.length; i++) {
    // within existing range
    if (
      item >= ranges[i].low &&
      item <= ranges[i].high
    ) {
      return;
    }

    // merging range
    if (
      i < (ranges.length - 1) &&
      item == (ranges[i].high + 1) &&
      item == (ranges[i + 1].low - 1)
    ) {
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

    if (
      item > ranges[i].high &&
      i < (ranges.length - 1) &&
      item < ranges[i + 1].low
    ) {
      ranges.insert(i + 1, Range(low: item, high: item));
      return;
    }
  }

  ranges.add(Range(low: item, high: item));
}
