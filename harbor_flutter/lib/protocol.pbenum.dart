///
//  Generated code. Do not modify.
//  source: protocol.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class LWWElementSet_Operation extends $pb.ProtobufEnum {
  static const LWWElementSet_Operation ADD = LWWElementSet_Operation._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ADD');
  static const LWWElementSet_Operation REMOVE = LWWElementSet_Operation._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REMOVE');

  static const $core.List<LWWElementSet_Operation> values = <LWWElementSet_Operation> [
    ADD,
    REMOVE,
  ];

  static final $core.Map<$core.int, LWWElementSet_Operation> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LWWElementSet_Operation? valueOf($core.int value) => _byValue[value];

  const LWWElementSet_Operation._($core.int v, $core.String n) : super(v, n);
}

