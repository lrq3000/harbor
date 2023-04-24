///
//  Generated code. Do not modify.
//  source: protocol.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'protocol.pbenum.dart';

export 'protocol.pbenum.dart';

class PublicKey extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PublicKey', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'keyType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  PublicKey._() : super();
  factory PublicKey({
    $fixnum.Int64? keyType,
    $core.List<$core.int>? key,
  }) {
    final _result = create();
    if (keyType != null) {
      _result.keyType = keyType;
    }
    if (key != null) {
      _result.key = key;
    }
    return _result;
  }
  factory PublicKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PublicKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PublicKey clone() => PublicKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PublicKey copyWith(void Function(PublicKey) updates) => super.copyWith((message) => updates(message as PublicKey)) as PublicKey; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PublicKey create() => PublicKey._();
  PublicKey createEmptyInstance() => create();
  static $pb.PbList<PublicKey> createRepeated() => $pb.PbList<PublicKey>();
  @$core.pragma('dart2js:noInline')
  static PublicKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicKey>(create);
  static PublicKey? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get keyType => $_getI64(0);
  @$pb.TagNumber(1)
  set keyType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKeyType() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get key => $_getN(1);
  @$pb.TagNumber(2)
  set key($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);
}

class Process extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Process', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'process', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Process._() : super();
  factory Process({
    $core.List<$core.int>? process,
  }) {
    final _result = create();
    if (process != null) {
      _result.process = process;
    }
    return _result;
  }
  factory Process.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Process.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Process clone() => Process()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Process copyWith(void Function(Process) updates) => super.copyWith((message) => updates(message as Process)) as Process; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Process create() => Process._();
  Process createEmptyInstance() => create();
  static $pb.PbList<Process> createRepeated() => $pb.PbList<Process>();
  @$core.pragma('dart2js:noInline')
  static Process getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Process>(create);
  static Process? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get process => $_getN(0);
  @$pb.TagNumber(1)
  set process($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProcess() => $_has(0);
  @$pb.TagNumber(1)
  void clearProcess() => clearField(1);
}

class Index extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Index', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'indexType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  Index._() : super();
  factory Index({
    $fixnum.Int64? indexType,
    $fixnum.Int64? logicalClock,
  }) {
    final _result = create();
    if (indexType != null) {
      _result.indexType = indexType;
    }
    if (logicalClock != null) {
      _result.logicalClock = logicalClock;
    }
    return _result;
  }
  factory Index.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Index.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Index clone() => Index()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Index copyWith(void Function(Index) updates) => super.copyWith((message) => updates(message as Index)) as Index; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Index create() => Index._();
  Index createEmptyInstance() => create();
  static $pb.PbList<Index> createRepeated() => $pb.PbList<Index>();
  @$core.pragma('dart2js:noInline')
  static Index getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Index>(create);
  static Index? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get indexType => $_getI64(0);
  @$pb.TagNumber(1)
  set indexType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIndexType() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndexType() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get logicalClock => $_getI64(1);
  @$pb.TagNumber(2)
  set logicalClock($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLogicalClock() => $_has(1);
  @$pb.TagNumber(2)
  void clearLogicalClock() => clearField(2);
}

class Indices extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Indices', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<Index>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'indices', $pb.PbFieldType.PM, subBuilder: Index.create)
    ..hasRequiredFields = false
  ;

  Indices._() : super();
  factory Indices({
    $core.Iterable<Index>? indices,
  }) {
    final _result = create();
    if (indices != null) {
      _result.indices.addAll(indices);
    }
    return _result;
  }
  factory Indices.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Indices.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Indices clone() => Indices()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Indices copyWith(void Function(Indices) updates) => super.copyWith((message) => updates(message as Indices)) as Indices; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Indices create() => Indices._();
  Indices createEmptyInstance() => create();
  static $pb.PbList<Indices> createRepeated() => $pb.PbList<Indices>();
  @$core.pragma('dart2js:noInline')
  static Indices getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Indices>(create);
  static Indices? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Index> get indices => $_getList(0);
}

class VectorClock extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VectorClock', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logicalClocks', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  VectorClock._() : super();
  factory VectorClock({
    $core.Iterable<$fixnum.Int64>? logicalClocks,
  }) {
    final _result = create();
    if (logicalClocks != null) {
      _result.logicalClocks.addAll(logicalClocks);
    }
    return _result;
  }
  factory VectorClock.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VectorClock.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VectorClock clone() => VectorClock()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VectorClock copyWith(void Function(VectorClock) updates) => super.copyWith((message) => updates(message as VectorClock)) as VectorClock; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VectorClock create() => VectorClock._();
  VectorClock createEmptyInstance() => create();
  static $pb.PbList<VectorClock> createRepeated() => $pb.PbList<VectorClock>();
  @$core.pragma('dart2js:noInline')
  static VectorClock getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VectorClock>(create);
  static VectorClock? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$fixnum.Int64> get logicalClocks => $_getList(0);
}

class SignedEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignedEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'event', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  SignedEvent._() : super();
  factory SignedEvent({
    $core.List<$core.int>? signature,
    $core.List<$core.int>? event,
  }) {
    final _result = create();
    if (signature != null) {
      _result.signature = signature;
    }
    if (event != null) {
      _result.event = event;
    }
    return _result;
  }
  factory SignedEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignedEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignedEvent clone() => SignedEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignedEvent copyWith(void Function(SignedEvent) updates) => super.copyWith((message) => updates(message as SignedEvent)) as SignedEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignedEvent create() => SignedEvent._();
  SignedEvent createEmptyInstance() => create();
  static $pb.PbList<SignedEvent> createRepeated() => $pb.PbList<SignedEvent>();
  @$core.pragma('dart2js:noInline')
  static SignedEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignedEvent>(create);
  static SignedEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get signature => $_getN(0);
  @$pb.TagNumber(1)
  set signature($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get event => $_getN(1);
  @$pb.TagNumber(2)
  set event($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEvent() => $_has(1);
  @$pb.TagNumber(2)
  void clearEvent() => clearField(2);
}

class LWWElementSet extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LWWElementSet', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..e<LWWElementSet_Operation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'operation', $pb.PbFieldType.OE, defaultOrMaker: LWWElementSet_Operation.ADD, valueOf: LWWElementSet_Operation.valueOf, enumValues: LWWElementSet_Operation.values)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unixMilliseconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  LWWElementSet._() : super();
  factory LWWElementSet({
    LWWElementSet_Operation? operation,
    $core.List<$core.int>? value,
    $fixnum.Int64? unixMilliseconds,
  }) {
    final _result = create();
    if (operation != null) {
      _result.operation = operation;
    }
    if (value != null) {
      _result.value = value;
    }
    if (unixMilliseconds != null) {
      _result.unixMilliseconds = unixMilliseconds;
    }
    return _result;
  }
  factory LWWElementSet.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LWWElementSet.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LWWElementSet clone() => LWWElementSet()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LWWElementSet copyWith(void Function(LWWElementSet) updates) => super.copyWith((message) => updates(message as LWWElementSet)) as LWWElementSet; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LWWElementSet create() => LWWElementSet._();
  LWWElementSet createEmptyInstance() => create();
  static $pb.PbList<LWWElementSet> createRepeated() => $pb.PbList<LWWElementSet>();
  @$core.pragma('dart2js:noInline')
  static LWWElementSet getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LWWElementSet>(create);
  static LWWElementSet? _defaultInstance;

  @$pb.TagNumber(1)
  LWWElementSet_Operation get operation => $_getN(0);
  @$pb.TagNumber(1)
  set operation(LWWElementSet_Operation v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOperation() => $_has(0);
  @$pb.TagNumber(1)
  void clearOperation() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get unixMilliseconds => $_getI64(2);
  @$pb.TagNumber(3)
  set unixMilliseconds($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnixMilliseconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnixMilliseconds() => clearField(3);
}

class LWWElement extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LWWElement', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unixMilliseconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  LWWElement._() : super();
  factory LWWElement({
    $core.List<$core.int>? value,
    $fixnum.Int64? unixMilliseconds,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (unixMilliseconds != null) {
      _result.unixMilliseconds = unixMilliseconds;
    }
    return _result;
  }
  factory LWWElement.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LWWElement.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LWWElement clone() => LWWElement()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LWWElement copyWith(void Function(LWWElement) updates) => super.copyWith((message) => updates(message as LWWElement)) as LWWElement; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LWWElement create() => LWWElement._();
  LWWElement createEmptyInstance() => create();
  static $pb.PbList<LWWElement> createRepeated() => $pb.PbList<LWWElement>();
  @$core.pragma('dart2js:noInline')
  static LWWElement getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LWWElement>(create);
  static LWWElement? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get unixMilliseconds => $_getI64(1);
  @$pb.TagNumber(2)
  set unixMilliseconds($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUnixMilliseconds() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnixMilliseconds() => clearField(2);
}

class Server extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Server', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'server')
    ..hasRequiredFields = false
  ;

  Server._() : super();
  factory Server({
    $core.String? server,
  }) {
    final _result = create();
    if (server != null) {
      _result.server = server;
    }
    return _result;
  }
  factory Server.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Server.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Server clone() => Server()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Server copyWith(void Function(Server) updates) => super.copyWith((message) => updates(message as Server)) as Server; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Server create() => Server._();
  Server createEmptyInstance() => create();
  static $pb.PbList<Server> createRepeated() => $pb.PbList<Server>();
  @$core.pragma('dart2js:noInline')
  static Server getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Server>(create);
  static Server? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get server => $_getSZ(0);
  @$pb.TagNumber(1)
  set server($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasServer() => $_has(0);
  @$pb.TagNumber(1)
  void clearServer() => clearField(1);
}

class BlobMeta extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlobMeta', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sectionCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mime')
    ..hasRequiredFields = false
  ;

  BlobMeta._() : super();
  factory BlobMeta({
    $fixnum.Int64? sectionCount,
    $core.String? mime,
  }) {
    final _result = create();
    if (sectionCount != null) {
      _result.sectionCount = sectionCount;
    }
    if (mime != null) {
      _result.mime = mime;
    }
    return _result;
  }
  factory BlobMeta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlobMeta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlobMeta clone() => BlobMeta()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlobMeta copyWith(void Function(BlobMeta) updates) => super.copyWith((message) => updates(message as BlobMeta)) as BlobMeta; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlobMeta create() => BlobMeta._();
  BlobMeta createEmptyInstance() => create();
  static $pb.PbList<BlobMeta> createRepeated() => $pb.PbList<BlobMeta>();
  @$core.pragma('dart2js:noInline')
  static BlobMeta getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlobMeta>(create);
  static BlobMeta? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get sectionCount => $_getI64(0);
  @$pb.TagNumber(1)
  set sectionCount($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSectionCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearSectionCount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get mime => $_getSZ(1);
  @$pb.TagNumber(2)
  set mime($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMime() => $_has(1);
  @$pb.TagNumber(2)
  void clearMime() => clearField(2);
}

class BlobSection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlobSection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metaPointer', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  BlobSection._() : super();
  factory BlobSection({
    $fixnum.Int64? metaPointer,
    $core.List<$core.int>? content,
  }) {
    final _result = create();
    if (metaPointer != null) {
      _result.metaPointer = metaPointer;
    }
    if (content != null) {
      _result.content = content;
    }
    return _result;
  }
  factory BlobSection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlobSection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlobSection clone() => BlobSection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlobSection copyWith(void Function(BlobSection) updates) => super.copyWith((message) => updates(message as BlobSection)) as BlobSection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlobSection create() => BlobSection._();
  BlobSection createEmptyInstance() => create();
  static $pb.PbList<BlobSection> createRepeated() => $pb.PbList<BlobSection>();
  @$core.pragma('dart2js:noInline')
  static BlobSection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlobSection>(create);
  static BlobSection? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get metaPointer => $_getI64(0);
  @$pb.TagNumber(1)
  set metaPointer($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMetaPointer() => $_has(0);
  @$pb.TagNumber(1)
  void clearMetaPointer() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get content => $_getN(1);
  @$pb.TagNumber(2)
  set content($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);
}

class Event extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Event', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<PublicKey>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'system', subBuilder: PublicKey.create)
    ..aOM<Process>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'process', subBuilder: Process.create)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content', $pb.PbFieldType.OY)
    ..aOM<VectorClock>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vectorClock', subBuilder: VectorClock.create)
    ..aOM<Indices>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'indices', subBuilder: Indices.create)
    ..aOM<LWWElementSet>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lwwElementSet', subBuilder: LWWElementSet.create)
    ..aOM<LWWElement>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lwwElement', subBuilder: LWWElement.create)
    ..pc<Reference>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'references', $pb.PbFieldType.PM, subBuilder: Reference.create)
    ..hasRequiredFields = false
  ;

  Event._() : super();
  factory Event({
    PublicKey? system,
    Process? process,
    $fixnum.Int64? logicalClock,
    $fixnum.Int64? contentType,
    $core.List<$core.int>? content,
    VectorClock? vectorClock,
    Indices? indices,
    LWWElementSet? lwwElementSet,
    LWWElement? lwwElement,
    $core.Iterable<Reference>? references,
  }) {
    final _result = create();
    if (system != null) {
      _result.system = system;
    }
    if (process != null) {
      _result.process = process;
    }
    if (logicalClock != null) {
      _result.logicalClock = logicalClock;
    }
    if (contentType != null) {
      _result.contentType = contentType;
    }
    if (content != null) {
      _result.content = content;
    }
    if (vectorClock != null) {
      _result.vectorClock = vectorClock;
    }
    if (indices != null) {
      _result.indices = indices;
    }
    if (lwwElementSet != null) {
      _result.lwwElementSet = lwwElementSet;
    }
    if (lwwElement != null) {
      _result.lwwElement = lwwElement;
    }
    if (references != null) {
      _result.references.addAll(references);
    }
    return _result;
  }
  factory Event.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Event.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Event clone() => Event()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Event copyWith(void Function(Event) updates) => super.copyWith((message) => updates(message as Event)) as Event; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  Event createEmptyInstance() => create();
  static $pb.PbList<Event> createRepeated() => $pb.PbList<Event>();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event? _defaultInstance;

  @$pb.TagNumber(1)
  PublicKey get system => $_getN(0);
  @$pb.TagNumber(1)
  set system(PublicKey v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSystem() => $_has(0);
  @$pb.TagNumber(1)
  void clearSystem() => clearField(1);
  @$pb.TagNumber(1)
  PublicKey ensureSystem() => $_ensure(0);

  @$pb.TagNumber(2)
  Process get process => $_getN(1);
  @$pb.TagNumber(2)
  set process(Process v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasProcess() => $_has(1);
  @$pb.TagNumber(2)
  void clearProcess() => clearField(2);
  @$pb.TagNumber(2)
  Process ensureProcess() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get logicalClock => $_getI64(2);
  @$pb.TagNumber(3)
  set logicalClock($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLogicalClock() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogicalClock() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get contentType => $_getI64(3);
  @$pb.TagNumber(4)
  set contentType($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearContentType() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get content => $_getN(4);
  @$pb.TagNumber(5)
  set content($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasContent() => $_has(4);
  @$pb.TagNumber(5)
  void clearContent() => clearField(5);

  @$pb.TagNumber(6)
  VectorClock get vectorClock => $_getN(5);
  @$pb.TagNumber(6)
  set vectorClock(VectorClock v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVectorClock() => $_has(5);
  @$pb.TagNumber(6)
  void clearVectorClock() => clearField(6);
  @$pb.TagNumber(6)
  VectorClock ensureVectorClock() => $_ensure(5);

  @$pb.TagNumber(7)
  Indices get indices => $_getN(6);
  @$pb.TagNumber(7)
  set indices(Indices v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasIndices() => $_has(6);
  @$pb.TagNumber(7)
  void clearIndices() => clearField(7);
  @$pb.TagNumber(7)
  Indices ensureIndices() => $_ensure(6);

  @$pb.TagNumber(8)
  LWWElementSet get lwwElementSet => $_getN(7);
  @$pb.TagNumber(8)
  set lwwElementSet(LWWElementSet v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLwwElementSet() => $_has(7);
  @$pb.TagNumber(8)
  void clearLwwElementSet() => clearField(8);
  @$pb.TagNumber(8)
  LWWElementSet ensureLwwElementSet() => $_ensure(7);

  @$pb.TagNumber(9)
  LWWElement get lwwElement => $_getN(8);
  @$pb.TagNumber(9)
  set lwwElement(LWWElement v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasLwwElement() => $_has(8);
  @$pb.TagNumber(9)
  void clearLwwElement() => clearField(9);
  @$pb.TagNumber(9)
  LWWElement ensureLwwElement() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.List<Reference> get references => $_getList(9);
}

class Digest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Digest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'digestType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'digest', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Digest._() : super();
  factory Digest({
    $fixnum.Int64? digestType,
    $core.List<$core.int>? digest,
  }) {
    final _result = create();
    if (digestType != null) {
      _result.digestType = digestType;
    }
    if (digest != null) {
      _result.digest = digest;
    }
    return _result;
  }
  factory Digest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Digest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Digest clone() => Digest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Digest copyWith(void Function(Digest) updates) => super.copyWith((message) => updates(message as Digest)) as Digest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Digest create() => Digest._();
  Digest createEmptyInstance() => create();
  static $pb.PbList<Digest> createRepeated() => $pb.PbList<Digest>();
  @$core.pragma('dart2js:noInline')
  static Digest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Digest>(create);
  static Digest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get digestType => $_getI64(0);
  @$pb.TagNumber(1)
  set digestType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDigestType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDigestType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get digest => $_getN(1);
  @$pb.TagNumber(2)
  set digest($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearDigest() => clearField(2);
}

class Pointer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Pointer', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<PublicKey>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'system', subBuilder: PublicKey.create)
    ..aOM<Process>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'process', subBuilder: Process.create)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<Digest>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'eventDigest', subBuilder: Digest.create)
    ..hasRequiredFields = false
  ;

  Pointer._() : super();
  factory Pointer({
    PublicKey? system,
    Process? process,
    $fixnum.Int64? logicalClock,
    Digest? eventDigest,
  }) {
    final _result = create();
    if (system != null) {
      _result.system = system;
    }
    if (process != null) {
      _result.process = process;
    }
    if (logicalClock != null) {
      _result.logicalClock = logicalClock;
    }
    if (eventDigest != null) {
      _result.eventDigest = eventDigest;
    }
    return _result;
  }
  factory Pointer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Pointer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Pointer clone() => Pointer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Pointer copyWith(void Function(Pointer) updates) => super.copyWith((message) => updates(message as Pointer)) as Pointer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Pointer create() => Pointer._();
  Pointer createEmptyInstance() => create();
  static $pb.PbList<Pointer> createRepeated() => $pb.PbList<Pointer>();
  @$core.pragma('dart2js:noInline')
  static Pointer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Pointer>(create);
  static Pointer? _defaultInstance;

  @$pb.TagNumber(1)
  PublicKey get system => $_getN(0);
  @$pb.TagNumber(1)
  set system(PublicKey v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSystem() => $_has(0);
  @$pb.TagNumber(1)
  void clearSystem() => clearField(1);
  @$pb.TagNumber(1)
  PublicKey ensureSystem() => $_ensure(0);

  @$pb.TagNumber(2)
  Process get process => $_getN(1);
  @$pb.TagNumber(2)
  set process(Process v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasProcess() => $_has(1);
  @$pb.TagNumber(2)
  void clearProcess() => clearField(2);
  @$pb.TagNumber(2)
  Process ensureProcess() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get logicalClock => $_getI64(2);
  @$pb.TagNumber(3)
  set logicalClock($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLogicalClock() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogicalClock() => clearField(3);

  @$pb.TagNumber(4)
  Digest get eventDigest => $_getN(3);
  @$pb.TagNumber(4)
  set eventDigest(Digest v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasEventDigest() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventDigest() => clearField(4);
  @$pb.TagNumber(4)
  Digest ensureEventDigest() => $_ensure(3);
}

class Delete extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Delete', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<Process>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'process', subBuilder: Process.create)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<Indices>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'indices', subBuilder: Indices.create)
    ..hasRequiredFields = false
  ;

  Delete._() : super();
  factory Delete({
    Process? process,
    $fixnum.Int64? logicalClock,
    Indices? indices,
  }) {
    final _result = create();
    if (process != null) {
      _result.process = process;
    }
    if (logicalClock != null) {
      _result.logicalClock = logicalClock;
    }
    if (indices != null) {
      _result.indices = indices;
    }
    return _result;
  }
  factory Delete.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Delete.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Delete clone() => Delete()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Delete copyWith(void Function(Delete) updates) => super.copyWith((message) => updates(message as Delete)) as Delete; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Delete create() => Delete._();
  Delete createEmptyInstance() => create();
  static $pb.PbList<Delete> createRepeated() => $pb.PbList<Delete>();
  @$core.pragma('dart2js:noInline')
  static Delete getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Delete>(create);
  static Delete? _defaultInstance;

  @$pb.TagNumber(1)
  Process get process => $_getN(0);
  @$pb.TagNumber(1)
  set process(Process v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProcess() => $_has(0);
  @$pb.TagNumber(1)
  void clearProcess() => clearField(1);
  @$pb.TagNumber(1)
  Process ensureProcess() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get logicalClock => $_getI64(1);
  @$pb.TagNumber(2)
  set logicalClock($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLogicalClock() => $_has(1);
  @$pb.TagNumber(2)
  void clearLogicalClock() => clearField(2);

  @$pb.TagNumber(3)
  Indices get indices => $_getN(2);
  @$pb.TagNumber(3)
  set indices(Indices v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasIndices() => $_has(2);
  @$pb.TagNumber(3)
  void clearIndices() => clearField(3);
  @$pb.TagNumber(3)
  Indices ensureIndices() => $_ensure(2);
}

class Events extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Events', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<SignedEvent>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'events', $pb.PbFieldType.PM, subBuilder: SignedEvent.create)
    ..hasRequiredFields = false
  ;

  Events._() : super();
  factory Events({
    $core.Iterable<SignedEvent>? events,
  }) {
    final _result = create();
    if (events != null) {
      _result.events.addAll(events);
    }
    return _result;
  }
  factory Events.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Events.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Events clone() => Events()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Events copyWith(void Function(Events) updates) => super.copyWith((message) => updates(message as Events)) as Events; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Events create() => Events._();
  Events createEmptyInstance() => create();
  static $pb.PbList<Events> createRepeated() => $pb.PbList<Events>();
  @$core.pragma('dart2js:noInline')
  static Events getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Events>(create);
  static Events? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SignedEvent> get events => $_getList(0);
}

class Range extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Range', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'low', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'high', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  Range._() : super();
  factory Range({
    $fixnum.Int64? low,
    $fixnum.Int64? high,
  }) {
    final _result = create();
    if (low != null) {
      _result.low = low;
    }
    if (high != null) {
      _result.high = high;
    }
    return _result;
  }
  factory Range.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Range.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Range clone() => Range()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Range copyWith(void Function(Range) updates) => super.copyWith((message) => updates(message as Range)) as Range; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Range create() => Range._();
  Range createEmptyInstance() => create();
  static $pb.PbList<Range> createRepeated() => $pb.PbList<Range>();
  @$core.pragma('dart2js:noInline')
  static Range getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Range>(create);
  static Range? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get low => $_getI64(0);
  @$pb.TagNumber(1)
  set low($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLow() => $_has(0);
  @$pb.TagNumber(1)
  void clearLow() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get high => $_getI64(1);
  @$pb.TagNumber(2)
  set high($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHigh() => $_has(1);
  @$pb.TagNumber(2)
  void clearHigh() => clearField(2);
}

class RangesForProcess extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RangesForProcess', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<Process>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'process', subBuilder: Process.create)
    ..pc<Range>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ranges', $pb.PbFieldType.PM, subBuilder: Range.create)
    ..hasRequiredFields = false
  ;

  RangesForProcess._() : super();
  factory RangesForProcess({
    Process? process,
    $core.Iterable<Range>? ranges,
  }) {
    final _result = create();
    if (process != null) {
      _result.process = process;
    }
    if (ranges != null) {
      _result.ranges.addAll(ranges);
    }
    return _result;
  }
  factory RangesForProcess.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RangesForProcess.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RangesForProcess clone() => RangesForProcess()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RangesForProcess copyWith(void Function(RangesForProcess) updates) => super.copyWith((message) => updates(message as RangesForProcess)) as RangesForProcess; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RangesForProcess create() => RangesForProcess._();
  RangesForProcess createEmptyInstance() => create();
  static $pb.PbList<RangesForProcess> createRepeated() => $pb.PbList<RangesForProcess>();
  @$core.pragma('dart2js:noInline')
  static RangesForProcess getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RangesForProcess>(create);
  static RangesForProcess? _defaultInstance;

  @$pb.TagNumber(1)
  Process get process => $_getN(0);
  @$pb.TagNumber(1)
  set process(Process v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProcess() => $_has(0);
  @$pb.TagNumber(1)
  void clearProcess() => clearField(1);
  @$pb.TagNumber(1)
  Process ensureProcess() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<Range> get ranges => $_getList(1);
}

class RangesForSystem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RangesForSystem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<RangesForProcess>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rangesForProcesses', $pb.PbFieldType.PM, subBuilder: RangesForProcess.create)
    ..hasRequiredFields = false
  ;

  RangesForSystem._() : super();
  factory RangesForSystem({
    $core.Iterable<RangesForProcess>? rangesForProcesses,
  }) {
    final _result = create();
    if (rangesForProcesses != null) {
      _result.rangesForProcesses.addAll(rangesForProcesses);
    }
    return _result;
  }
  factory RangesForSystem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RangesForSystem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RangesForSystem clone() => RangesForSystem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RangesForSystem copyWith(void Function(RangesForSystem) updates) => super.copyWith((message) => updates(message as RangesForSystem)) as RangesForSystem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RangesForSystem create() => RangesForSystem._();
  RangesForSystem createEmptyInstance() => create();
  static $pb.PbList<RangesForSystem> createRepeated() => $pb.PbList<RangesForSystem>();
  @$core.pragma('dart2js:noInline')
  static RangesForSystem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RangesForSystem>(create);
  static RangesForSystem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<RangesForProcess> get rangesForProcesses => $_getList(0);
}

class URLInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'URLInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<PublicKey>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'system', subBuilder: PublicKey.create)
    ..aOM<Process>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'process', subBuilder: Process.create)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'servers')
    ..hasRequiredFields = false
  ;

  URLInfo._() : super();
  factory URLInfo({
    PublicKey? system,
    Process? process,
    $fixnum.Int64? logicalClock,
    $core.Iterable<$core.String>? servers,
  }) {
    final _result = create();
    if (system != null) {
      _result.system = system;
    }
    if (process != null) {
      _result.process = process;
    }
    if (logicalClock != null) {
      _result.logicalClock = logicalClock;
    }
    if (servers != null) {
      _result.servers.addAll(servers);
    }
    return _result;
  }
  factory URLInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory URLInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  URLInfo clone() => URLInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  URLInfo copyWith(void Function(URLInfo) updates) => super.copyWith((message) => updates(message as URLInfo)) as URLInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static URLInfo create() => URLInfo._();
  URLInfo createEmptyInstance() => create();
  static $pb.PbList<URLInfo> createRepeated() => $pb.PbList<URLInfo>();
  @$core.pragma('dart2js:noInline')
  static URLInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<URLInfo>(create);
  static URLInfo? _defaultInstance;

  @$pb.TagNumber(1)
  PublicKey get system => $_getN(0);
  @$pb.TagNumber(1)
  set system(PublicKey v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSystem() => $_has(0);
  @$pb.TagNumber(1)
  void clearSystem() => clearField(1);
  @$pb.TagNumber(1)
  PublicKey ensureSystem() => $_ensure(0);

  @$pb.TagNumber(2)
  Process get process => $_getN(1);
  @$pb.TagNumber(2)
  set process(Process v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasProcess() => $_has(1);
  @$pb.TagNumber(2)
  void clearProcess() => clearField(2);
  @$pb.TagNumber(2)
  Process ensureProcess() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get logicalClock => $_getI64(2);
  @$pb.TagNumber(3)
  set logicalClock($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLogicalClock() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogicalClock() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get servers => $_getList(3);
}

class PrivateKey extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PrivateKey', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'keyType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  PrivateKey._() : super();
  factory PrivateKey({
    $fixnum.Int64? keyType,
    $core.List<$core.int>? key,
  }) {
    final _result = create();
    if (keyType != null) {
      _result.keyType = keyType;
    }
    if (key != null) {
      _result.key = key;
    }
    return _result;
  }
  factory PrivateKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PrivateKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PrivateKey clone() => PrivateKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PrivateKey copyWith(void Function(PrivateKey) updates) => super.copyWith((message) => updates(message as PrivateKey)) as PrivateKey; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PrivateKey create() => PrivateKey._();
  PrivateKey createEmptyInstance() => create();
  static $pb.PbList<PrivateKey> createRepeated() => $pb.PbList<PrivateKey>();
  @$core.pragma('dart2js:noInline')
  static PrivateKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PrivateKey>(create);
  static PrivateKey? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get keyType => $_getI64(0);
  @$pb.TagNumber(1)
  set keyType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKeyType() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get key => $_getN(1);
  @$pb.TagNumber(2)
  set key($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);
}

class KeyPair extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KeyPair', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'keyType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'privateKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicKey', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  KeyPair._() : super();
  factory KeyPair({
    $fixnum.Int64? keyType,
    $core.List<$core.int>? privateKey,
    $core.List<$core.int>? publicKey,
  }) {
    final _result = create();
    if (keyType != null) {
      _result.keyType = keyType;
    }
    if (privateKey != null) {
      _result.privateKey = privateKey;
    }
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    return _result;
  }
  factory KeyPair.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyPair.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyPair clone() => KeyPair()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyPair copyWith(void Function(KeyPair) updates) => super.copyWith((message) => updates(message as KeyPair)) as KeyPair; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KeyPair create() => KeyPair._();
  KeyPair createEmptyInstance() => create();
  static $pb.PbList<KeyPair> createRepeated() => $pb.PbList<KeyPair>();
  @$core.pragma('dart2js:noInline')
  static KeyPair getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KeyPair>(create);
  static KeyPair? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get keyType => $_getI64(0);
  @$pb.TagNumber(1)
  set keyType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKeyType() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get privateKey => $_getN(1);
  @$pb.TagNumber(2)
  set privateKey($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPrivateKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrivateKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get publicKey => $_getN(2);
  @$pb.TagNumber(3)
  set publicKey($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPublicKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearPublicKey() => clearField(3);
}

class ExportBundle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExportBundle', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<KeyPair>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'keyPair', subBuilder: KeyPair.create)
    ..aOM<Events>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'events', subBuilder: Events.create)
    ..hasRequiredFields = false
  ;

  ExportBundle._() : super();
  factory ExportBundle({
    KeyPair? keyPair,
    Events? events,
  }) {
    final _result = create();
    if (keyPair != null) {
      _result.keyPair = keyPair;
    }
    if (events != null) {
      _result.events = events;
    }
    return _result;
  }
  factory ExportBundle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportBundle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportBundle clone() => ExportBundle()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportBundle copyWith(void Function(ExportBundle) updates) => super.copyWith((message) => updates(message as ExportBundle)) as ExportBundle; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExportBundle create() => ExportBundle._();
  ExportBundle createEmptyInstance() => create();
  static $pb.PbList<ExportBundle> createRepeated() => $pb.PbList<ExportBundle>();
  @$core.pragma('dart2js:noInline')
  static ExportBundle getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportBundle>(create);
  static ExportBundle? _defaultInstance;

  @$pb.TagNumber(1)
  KeyPair get keyPair => $_getN(0);
  @$pb.TagNumber(1)
  set keyPair(KeyPair v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasKeyPair() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyPair() => clearField(1);
  @$pb.TagNumber(1)
  KeyPair ensureKeyPair() => $_ensure(0);

  @$pb.TagNumber(2)
  Events get events => $_getN(1);
  @$pb.TagNumber(2)
  set events(Events v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEvents() => $_has(1);
  @$pb.TagNumber(2)
  void clearEvents() => clearField(2);
  @$pb.TagNumber(2)
  Events ensureEvents() => $_ensure(1);
}

class ResultEventsAndRelatedEventsAndCursor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResultEventsAndRelatedEventsAndCursor', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<Events>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resultEvents', subBuilder: Events.create)
    ..aOM<Events>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'relatedEvents', subBuilder: Events.create)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cursor', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ResultEventsAndRelatedEventsAndCursor._() : super();
  factory ResultEventsAndRelatedEventsAndCursor({
    Events? resultEvents,
    Events? relatedEvents,
    $fixnum.Int64? cursor,
  }) {
    final _result = create();
    if (resultEvents != null) {
      _result.resultEvents = resultEvents;
    }
    if (relatedEvents != null) {
      _result.relatedEvents = relatedEvents;
    }
    if (cursor != null) {
      _result.cursor = cursor;
    }
    return _result;
  }
  factory ResultEventsAndRelatedEventsAndCursor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResultEventsAndRelatedEventsAndCursor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResultEventsAndRelatedEventsAndCursor clone() => ResultEventsAndRelatedEventsAndCursor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResultEventsAndRelatedEventsAndCursor copyWith(void Function(ResultEventsAndRelatedEventsAndCursor) updates) => super.copyWith((message) => updates(message as ResultEventsAndRelatedEventsAndCursor)) as ResultEventsAndRelatedEventsAndCursor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResultEventsAndRelatedEventsAndCursor create() => ResultEventsAndRelatedEventsAndCursor._();
  ResultEventsAndRelatedEventsAndCursor createEmptyInstance() => create();
  static $pb.PbList<ResultEventsAndRelatedEventsAndCursor> createRepeated() => $pb.PbList<ResultEventsAndRelatedEventsAndCursor>();
  @$core.pragma('dart2js:noInline')
  static ResultEventsAndRelatedEventsAndCursor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResultEventsAndRelatedEventsAndCursor>(create);
  static ResultEventsAndRelatedEventsAndCursor? _defaultInstance;

  @$pb.TagNumber(1)
  Events get resultEvents => $_getN(0);
  @$pb.TagNumber(1)
  set resultEvents(Events v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResultEvents() => $_has(0);
  @$pb.TagNumber(1)
  void clearResultEvents() => clearField(1);
  @$pb.TagNumber(1)
  Events ensureResultEvents() => $_ensure(0);

  @$pb.TagNumber(2)
  Events get relatedEvents => $_getN(1);
  @$pb.TagNumber(2)
  set relatedEvents(Events v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRelatedEvents() => $_has(1);
  @$pb.TagNumber(2)
  void clearRelatedEvents() => clearField(2);
  @$pb.TagNumber(2)
  Events ensureRelatedEvents() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get cursor => $_getI64(2);
  @$pb.TagNumber(3)
  set cursor($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => clearField(3);
}

class Reference extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Reference', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referenceType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Reference._() : super();
  factory Reference({
    $fixnum.Int64? referenceType,
    $core.List<$core.int>? reference,
  }) {
    final _result = create();
    if (referenceType != null) {
      _result.referenceType = referenceType;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    return _result;
  }
  factory Reference.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Reference.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Reference clone() => Reference()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Reference copyWith(void Function(Reference) updates) => super.copyWith((message) => updates(message as Reference)) as Reference; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Reference create() => Reference._();
  Reference createEmptyInstance() => create();
  static $pb.PbList<Reference> createRepeated() => $pb.PbList<Reference>();
  @$core.pragma('dart2js:noInline')
  static Reference getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Reference>(create);
  static Reference? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get referenceType => $_getI64(0);
  @$pb.TagNumber(1)
  set referenceType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReferenceType() => $_has(0);
  @$pb.TagNumber(1)
  void clearReferenceType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get reference => $_getN(1);
  @$pb.TagNumber(2)
  set reference($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => clearField(2);
}

class Post extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Post', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..aOM<Pointer>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'image', subBuilder: Pointer.create)
    ..aOM<Pointer>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'boost', subBuilder: Pointer.create)
    ..hasRequiredFields = false
  ;

  Post._() : super();
  factory Post({
    $core.String? content,
    Pointer? image,
    Pointer? boost,
  }) {
    final _result = create();
    if (content != null) {
      _result.content = content;
    }
    if (image != null) {
      _result.image = image;
    }
    if (boost != null) {
      _result.boost = boost;
    }
    return _result;
  }
  factory Post.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Post.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Post clone() => Post()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Post copyWith(void Function(Post) updates) => super.copyWith((message) => updates(message as Post)) as Post; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Post create() => Post._();
  Post createEmptyInstance() => create();
  static $pb.PbList<Post> createRepeated() => $pb.PbList<Post>();
  @$core.pragma('dart2js:noInline')
  static Post getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Post>(create);
  static Post? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);

  @$pb.TagNumber(2)
  Pointer get image => $_getN(1);
  @$pb.TagNumber(2)
  set image(Pointer v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasImage() => $_has(1);
  @$pb.TagNumber(2)
  void clearImage() => clearField(2);
  @$pb.TagNumber(2)
  Pointer ensureImage() => $_ensure(1);

  @$pb.TagNumber(3)
  Pointer get boost => $_getN(2);
  @$pb.TagNumber(3)
  set boost(Pointer v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBoost() => $_has(2);
  @$pb.TagNumber(3)
  void clearBoost() => clearField(3);
  @$pb.TagNumber(3)
  Pointer ensureBoost() => $_ensure(2);
}

class Claim extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Claim', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimType')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Claim._() : super();
  factory Claim({
    $core.String? claimType,
    $core.List<$core.int>? claim,
  }) {
    final _result = create();
    if (claimType != null) {
      _result.claimType = claimType;
    }
    if (claim != null) {
      _result.claim = claim;
    }
    return _result;
  }
  factory Claim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Claim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Claim clone() => Claim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Claim copyWith(void Function(Claim) updates) => super.copyWith((message) => updates(message as Claim)) as Claim; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Claim create() => Claim._();
  Claim createEmptyInstance() => create();
  static $pb.PbList<Claim> createRepeated() => $pb.PbList<Claim>();
  @$core.pragma('dart2js:noInline')
  static Claim getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Claim>(create);
  static Claim? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimType => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaimType() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get claim => $_getN(1);
  @$pb.TagNumber(2)
  set claim($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClaim() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaim() => clearField(2);
}

class ClaimIdentifier extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClaimIdentifier', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  ClaimIdentifier._() : super();
  factory ClaimIdentifier({
    $core.String? identifier,
  }) {
    final _result = create();
    if (identifier != null) {
      _result.identifier = identifier;
    }
    return _result;
  }
  factory ClaimIdentifier.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClaimIdentifier.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClaimIdentifier clone() => ClaimIdentifier()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClaimIdentifier copyWith(void Function(ClaimIdentifier) updates) => super.copyWith((message) => updates(message as ClaimIdentifier)) as ClaimIdentifier; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClaimIdentifier create() => ClaimIdentifier._();
  ClaimIdentifier createEmptyInstance() => create();
  static $pb.PbList<ClaimIdentifier> createRepeated() => $pb.PbList<ClaimIdentifier>();
  @$core.pragma('dart2js:noInline')
  static ClaimIdentifier getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClaimIdentifier>(create);
  static ClaimIdentifier? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get identifier => $_getSZ(0);
  @$pb.TagNumber(1)
  set identifier($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIdentifier() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdentifier() => clearField(1);
}

class ClaimOccupation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClaimOccupation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'organization')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'location')
    ..hasRequiredFields = false
  ;

  ClaimOccupation._() : super();
  factory ClaimOccupation({
    $core.String? organization,
    $core.String? role,
    $core.String? location,
  }) {
    final _result = create();
    if (organization != null) {
      _result.organization = organization;
    }
    if (role != null) {
      _result.role = role;
    }
    if (location != null) {
      _result.location = location;
    }
    return _result;
  }
  factory ClaimOccupation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClaimOccupation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClaimOccupation clone() => ClaimOccupation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClaimOccupation copyWith(void Function(ClaimOccupation) updates) => super.copyWith((message) => updates(message as ClaimOccupation)) as ClaimOccupation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClaimOccupation create() => ClaimOccupation._();
  ClaimOccupation createEmptyInstance() => create();
  static $pb.PbList<ClaimOccupation> createRepeated() => $pb.PbList<ClaimOccupation>();
  @$core.pragma('dart2js:noInline')
  static ClaimOccupation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClaimOccupation>(create);
  static ClaimOccupation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get organization => $_getSZ(0);
  @$pb.TagNumber(1)
  set organization($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrganization() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrganization() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get location => $_getSZ(2);
  @$pb.TagNumber(3)
  set location($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocation() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocation() => clearField(3);
}

class Vouch extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Vouch', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Vouch._() : super();
  factory Vouch() => create();
  factory Vouch.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Vouch.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Vouch clone() => Vouch()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Vouch copyWith(void Function(Vouch) updates) => super.copyWith((message) => updates(message as Vouch)) as Vouch; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Vouch create() => Vouch._();
  Vouch createEmptyInstance() => create();
  static $pb.PbList<Vouch> createRepeated() => $pb.PbList<Vouch>();
  @$core.pragma('dart2js:noInline')
  static Vouch getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Vouch>(create);
  static Vouch? _defaultInstance;
}

class StorageTypeProcessSecret extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StorageTypeProcessSecret', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<PrivateKey>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'system', subBuilder: PrivateKey.create)
    ..aOM<Process>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'process', subBuilder: Process.create)
    ..hasRequiredFields = false
  ;

  StorageTypeProcessSecret._() : super();
  factory StorageTypeProcessSecret({
    PrivateKey? system,
    Process? process,
  }) {
    final _result = create();
    if (system != null) {
      _result.system = system;
    }
    if (process != null) {
      _result.process = process;
    }
    return _result;
  }
  factory StorageTypeProcessSecret.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeProcessSecret.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeProcessSecret clone() => StorageTypeProcessSecret()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeProcessSecret copyWith(void Function(StorageTypeProcessSecret) updates) => super.copyWith((message) => updates(message as StorageTypeProcessSecret)) as StorageTypeProcessSecret; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StorageTypeProcessSecret create() => StorageTypeProcessSecret._();
  StorageTypeProcessSecret createEmptyInstance() => create();
  static $pb.PbList<StorageTypeProcessSecret> createRepeated() => $pb.PbList<StorageTypeProcessSecret>();
  @$core.pragma('dart2js:noInline')
  static StorageTypeProcessSecret getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StorageTypeProcessSecret>(create);
  static StorageTypeProcessSecret? _defaultInstance;

  @$pb.TagNumber(1)
  PrivateKey get system => $_getN(0);
  @$pb.TagNumber(1)
  set system(PrivateKey v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSystem() => $_has(0);
  @$pb.TagNumber(1)
  void clearSystem() => clearField(1);
  @$pb.TagNumber(1)
  PrivateKey ensureSystem() => $_ensure(0);

  @$pb.TagNumber(2)
  Process get process => $_getN(1);
  @$pb.TagNumber(2)
  set process(Process v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasProcess() => $_has(1);
  @$pb.TagNumber(2)
  void clearProcess() => clearField(2);
  @$pb.TagNumber(2)
  Process ensureProcess() => $_ensure(1);
}

class StorageTypeProcessState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StorageTypeProcessState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<Range>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ranges', $pb.PbFieldType.PM, subBuilder: Range.create)
    ..aOM<Indices>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'indices', subBuilder: Indices.create)
    ..hasRequiredFields = false
  ;

  StorageTypeProcessState._() : super();
  factory StorageTypeProcessState({
    $fixnum.Int64? logicalClock,
    $core.Iterable<Range>? ranges,
    Indices? indices,
  }) {
    final _result = create();
    if (logicalClock != null) {
      _result.logicalClock = logicalClock;
    }
    if (ranges != null) {
      _result.ranges.addAll(ranges);
    }
    if (indices != null) {
      _result.indices = indices;
    }
    return _result;
  }
  factory StorageTypeProcessState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeProcessState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeProcessState clone() => StorageTypeProcessState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeProcessState copyWith(void Function(StorageTypeProcessState) updates) => super.copyWith((message) => updates(message as StorageTypeProcessState)) as StorageTypeProcessState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StorageTypeProcessState create() => StorageTypeProcessState._();
  StorageTypeProcessState createEmptyInstance() => create();
  static $pb.PbList<StorageTypeProcessState> createRepeated() => $pb.PbList<StorageTypeProcessState>();
  @$core.pragma('dart2js:noInline')
  static StorageTypeProcessState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StorageTypeProcessState>(create);
  static StorageTypeProcessState? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get logicalClock => $_getI64(0);
  @$pb.TagNumber(1)
  set logicalClock($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLogicalClock() => $_has(0);
  @$pb.TagNumber(1)
  void clearLogicalClock() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Range> get ranges => $_getList(1);

  @$pb.TagNumber(3)
  Indices get indices => $_getN(2);
  @$pb.TagNumber(3)
  set indices(Indices v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasIndices() => $_has(2);
  @$pb.TagNumber(3)
  void clearIndices() => clearField(3);
  @$pb.TagNumber(3)
  Indices ensureIndices() => $_ensure(2);
}

class StorageTypeCRDTSetItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StorageTypeCRDTSetItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unixMilliseconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<LWWElementSet_Operation>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'operation', $pb.PbFieldType.OE, defaultOrMaker: LWWElementSet_Operation.ADD, valueOf: LWWElementSet_Operation.valueOf, enumValues: LWWElementSet_Operation.values)
    ..hasRequiredFields = false
  ;

  StorageTypeCRDTSetItem._() : super();
  factory StorageTypeCRDTSetItem({
    $fixnum.Int64? contentType,
    $core.List<$core.int>? value,
    $fixnum.Int64? unixMilliseconds,
    LWWElementSet_Operation? operation,
  }) {
    final _result = create();
    if (contentType != null) {
      _result.contentType = contentType;
    }
    if (value != null) {
      _result.value = value;
    }
    if (unixMilliseconds != null) {
      _result.unixMilliseconds = unixMilliseconds;
    }
    if (operation != null) {
      _result.operation = operation;
    }
    return _result;
  }
  factory StorageTypeCRDTSetItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeCRDTSetItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeCRDTSetItem clone() => StorageTypeCRDTSetItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeCRDTSetItem copyWith(void Function(StorageTypeCRDTSetItem) updates) => super.copyWith((message) => updates(message as StorageTypeCRDTSetItem)) as StorageTypeCRDTSetItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StorageTypeCRDTSetItem create() => StorageTypeCRDTSetItem._();
  StorageTypeCRDTSetItem createEmptyInstance() => create();
  static $pb.PbList<StorageTypeCRDTSetItem> createRepeated() => $pb.PbList<StorageTypeCRDTSetItem>();
  @$core.pragma('dart2js:noInline')
  static StorageTypeCRDTSetItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StorageTypeCRDTSetItem>(create);
  static StorageTypeCRDTSetItem? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get contentType => $_getI64(0);
  @$pb.TagNumber(1)
  set contentType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearContentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get unixMilliseconds => $_getI64(2);
  @$pb.TagNumber(3)
  set unixMilliseconds($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnixMilliseconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnixMilliseconds() => clearField(3);

  @$pb.TagNumber(4)
  LWWElementSet_Operation get operation => $_getN(3);
  @$pb.TagNumber(4)
  set operation(LWWElementSet_Operation v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOperation() => $_has(3);
  @$pb.TagNumber(4)
  void clearOperation() => clearField(4);
}

class StorageTypeCRDTItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StorageTypeCRDTItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unixMilliseconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  StorageTypeCRDTItem._() : super();
  factory StorageTypeCRDTItem({
    $fixnum.Int64? contentType,
    $core.List<$core.int>? value,
    $fixnum.Int64? unixMilliseconds,
  }) {
    final _result = create();
    if (contentType != null) {
      _result.contentType = contentType;
    }
    if (value != null) {
      _result.value = value;
    }
    if (unixMilliseconds != null) {
      _result.unixMilliseconds = unixMilliseconds;
    }
    return _result;
  }
  factory StorageTypeCRDTItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeCRDTItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeCRDTItem clone() => StorageTypeCRDTItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeCRDTItem copyWith(void Function(StorageTypeCRDTItem) updates) => super.copyWith((message) => updates(message as StorageTypeCRDTItem)) as StorageTypeCRDTItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StorageTypeCRDTItem create() => StorageTypeCRDTItem._();
  StorageTypeCRDTItem createEmptyInstance() => create();
  static $pb.PbList<StorageTypeCRDTItem> createRepeated() => $pb.PbList<StorageTypeCRDTItem>();
  @$core.pragma('dart2js:noInline')
  static StorageTypeCRDTItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StorageTypeCRDTItem>(create);
  static StorageTypeCRDTItem? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get contentType => $_getI64(0);
  @$pb.TagNumber(1)
  set contentType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearContentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get unixMilliseconds => $_getI64(2);
  @$pb.TagNumber(3)
  set unixMilliseconds($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnixMilliseconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnixMilliseconds() => clearField(3);
}

class StorageTypeSystemState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StorageTypeSystemState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<StorageTypeCRDTSetItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crdtSetItems', $pb.PbFieldType.PM, subBuilder: StorageTypeCRDTSetItem.create)
    ..pc<Process>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'processes', $pb.PbFieldType.PM, subBuilder: Process.create)
    ..pc<StorageTypeCRDTItem>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crdtItems', $pb.PbFieldType.PM, subBuilder: StorageTypeCRDTItem.create)
    ..hasRequiredFields = false
  ;

  StorageTypeSystemState._() : super();
  factory StorageTypeSystemState({
    $core.Iterable<StorageTypeCRDTSetItem>? crdtSetItems,
    $core.Iterable<Process>? processes,
    $core.Iterable<StorageTypeCRDTItem>? crdtItems,
  }) {
    final _result = create();
    if (crdtSetItems != null) {
      _result.crdtSetItems.addAll(crdtSetItems);
    }
    if (processes != null) {
      _result.processes.addAll(processes);
    }
    if (crdtItems != null) {
      _result.crdtItems.addAll(crdtItems);
    }
    return _result;
  }
  factory StorageTypeSystemState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeSystemState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeSystemState clone() => StorageTypeSystemState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeSystemState copyWith(void Function(StorageTypeSystemState) updates) => super.copyWith((message) => updates(message as StorageTypeSystemState)) as StorageTypeSystemState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StorageTypeSystemState create() => StorageTypeSystemState._();
  StorageTypeSystemState createEmptyInstance() => create();
  static $pb.PbList<StorageTypeSystemState> createRepeated() => $pb.PbList<StorageTypeSystemState>();
  @$core.pragma('dart2js:noInline')
  static StorageTypeSystemState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StorageTypeSystemState>(create);
  static StorageTypeSystemState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<StorageTypeCRDTSetItem> get crdtSetItems => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Process> get processes => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<StorageTypeCRDTItem> get crdtItems => $_getList(2);
}

class StorageTypeEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StorageTypeEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<SignedEvent>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'event', subBuilder: SignedEvent.create)
    ..aOM<Pointer>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mutationPointer', subBuilder: Pointer.create)
    ..hasRequiredFields = false
  ;

  StorageTypeEvent._() : super();
  factory StorageTypeEvent({
    SignedEvent? event,
    Pointer? mutationPointer,
  }) {
    final _result = create();
    if (event != null) {
      _result.event = event;
    }
    if (mutationPointer != null) {
      _result.mutationPointer = mutationPointer;
    }
    return _result;
  }
  factory StorageTypeEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeEvent clone() => StorageTypeEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeEvent copyWith(void Function(StorageTypeEvent) updates) => super.copyWith((message) => updates(message as StorageTypeEvent)) as StorageTypeEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StorageTypeEvent create() => StorageTypeEvent._();
  StorageTypeEvent createEmptyInstance() => create();
  static $pb.PbList<StorageTypeEvent> createRepeated() => $pb.PbList<StorageTypeEvent>();
  @$core.pragma('dart2js:noInline')
  static StorageTypeEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StorageTypeEvent>(create);
  static StorageTypeEvent? _defaultInstance;

  @$pb.TagNumber(1)
  SignedEvent get event => $_getN(0);
  @$pb.TagNumber(1)
  set event(SignedEvent v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => clearField(1);
  @$pb.TagNumber(1)
  SignedEvent ensureEvent() => $_ensure(0);

  @$pb.TagNumber(2)
  Pointer get mutationPointer => $_getN(1);
  @$pb.TagNumber(2)
  set mutationPointer(Pointer v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMutationPointer() => $_has(1);
  @$pb.TagNumber(2)
  void clearMutationPointer() => clearField(2);
  @$pb.TagNumber(2)
  Pointer ensureMutationPointer() => $_ensure(1);
}

class RepeatedUInt64 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RepeatedUInt64', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'userpackage'), createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'numbers', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  RepeatedUInt64._() : super();
  factory RepeatedUInt64({
    $core.Iterable<$fixnum.Int64>? numbers,
  }) {
    final _result = create();
    if (numbers != null) {
      _result.numbers.addAll(numbers);
    }
    return _result;
  }
  factory RepeatedUInt64.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepeatedUInt64.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepeatedUInt64 clone() => RepeatedUInt64()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepeatedUInt64 copyWith(void Function(RepeatedUInt64) updates) => super.copyWith((message) => updates(message as RepeatedUInt64)) as RepeatedUInt64; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RepeatedUInt64 create() => RepeatedUInt64._();
  RepeatedUInt64 createEmptyInstance() => create();
  static $pb.PbList<RepeatedUInt64> createRepeated() => $pb.PbList<RepeatedUInt64>();
  @$core.pragma('dart2js:noInline')
  static RepeatedUInt64 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepeatedUInt64>(create);
  static RepeatedUInt64? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$fixnum.Int64> get numbers => $_getList(0);
}

