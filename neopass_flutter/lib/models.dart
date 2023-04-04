import 'package:fixnum/fixnum.dart' as FixNum;

class ContentType {
  static final ContentTypeDelete = new FixNum.Int64(1);
  static final ContentTypeUsername = new FixNum.Int64(5);
  static final ContentTypeDescription = new FixNum.Int64(6);
  static final ContentTypeBlobMeta = new FixNum.Int64(7);
  static final ContentTypeBlobSection = new FixNum.Int64(8);
  static final ContentTypeAvatar = new FixNum.Int64(9);
  static final ContentTypeClaim = new FixNum.Int64(12);
  static final ContentTypeVouch = new FixNum.Int64(13);
}
