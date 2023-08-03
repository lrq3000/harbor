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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'protocol.pbenum.dart';

export 'protocol.pbenum.dart';

class PublicKey extends $pb.GeneratedMessage {
  factory PublicKey() => create();
  PublicKey._() : super();
  factory PublicKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PublicKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PublicKey', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'keyType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'key', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PublicKey clone() => PublicKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PublicKey copyWith(void Function(PublicKey) updates) => super.copyWith((message) => updates(message as PublicKey)) as PublicKey;

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
  factory Process() => create();
  Process._() : super();
  factory Process.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Process.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Process', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'process', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Process clone() => Process()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Process copyWith(void Function(Process) updates) => super.copyWith((message) => updates(message as Process)) as Process;

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
  factory Index() => create();
  Index._() : super();
  factory Index.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Index.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Index', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'indexType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Index clone() => Index()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Index copyWith(void Function(Index) updates) => super.copyWith((message) => updates(message as Index)) as Index;

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
  factory Indices() => create();
  Indices._() : super();
  factory Indices.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Indices.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Indices', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<Index>(1, _omitFieldNames ? '' : 'indices', $pb.PbFieldType.PM, subBuilder: Index.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Indices clone() => Indices()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Indices copyWith(void Function(Indices) updates) => super.copyWith((message) => updates(message as Indices)) as Indices;

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
  factory VectorClock() => create();
  VectorClock._() : super();
  factory VectorClock.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VectorClock.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VectorClock', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'logicalClocks', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VectorClock clone() => VectorClock()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VectorClock copyWith(void Function(VectorClock) updates) => super.copyWith((message) => updates(message as VectorClock)) as VectorClock;

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
  factory SignedEvent() => create();
  SignedEvent._() : super();
  factory SignedEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignedEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignedEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'event', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignedEvent clone() => SignedEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignedEvent copyWith(void Function(SignedEvent) updates) => super.copyWith((message) => updates(message as SignedEvent)) as SignedEvent;

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
  factory LWWElementSet() => create();
  LWWElementSet._() : super();
  factory LWWElementSet.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LWWElementSet.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LWWElementSet', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..e<LWWElementSet_Operation>(1, _omitFieldNames ? '' : 'operation', $pb.PbFieldType.OE, defaultOrMaker: LWWElementSet_Operation.ADD, valueOf: LWWElementSet_Operation.valueOf, enumValues: LWWElementSet_Operation.values)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'unixMilliseconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LWWElementSet clone() => LWWElementSet()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LWWElementSet copyWith(void Function(LWWElementSet) updates) => super.copyWith((message) => updates(message as LWWElementSet)) as LWWElementSet;

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
  factory LWWElement() => create();
  LWWElement._() : super();
  factory LWWElement.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LWWElement.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LWWElement', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'unixMilliseconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LWWElement clone() => LWWElement()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LWWElement copyWith(void Function(LWWElement) updates) => super.copyWith((message) => updates(message as LWWElement)) as LWWElement;

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
  factory Server() => create();
  Server._() : super();
  factory Server.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Server.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Server', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'server')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Server clone() => Server()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Server copyWith(void Function(Server) updates) => super.copyWith((message) => updates(message as Server)) as Server;

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
  factory BlobMeta() => create();
  BlobMeta._() : super();
  factory BlobMeta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlobMeta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BlobMeta', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'sectionCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'mime')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlobMeta clone() => BlobMeta()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlobMeta copyWith(void Function(BlobMeta) updates) => super.copyWith((message) => updates(message as BlobMeta)) as BlobMeta;

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
  factory BlobSection() => create();
  BlobSection._() : super();
  factory BlobSection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlobSection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BlobSection', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'content', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlobSection clone() => BlobSection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlobSection copyWith(void Function(BlobSection) updates) => super.copyWith((message) => updates(message as BlobSection)) as BlobSection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BlobSection create() => BlobSection._();
  BlobSection createEmptyInstance() => create();
  static $pb.PbList<BlobSection> createRepeated() => $pb.PbList<BlobSection>();
  @$core.pragma('dart2js:noInline')
  static BlobSection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlobSection>(create);
  static BlobSection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get content => $_getN(0);
  @$pb.TagNumber(1)
  set content($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);
}

class ImageManifest extends $pb.GeneratedMessage {
  factory ImageManifest() => create();
  ImageManifest._() : super();
  factory ImageManifest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageManifest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ImageManifest', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mime')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'byteCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<Process>(5, _omitFieldNames ? '' : 'process', subBuilder: Process.create)
    ..pc<Range>(6, _omitFieldNames ? '' : 'sections', $pb.PbFieldType.PM, subBuilder: Range.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageManifest clone() => ImageManifest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageManifest copyWith(void Function(ImageManifest) updates) => super.copyWith((message) => updates(message as ImageManifest)) as ImageManifest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImageManifest create() => ImageManifest._();
  ImageManifest createEmptyInstance() => create();
  static $pb.PbList<ImageManifest> createRepeated() => $pb.PbList<ImageManifest>();
  @$core.pragma('dart2js:noInline')
  static ImageManifest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageManifest>(create);
  static ImageManifest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mime => $_getSZ(0);
  @$pb.TagNumber(1)
  set mime($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMime() => $_has(0);
  @$pb.TagNumber(1)
  void clearMime() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get width => $_getI64(1);
  @$pb.TagNumber(2)
  set width($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWidth() => $_has(1);
  @$pb.TagNumber(2)
  void clearWidth() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get height => $_getI64(2);
  @$pb.TagNumber(3)
  set height($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeight() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get byteCount => $_getI64(3);
  @$pb.TagNumber(4)
  set byteCount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasByteCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearByteCount() => clearField(4);

  @$pb.TagNumber(5)
  Process get process => $_getN(4);
  @$pb.TagNumber(5)
  set process(Process v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasProcess() => $_has(4);
  @$pb.TagNumber(5)
  void clearProcess() => clearField(5);
  @$pb.TagNumber(5)
  Process ensureProcess() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.List<Range> get sections => $_getList(5);
}

class ImageBundle extends $pb.GeneratedMessage {
  factory ImageBundle() => create();
  ImageBundle._() : super();
  factory ImageBundle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageBundle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ImageBundle', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<ImageManifest>(1, _omitFieldNames ? '' : 'imageManifests', $pb.PbFieldType.PM, subBuilder: ImageManifest.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageBundle clone() => ImageBundle()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageBundle copyWith(void Function(ImageBundle) updates) => super.copyWith((message) => updates(message as ImageBundle)) as ImageBundle;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImageBundle create() => ImageBundle._();
  ImageBundle createEmptyInstance() => create();
  static $pb.PbList<ImageBundle> createRepeated() => $pb.PbList<ImageBundle>();
  @$core.pragma('dart2js:noInline')
  static ImageBundle getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageBundle>(create);
  static ImageBundle? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ImageManifest> get imageManifests => $_getList(0);
}

class Event extends $pb.GeneratedMessage {
  factory Event() => create();
  Event._() : super();
  factory Event.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Event.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Event', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<PublicKey>(1, _omitFieldNames ? '' : 'system', subBuilder: PublicKey.create)
    ..aOM<Process>(2, _omitFieldNames ? '' : 'process', subBuilder: Process.create)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'contentType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'content', $pb.PbFieldType.OY)
    ..aOM<VectorClock>(6, _omitFieldNames ? '' : 'vectorClock', subBuilder: VectorClock.create)
    ..aOM<Indices>(7, _omitFieldNames ? '' : 'indices', subBuilder: Indices.create)
    ..aOM<LWWElementSet>(8, _omitFieldNames ? '' : 'lwwElementSet', subBuilder: LWWElementSet.create)
    ..aOM<LWWElement>(9, _omitFieldNames ? '' : 'lwwElement', subBuilder: LWWElement.create)
    ..pc<Reference>(10, _omitFieldNames ? '' : 'references', $pb.PbFieldType.PM, subBuilder: Reference.create)
    ..a<$fixnum.Int64>(11, _omitFieldNames ? '' : 'unixMilliseconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Event clone() => Event()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Event copyWith(void Function(Event) updates) => super.copyWith((message) => updates(message as Event)) as Event;

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

  @$pb.TagNumber(11)
  $fixnum.Int64 get unixMilliseconds => $_getI64(10);
  @$pb.TagNumber(11)
  set unixMilliseconds($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasUnixMilliseconds() => $_has(10);
  @$pb.TagNumber(11)
  void clearUnixMilliseconds() => clearField(11);
}

class Digest extends $pb.GeneratedMessage {
  factory Digest() => create();
  Digest._() : super();
  factory Digest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Digest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Digest', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'digestType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'digest', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Digest clone() => Digest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Digest copyWith(void Function(Digest) updates) => super.copyWith((message) => updates(message as Digest)) as Digest;

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
  factory Pointer() => create();
  Pointer._() : super();
  factory Pointer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Pointer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Pointer', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<PublicKey>(1, _omitFieldNames ? '' : 'system', subBuilder: PublicKey.create)
    ..aOM<Process>(2, _omitFieldNames ? '' : 'process', subBuilder: Process.create)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<Digest>(4, _omitFieldNames ? '' : 'eventDigest', subBuilder: Digest.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Pointer clone() => Pointer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Pointer copyWith(void Function(Pointer) updates) => super.copyWith((message) => updates(message as Pointer)) as Pointer;

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
  factory Delete() => create();
  Delete._() : super();
  factory Delete.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Delete.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Delete', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<Process>(1, _omitFieldNames ? '' : 'process', subBuilder: Process.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<Indices>(3, _omitFieldNames ? '' : 'indices', subBuilder: Indices.create)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'unixMilliseconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'contentType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Delete clone() => Delete()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Delete copyWith(void Function(Delete) updates) => super.copyWith((message) => updates(message as Delete)) as Delete;

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

  @$pb.TagNumber(4)
  $fixnum.Int64 get unixMilliseconds => $_getI64(3);
  @$pb.TagNumber(4)
  set unixMilliseconds($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUnixMilliseconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnixMilliseconds() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get contentType => $_getI64(4);
  @$pb.TagNumber(5)
  set contentType($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasContentType() => $_has(4);
  @$pb.TagNumber(5)
  void clearContentType() => clearField(5);
}

class Events extends $pb.GeneratedMessage {
  factory Events() => create();
  Events._() : super();
  factory Events.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Events.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Events', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<SignedEvent>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM, subBuilder: SignedEvent.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Events clone() => Events()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Events copyWith(void Function(Events) updates) => super.copyWith((message) => updates(message as Events)) as Events;

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

class PublicKeys extends $pb.GeneratedMessage {
  factory PublicKeys() => create();
  PublicKeys._() : super();
  factory PublicKeys.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PublicKeys.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PublicKeys', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<PublicKey>(1, _omitFieldNames ? '' : 'systems', $pb.PbFieldType.PM, subBuilder: PublicKey.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PublicKeys clone() => PublicKeys()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PublicKeys copyWith(void Function(PublicKeys) updates) => super.copyWith((message) => updates(message as PublicKeys)) as PublicKeys;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublicKeys create() => PublicKeys._();
  PublicKeys createEmptyInstance() => create();
  static $pb.PbList<PublicKeys> createRepeated() => $pb.PbList<PublicKeys>();
  @$core.pragma('dart2js:noInline')
  static PublicKeys getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicKeys>(create);
  static PublicKeys? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PublicKey> get systems => $_getList(0);
}

class Range extends $pb.GeneratedMessage {
  factory Range() => create();
  Range._() : super();
  factory Range.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Range.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Range', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'low', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'high', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Range clone() => Range()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Range copyWith(void Function(Range) updates) => super.copyWith((message) => updates(message as Range)) as Range;

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
  factory RangesForProcess() => create();
  RangesForProcess._() : super();
  factory RangesForProcess.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RangesForProcess.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RangesForProcess', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<Process>(1, _omitFieldNames ? '' : 'process', subBuilder: Process.create)
    ..pc<Range>(2, _omitFieldNames ? '' : 'ranges', $pb.PbFieldType.PM, subBuilder: Range.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RangesForProcess clone() => RangesForProcess()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RangesForProcess copyWith(void Function(RangesForProcess) updates) => super.copyWith((message) => updates(message as RangesForProcess)) as RangesForProcess;

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
  factory RangesForSystem() => create();
  RangesForSystem._() : super();
  factory RangesForSystem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RangesForSystem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RangesForSystem', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<RangesForProcess>(1, _omitFieldNames ? '' : 'rangesForProcesses', $pb.PbFieldType.PM, subBuilder: RangesForProcess.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RangesForSystem clone() => RangesForSystem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RangesForSystem copyWith(void Function(RangesForSystem) updates) => super.copyWith((message) => updates(message as RangesForSystem)) as RangesForSystem;

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

class PrivateKey extends $pb.GeneratedMessage {
  factory PrivateKey() => create();
  PrivateKey._() : super();
  factory PrivateKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PrivateKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PrivateKey', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'keyType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'key', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PrivateKey clone() => PrivateKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PrivateKey copyWith(void Function(PrivateKey) updates) => super.copyWith((message) => updates(message as PrivateKey)) as PrivateKey;

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
  factory KeyPair() => create();
  KeyPair._() : super();
  factory KeyPair.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyPair.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'KeyPair', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'keyType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'privateKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'publicKey', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyPair clone() => KeyPair()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyPair copyWith(void Function(KeyPair) updates) => super.copyWith((message) => updates(message as KeyPair)) as KeyPair;

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
  factory ExportBundle() => create();
  ExportBundle._() : super();
  factory ExportBundle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportBundle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExportBundle', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<KeyPair>(1, _omitFieldNames ? '' : 'keyPair', subBuilder: KeyPair.create)
    ..aOM<Events>(2, _omitFieldNames ? '' : 'events', subBuilder: Events.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportBundle clone() => ExportBundle()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportBundle copyWith(void Function(ExportBundle) updates) => super.copyWith((message) => updates(message as ExportBundle)) as ExportBundle;

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
  factory ResultEventsAndRelatedEventsAndCursor() => create();
  ResultEventsAndRelatedEventsAndCursor._() : super();
  factory ResultEventsAndRelatedEventsAndCursor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResultEventsAndRelatedEventsAndCursor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResultEventsAndRelatedEventsAndCursor', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<Events>(1, _omitFieldNames ? '' : 'resultEvents', subBuilder: Events.create)
    ..aOM<Events>(2, _omitFieldNames ? '' : 'relatedEvents', subBuilder: Events.create)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'cursor', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResultEventsAndRelatedEventsAndCursor clone() => ResultEventsAndRelatedEventsAndCursor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResultEventsAndRelatedEventsAndCursor copyWith(void Function(ResultEventsAndRelatedEventsAndCursor) updates) => super.copyWith((message) => updates(message as ResultEventsAndRelatedEventsAndCursor)) as ResultEventsAndRelatedEventsAndCursor;

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
  $core.List<$core.int> get cursor => $_getN(2);
  @$pb.TagNumber(3)
  set cursor($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => clearField(3);
}

class Reference extends $pb.GeneratedMessage {
  factory Reference() => create();
  Reference._() : super();
  factory Reference.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Reference.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Reference', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'referenceType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'reference', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Reference clone() => Reference()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Reference copyWith(void Function(Reference) updates) => super.copyWith((message) => updates(message as Reference)) as Reference;

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
  factory Post() => create();
  Post._() : super();
  factory Post.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Post.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Post', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'content')
    ..aOM<Pointer>(2, _omitFieldNames ? '' : 'image', subBuilder: Pointer.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Post clone() => Post()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Post copyWith(void Function(Post) updates) => super.copyWith((message) => updates(message as Post)) as Post;

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
}

class Claim extends $pb.GeneratedMessage {
  factory Claim() => create();
  Claim._() : super();
  factory Claim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Claim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Claim', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'claimType')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'claim', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Claim clone() => Claim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Claim copyWith(void Function(Claim) updates) => super.copyWith((message) => updates(message as Claim)) as Claim;

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
  factory ClaimIdentifier() => create();
  ClaimIdentifier._() : super();
  factory ClaimIdentifier.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClaimIdentifier.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClaimIdentifier', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClaimIdentifier clone() => ClaimIdentifier()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClaimIdentifier copyWith(void Function(ClaimIdentifier) updates) => super.copyWith((message) => updates(message as ClaimIdentifier)) as ClaimIdentifier;

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
  factory ClaimOccupation() => create();
  ClaimOccupation._() : super();
  factory ClaimOccupation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClaimOccupation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClaimOccupation', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'organization')
    ..aOS(2, _omitFieldNames ? '' : 'role')
    ..aOS(3, _omitFieldNames ? '' : 'location')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClaimOccupation clone() => ClaimOccupation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClaimOccupation copyWith(void Function(ClaimOccupation) updates) => super.copyWith((message) => updates(message as ClaimOccupation)) as ClaimOccupation;

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
  factory Vouch() => create();
  Vouch._() : super();
  factory Vouch.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Vouch.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Vouch', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Vouch clone() => Vouch()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Vouch copyWith(void Function(Vouch) updates) => super.copyWith((message) => updates(message as Vouch)) as Vouch;

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
  factory StorageTypeProcessSecret() => create();
  StorageTypeProcessSecret._() : super();
  factory StorageTypeProcessSecret.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeProcessSecret.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StorageTypeProcessSecret', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<PrivateKey>(1, _omitFieldNames ? '' : 'system', subBuilder: PrivateKey.create)
    ..aOM<Process>(2, _omitFieldNames ? '' : 'process', subBuilder: Process.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeProcessSecret clone() => StorageTypeProcessSecret()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeProcessSecret copyWith(void Function(StorageTypeProcessSecret) updates) => super.copyWith((message) => updates(message as StorageTypeProcessSecret)) as StorageTypeProcessSecret;

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
  factory StorageTypeProcessState() => create();
  StorageTypeProcessState._() : super();
  factory StorageTypeProcessState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeProcessState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StorageTypeProcessState', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<Range>(2, _omitFieldNames ? '' : 'ranges', $pb.PbFieldType.PM, subBuilder: Range.create)
    ..aOM<Indices>(3, _omitFieldNames ? '' : 'indices', subBuilder: Indices.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeProcessState clone() => StorageTypeProcessState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeProcessState copyWith(void Function(StorageTypeProcessState) updates) => super.copyWith((message) => updates(message as StorageTypeProcessState)) as StorageTypeProcessState;

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
  factory StorageTypeCRDTSetItem() => create();
  StorageTypeCRDTSetItem._() : super();
  factory StorageTypeCRDTSetItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeCRDTSetItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StorageTypeCRDTSetItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'contentType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'unixMilliseconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<LWWElementSet_Operation>(4, _omitFieldNames ? '' : 'operation', $pb.PbFieldType.OE, defaultOrMaker: LWWElementSet_Operation.ADD, valueOf: LWWElementSet_Operation.valueOf, enumValues: LWWElementSet_Operation.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeCRDTSetItem clone() => StorageTypeCRDTSetItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeCRDTSetItem copyWith(void Function(StorageTypeCRDTSetItem) updates) => super.copyWith((message) => updates(message as StorageTypeCRDTSetItem)) as StorageTypeCRDTSetItem;

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
  factory StorageTypeCRDTItem() => create();
  StorageTypeCRDTItem._() : super();
  factory StorageTypeCRDTItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeCRDTItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StorageTypeCRDTItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'contentType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'unixMilliseconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeCRDTItem clone() => StorageTypeCRDTItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeCRDTItem copyWith(void Function(StorageTypeCRDTItem) updates) => super.copyWith((message) => updates(message as StorageTypeCRDTItem)) as StorageTypeCRDTItem;

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
  factory StorageTypeSystemState() => create();
  StorageTypeSystemState._() : super();
  factory StorageTypeSystemState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeSystemState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StorageTypeSystemState', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<StorageTypeCRDTSetItem>(1, _omitFieldNames ? '' : 'crdtSetItems', $pb.PbFieldType.PM, subBuilder: StorageTypeCRDTSetItem.create)
    ..pc<Process>(2, _omitFieldNames ? '' : 'processes', $pb.PbFieldType.PM, subBuilder: Process.create)
    ..pc<StorageTypeCRDTItem>(3, _omitFieldNames ? '' : 'crdtItems', $pb.PbFieldType.PM, subBuilder: StorageTypeCRDTItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeSystemState clone() => StorageTypeSystemState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeSystemState copyWith(void Function(StorageTypeSystemState) updates) => super.copyWith((message) => updates(message as StorageTypeSystemState)) as StorageTypeSystemState;

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
  factory StorageTypeEvent() => create();
  StorageTypeEvent._() : super();
  factory StorageTypeEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorageTypeEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StorageTypeEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<SignedEvent>(1, _omitFieldNames ? '' : 'event', subBuilder: SignedEvent.create)
    ..aOM<Pointer>(2, _omitFieldNames ? '' : 'mutationPointer', subBuilder: Pointer.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorageTypeEvent clone() => StorageTypeEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorageTypeEvent copyWith(void Function(StorageTypeEvent) updates) => super.copyWith((message) => updates(message as StorageTypeEvent)) as StorageTypeEvent;

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
  factory RepeatedUInt64() => create();
  RepeatedUInt64._() : super();
  factory RepeatedUInt64.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepeatedUInt64.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepeatedUInt64', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'numbers', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepeatedUInt64 clone() => RepeatedUInt64()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepeatedUInt64 copyWith(void Function(RepeatedUInt64) updates) => super.copyWith((message) => updates(message as RepeatedUInt64)) as RepeatedUInt64;

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

class QueryReferencesRequest extends $pb.GeneratedMessage {
  factory QueryReferencesRequest() => create();
  QueryReferencesRequest._() : super();
  factory QueryReferencesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryReferencesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryReferencesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<Reference>(1, _omitFieldNames ? '' : 'reference', subBuilder: Reference.create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'cursor', $pb.PbFieldType.OY)
    ..aOM<QueryReferencesRequestEvents>(3, _omitFieldNames ? '' : 'requestEvents', subBuilder: QueryReferencesRequestEvents.create)
    ..pc<QueryReferencesRequestCountLWWElementReferences>(4, _omitFieldNames ? '' : 'countLwwElementReferences', $pb.PbFieldType.PM, subBuilder: QueryReferencesRequestCountLWWElementReferences.create)
    ..pc<QueryReferencesRequestCountReferences>(5, _omitFieldNames ? '' : 'countReferences', $pb.PbFieldType.PM, subBuilder: QueryReferencesRequestCountReferences.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryReferencesRequest clone() => QueryReferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryReferencesRequest copyWith(void Function(QueryReferencesRequest) updates) => super.copyWith((message) => updates(message as QueryReferencesRequest)) as QueryReferencesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryReferencesRequest create() => QueryReferencesRequest._();
  QueryReferencesRequest createEmptyInstance() => create();
  static $pb.PbList<QueryReferencesRequest> createRepeated() => $pb.PbList<QueryReferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static QueryReferencesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryReferencesRequest>(create);
  static QueryReferencesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Reference get reference => $_getN(0);
  @$pb.TagNumber(1)
  set reference(Reference v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => clearField(1);
  @$pb.TagNumber(1)
  Reference ensureReference() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get cursor => $_getN(1);
  @$pb.TagNumber(2)
  set cursor($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearCursor() => clearField(2);

  @$pb.TagNumber(3)
  QueryReferencesRequestEvents get requestEvents => $_getN(2);
  @$pb.TagNumber(3)
  set requestEvents(QueryReferencesRequestEvents v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRequestEvents() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestEvents() => clearField(3);
  @$pb.TagNumber(3)
  QueryReferencesRequestEvents ensureRequestEvents() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<QueryReferencesRequestCountLWWElementReferences> get countLwwElementReferences => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<QueryReferencesRequestCountReferences> get countReferences => $_getList(4);
}

class QueryReferencesRequestEvents extends $pb.GeneratedMessage {
  factory QueryReferencesRequestEvents() => create();
  QueryReferencesRequestEvents._() : super();
  factory QueryReferencesRequestEvents.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryReferencesRequestEvents.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryReferencesRequestEvents', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'fromType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<QueryReferencesRequestCountLWWElementReferences>(2, _omitFieldNames ? '' : 'countLwwElementReferences', $pb.PbFieldType.PM, subBuilder: QueryReferencesRequestCountLWWElementReferences.create)
    ..pc<QueryReferencesRequestCountReferences>(3, _omitFieldNames ? '' : 'countReferences', $pb.PbFieldType.PM, subBuilder: QueryReferencesRequestCountReferences.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryReferencesRequestEvents clone() => QueryReferencesRequestEvents()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryReferencesRequestEvents copyWith(void Function(QueryReferencesRequestEvents) updates) => super.copyWith((message) => updates(message as QueryReferencesRequestEvents)) as QueryReferencesRequestEvents;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryReferencesRequestEvents create() => QueryReferencesRequestEvents._();
  QueryReferencesRequestEvents createEmptyInstance() => create();
  static $pb.PbList<QueryReferencesRequestEvents> createRepeated() => $pb.PbList<QueryReferencesRequestEvents>();
  @$core.pragma('dart2js:noInline')
  static QueryReferencesRequestEvents getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryReferencesRequestEvents>(create);
  static QueryReferencesRequestEvents? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get fromType => $_getI64(0);
  @$pb.TagNumber(1)
  set fromType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromType() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<QueryReferencesRequestCountLWWElementReferences> get countLwwElementReferences => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<QueryReferencesRequestCountReferences> get countReferences => $_getList(2);
}

class QueryReferencesRequestCountLWWElementReferences extends $pb.GeneratedMessage {
  factory QueryReferencesRequestCountLWWElementReferences() => create();
  QueryReferencesRequestCountLWWElementReferences._() : super();
  factory QueryReferencesRequestCountLWWElementReferences.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryReferencesRequestCountLWWElementReferences.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryReferencesRequestCountLWWElementReferences', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'fromType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryReferencesRequestCountLWWElementReferences clone() => QueryReferencesRequestCountLWWElementReferences()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryReferencesRequestCountLWWElementReferences copyWith(void Function(QueryReferencesRequestCountLWWElementReferences) updates) => super.copyWith((message) => updates(message as QueryReferencesRequestCountLWWElementReferences)) as QueryReferencesRequestCountLWWElementReferences;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryReferencesRequestCountLWWElementReferences create() => QueryReferencesRequestCountLWWElementReferences._();
  QueryReferencesRequestCountLWWElementReferences createEmptyInstance() => create();
  static $pb.PbList<QueryReferencesRequestCountLWWElementReferences> createRepeated() => $pb.PbList<QueryReferencesRequestCountLWWElementReferences>();
  @$core.pragma('dart2js:noInline')
  static QueryReferencesRequestCountLWWElementReferences getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryReferencesRequestCountLWWElementReferences>(create);
  static QueryReferencesRequestCountLWWElementReferences? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get fromType => $_getI64(1);
  @$pb.TagNumber(2)
  set fromType($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromType() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromType() => clearField(2);
}

class QueryReferencesRequestCountReferences extends $pb.GeneratedMessage {
  factory QueryReferencesRequestCountReferences() => create();
  QueryReferencesRequestCountReferences._() : super();
  factory QueryReferencesRequestCountReferences.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryReferencesRequestCountReferences.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryReferencesRequestCountReferences', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'fromType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryReferencesRequestCountReferences clone() => QueryReferencesRequestCountReferences()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryReferencesRequestCountReferences copyWith(void Function(QueryReferencesRequestCountReferences) updates) => super.copyWith((message) => updates(message as QueryReferencesRequestCountReferences)) as QueryReferencesRequestCountReferences;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryReferencesRequestCountReferences create() => QueryReferencesRequestCountReferences._();
  QueryReferencesRequestCountReferences createEmptyInstance() => create();
  static $pb.PbList<QueryReferencesRequestCountReferences> createRepeated() => $pb.PbList<QueryReferencesRequestCountReferences>();
  @$core.pragma('dart2js:noInline')
  static QueryReferencesRequestCountReferences getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryReferencesRequestCountReferences>(create);
  static QueryReferencesRequestCountReferences? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get fromType => $_getI64(0);
  @$pb.TagNumber(1)
  set fromType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromType() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromType() => clearField(1);
}

class QueryReferencesResponseEventItem extends $pb.GeneratedMessage {
  factory QueryReferencesResponseEventItem() => create();
  QueryReferencesResponseEventItem._() : super();
  factory QueryReferencesResponseEventItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryReferencesResponseEventItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryReferencesResponseEventItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<SignedEvent>(1, _omitFieldNames ? '' : 'event', subBuilder: SignedEvent.create)
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'counts', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryReferencesResponseEventItem clone() => QueryReferencesResponseEventItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryReferencesResponseEventItem copyWith(void Function(QueryReferencesResponseEventItem) updates) => super.copyWith((message) => updates(message as QueryReferencesResponseEventItem)) as QueryReferencesResponseEventItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryReferencesResponseEventItem create() => QueryReferencesResponseEventItem._();
  QueryReferencesResponseEventItem createEmptyInstance() => create();
  static $pb.PbList<QueryReferencesResponseEventItem> createRepeated() => $pb.PbList<QueryReferencesResponseEventItem>();
  @$core.pragma('dart2js:noInline')
  static QueryReferencesResponseEventItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryReferencesResponseEventItem>(create);
  static QueryReferencesResponseEventItem? _defaultInstance;

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
  $core.List<$fixnum.Int64> get counts => $_getList(1);
}

class QueryReferencesResponse extends $pb.GeneratedMessage {
  factory QueryReferencesResponse() => create();
  QueryReferencesResponse._() : super();
  factory QueryReferencesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryReferencesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryReferencesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<QueryReferencesResponseEventItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: QueryReferencesResponseEventItem.create)
    ..pc<SignedEvent>(2, _omitFieldNames ? '' : 'relatedEvents', $pb.PbFieldType.PM, subBuilder: SignedEvent.create)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'cursor', $pb.PbFieldType.OY)
    ..p<$fixnum.Int64>(4, _omitFieldNames ? '' : 'counts', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryReferencesResponse clone() => QueryReferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryReferencesResponse copyWith(void Function(QueryReferencesResponse) updates) => super.copyWith((message) => updates(message as QueryReferencesResponse)) as QueryReferencesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryReferencesResponse create() => QueryReferencesResponse._();
  QueryReferencesResponse createEmptyInstance() => create();
  static $pb.PbList<QueryReferencesResponse> createRepeated() => $pb.PbList<QueryReferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static QueryReferencesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryReferencesResponse>(create);
  static QueryReferencesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<QueryReferencesResponseEventItem> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<SignedEvent> get relatedEvents => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.int> get cursor => $_getN(2);
  @$pb.TagNumber(3)
  set cursor($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$fixnum.Int64> get counts => $_getList(3);
}

class QueryIndexResponse extends $pb.GeneratedMessage {
  factory QueryIndexResponse() => create();
  QueryIndexResponse._() : super();
  factory QueryIndexResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryIndexResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryIndexResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..pc<SignedEvent>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM, subBuilder: SignedEvent.create)
    ..pc<SignedEvent>(2, _omitFieldNames ? '' : 'proof', $pb.PbFieldType.PM, subBuilder: SignedEvent.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryIndexResponse clone() => QueryIndexResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryIndexResponse copyWith(void Function(QueryIndexResponse) updates) => super.copyWith((message) => updates(message as QueryIndexResponse)) as QueryIndexResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryIndexResponse create() => QueryIndexResponse._();
  QueryIndexResponse createEmptyInstance() => create();
  static $pb.PbList<QueryIndexResponse> createRepeated() => $pb.PbList<QueryIndexResponse>();
  @$core.pragma('dart2js:noInline')
  static QueryIndexResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryIndexResponse>(create);
  static QueryIndexResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SignedEvent> get events => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<SignedEvent> get proof => $_getList(1);
}

class URLInfo extends $pb.GeneratedMessage {
  factory URLInfo() => create();
  URLInfo._() : super();
  factory URLInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory URLInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'URLInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'urlType', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'body', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  URLInfo clone() => URLInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  URLInfo copyWith(void Function(URLInfo) updates) => super.copyWith((message) => updates(message as URLInfo)) as URLInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static URLInfo create() => URLInfo._();
  URLInfo createEmptyInstance() => create();
  static $pb.PbList<URLInfo> createRepeated() => $pb.PbList<URLInfo>();
  @$core.pragma('dart2js:noInline')
  static URLInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<URLInfo>(create);
  static URLInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get urlType => $_getI64(0);
  @$pb.TagNumber(1)
  set urlType($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrlType() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrlType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get body => $_getN(1);
  @$pb.TagNumber(2)
  set body($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => clearField(2);
}

class URLInfoSystemLink extends $pb.GeneratedMessage {
  factory URLInfoSystemLink() => create();
  URLInfoSystemLink._() : super();
  factory URLInfoSystemLink.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory URLInfoSystemLink.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'URLInfoSystemLink', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<PublicKey>(1, _omitFieldNames ? '' : 'system', subBuilder: PublicKey.create)
    ..pPS(2, _omitFieldNames ? '' : 'servers')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  URLInfoSystemLink clone() => URLInfoSystemLink()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  URLInfoSystemLink copyWith(void Function(URLInfoSystemLink) updates) => super.copyWith((message) => updates(message as URLInfoSystemLink)) as URLInfoSystemLink;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static URLInfoSystemLink create() => URLInfoSystemLink._();
  URLInfoSystemLink createEmptyInstance() => create();
  static $pb.PbList<URLInfoSystemLink> createRepeated() => $pb.PbList<URLInfoSystemLink>();
  @$core.pragma('dart2js:noInline')
  static URLInfoSystemLink getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<URLInfoSystemLink>(create);
  static URLInfoSystemLink? _defaultInstance;

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
  $core.List<$core.String> get servers => $_getList(1);
}

class URLInfoEventLink extends $pb.GeneratedMessage {
  factory URLInfoEventLink() => create();
  URLInfoEventLink._() : super();
  factory URLInfoEventLink.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory URLInfoEventLink.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'URLInfoEventLink', package: const $pb.PackageName(_omitMessageNames ? '' : 'userpackage'), createEmptyInstance: create)
    ..aOM<PublicKey>(1, _omitFieldNames ? '' : 'system', subBuilder: PublicKey.create)
    ..aOM<Process>(2, _omitFieldNames ? '' : 'process', subBuilder: Process.create)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'logicalClock', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pPS(4, _omitFieldNames ? '' : 'servers')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  URLInfoEventLink clone() => URLInfoEventLink()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  URLInfoEventLink copyWith(void Function(URLInfoEventLink) updates) => super.copyWith((message) => updates(message as URLInfoEventLink)) as URLInfoEventLink;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static URLInfoEventLink create() => URLInfoEventLink._();
  URLInfoEventLink createEmptyInstance() => create();
  static $pb.PbList<URLInfoEventLink> createRepeated() => $pb.PbList<URLInfoEventLink>();
  @$core.pragma('dart2js:noInline')
  static URLInfoEventLink getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<URLInfoEventLink>(create);
  static URLInfoEventLink? _defaultInstance;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
