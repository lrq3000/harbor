import 'package:fixnum/fixnum.dart' as fixnum;

class ContentType {
  static final contentTypeDelete = fixnum.Int64(1);
  static final contentTypeUsername = fixnum.Int64(5);
  static final contentTypeDescription = fixnum.Int64(6);
  static final contentTypeBlobMeta = fixnum.Int64(7);
  static final contentTypeBlobSection = fixnum.Int64(8);
  static final contentTypeAvatar = fixnum.Int64(9);
  static final contentTypeServer = fixnum.Int64(10);
  static final contentTypeClaim = fixnum.Int64(12);
  static final contentTypeVouch = fixnum.Int64(13);
}
