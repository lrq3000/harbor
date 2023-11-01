import 'package:harbor_flutter/protocol.pb.dart';

extension ClaimFieldListToString on List<ClaimFieldEntry> {
  String toClaimFieldsString() {
    return map((f) => "${f.value} (${f.key})").join(", ");
  }
}
