//
//  Generated code. Do not modify.
//  source: protocol.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class LWWElementSet_Operation extends $pb.ProtobufEnum {
  static const LWWElementSet_Operation ADD = LWWElementSet_Operation._(0, _omitEnumNames ? '' : 'ADD');
  static const LWWElementSet_Operation REMOVE = LWWElementSet_Operation._(1, _omitEnumNames ? '' : 'REMOVE');

  static const $core.List<LWWElementSet_Operation> values = <LWWElementSet_Operation> [
    ADD,
    REMOVE,
  ];

  static final $core.Map<$core.int, LWWElementSet_Operation> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LWWElementSet_Operation? valueOf($core.int value) => _byValue[value];

  const LWWElementSet_Operation._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
