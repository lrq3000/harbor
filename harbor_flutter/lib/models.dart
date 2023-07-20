import 'dart:convert';

import 'package:fixnum/fixnum.dart' as fixnum;

import 'protocol.pb.dart' as protocol;

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
  static final contentTypeBanner = fixnum.Int64(14);
  static final contentTypeStore = fixnum.Int64(15);
}

class URLInfoType {
  static final urlInfoTypeSystemLink = fixnum.Int64(1);
  static final urlInfoTypeEventLink = fixnum.Int64(2);
  static final urlInfoTypeExportBundle = fixnum.Int64(3);
}

protocol.ExportBundle urlInfoGetExportBundle(
  protocol.URLInfo proto,
) {
  if (!(proto.urlType == URLInfoType.urlInfoTypeExportBundle)) {
    throw "expected urlInfoTypeExportBundle";
  }

  return protocol.ExportBundle.fromBuffer(proto.body);
}

protocol.URLInfo urlInfoFromLink(String text) {
    const prefix = "polycentric://";

    if (!text.startsWith(prefix)) {
      throw const FormatException();
    }

    text = text.substring(prefix.length);

    while ((text.length % 4) != 0) {
      text = "$text=";
    }

    return protocol.URLInfo.fromBuffer(
      base64.decode(text),
    );
}

String urlInfoToLinkSuffix(protocol.URLInfo proto) {
  return base64Url.encode(proto.writeToBuffer());
}

String urlInfoToLink(protocol.URLInfo proto) {
  return "polycentric://${base64Url.encode(proto.writeToBuffer())}";
}
