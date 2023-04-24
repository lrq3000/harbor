///
//  Generated code. Do not modify.
//  source: protocol.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use publicKeyDescriptor instead')
const PublicKey$json = const {
  '1': 'PublicKey',
  '2': const [
    const {'1': 'key_type', '3': 1, '4': 1, '5': 4, '10': 'keyType'},
    const {'1': 'key', '3': 2, '4': 1, '5': 12, '10': 'key'},
  ],
};

/// Descriptor for `PublicKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeyDescriptor = $convert.base64Decode('CglQdWJsaWNLZXkSGQoIa2V5X3R5cGUYASABKARSB2tleVR5cGUSEAoDa2V5GAIgASgMUgNrZXk=');
@$core.Deprecated('Use processDescriptor instead')
const Process$json = const {
  '1': 'Process',
  '2': const [
    const {'1': 'process', '3': 1, '4': 1, '5': 12, '10': 'process'},
  ],
};

/// Descriptor for `Process`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processDescriptor = $convert.base64Decode('CgdQcm9jZXNzEhgKB3Byb2Nlc3MYASABKAxSB3Byb2Nlc3M=');
@$core.Deprecated('Use indexDescriptor instead')
const Index$json = const {
  '1': 'Index',
  '2': const [
    const {'1': 'index_type', '3': 1, '4': 1, '5': 4, '10': 'indexType'},
    const {'1': 'logical_clock', '3': 2, '4': 1, '5': 4, '10': 'logicalClock'},
  ],
};

/// Descriptor for `Index`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexDescriptor = $convert.base64Decode('CgVJbmRleBIdCgppbmRleF90eXBlGAEgASgEUglpbmRleFR5cGUSIwoNbG9naWNhbF9jbG9jaxgCIAEoBFIMbG9naWNhbENsb2Nr');
@$core.Deprecated('Use indicesDescriptor instead')
const Indices$json = const {
  '1': 'Indices',
  '2': const [
    const {'1': 'indices', '3': 1, '4': 3, '5': 11, '6': '.userpackage.Index', '10': 'indices'},
  ],
};

/// Descriptor for `Indices`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indicesDescriptor = $convert.base64Decode('CgdJbmRpY2VzEiwKB2luZGljZXMYASADKAsyEi51c2VycGFja2FnZS5JbmRleFIHaW5kaWNlcw==');
@$core.Deprecated('Use vectorClockDescriptor instead')
const VectorClock$json = const {
  '1': 'VectorClock',
  '2': const [
    const {'1': 'logical_clocks', '3': 1, '4': 3, '5': 4, '10': 'logicalClocks'},
  ],
};

/// Descriptor for `VectorClock`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vectorClockDescriptor = $convert.base64Decode('CgtWZWN0b3JDbG9jaxIlCg5sb2dpY2FsX2Nsb2NrcxgBIAMoBFINbG9naWNhbENsb2Nrcw==');
@$core.Deprecated('Use signedEventDescriptor instead')
const SignedEvent$json = const {
  '1': 'SignedEvent',
  '2': const [
    const {'1': 'signature', '3': 1, '4': 1, '5': 12, '10': 'signature'},
    const {'1': 'event', '3': 2, '4': 1, '5': 12, '10': 'event'},
  ],
};

/// Descriptor for `SignedEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signedEventDescriptor = $convert.base64Decode('CgtTaWduZWRFdmVudBIcCglzaWduYXR1cmUYASABKAxSCXNpZ25hdHVyZRIUCgVldmVudBgCIAEoDFIFZXZlbnQ=');
@$core.Deprecated('Use lWWElementSetDescriptor instead')
const LWWElementSet$json = const {
  '1': 'LWWElementSet',
  '2': const [
    const {'1': 'operation', '3': 1, '4': 1, '5': 14, '6': '.userpackage.LWWElementSet.Operation', '10': 'operation'},
    const {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
    const {'1': 'unix_milliseconds', '3': 3, '4': 1, '5': 4, '10': 'unixMilliseconds'},
  ],
  '4': const [LWWElementSet_Operation$json],
};

@$core.Deprecated('Use lWWElementSetDescriptor instead')
const LWWElementSet_Operation$json = const {
  '1': 'Operation',
  '2': const [
    const {'1': 'ADD', '2': 0},
    const {'1': 'REMOVE', '2': 1},
  ],
};

/// Descriptor for `LWWElementSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lWWElementSetDescriptor = $convert.base64Decode('Cg1MV1dFbGVtZW50U2V0EkIKCW9wZXJhdGlvbhgBIAEoDjIkLnVzZXJwYWNrYWdlLkxXV0VsZW1lbnRTZXQuT3BlcmF0aW9uUglvcGVyYXRpb24SFAoFdmFsdWUYAiABKAxSBXZhbHVlEisKEXVuaXhfbWlsbGlzZWNvbmRzGAMgASgEUhB1bml4TWlsbGlzZWNvbmRzIiAKCU9wZXJhdGlvbhIHCgNBREQQABIKCgZSRU1PVkUQAQ==');
@$core.Deprecated('Use lWWElementDescriptor instead')
const LWWElement$json = const {
  '1': 'LWWElement',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
    const {'1': 'unix_milliseconds', '3': 2, '4': 1, '5': 4, '10': 'unixMilliseconds'},
  ],
};

/// Descriptor for `LWWElement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lWWElementDescriptor = $convert.base64Decode('CgpMV1dFbGVtZW50EhQKBXZhbHVlGAEgASgMUgV2YWx1ZRIrChF1bml4X21pbGxpc2Vjb25kcxgCIAEoBFIQdW5peE1pbGxpc2Vjb25kcw==');
@$core.Deprecated('Use serverDescriptor instead')
const Server$json = const {
  '1': 'Server',
  '2': const [
    const {'1': 'server', '3': 1, '4': 1, '5': 9, '10': 'server'},
  ],
};

/// Descriptor for `Server`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverDescriptor = $convert.base64Decode('CgZTZXJ2ZXISFgoGc2VydmVyGAEgASgJUgZzZXJ2ZXI=');
@$core.Deprecated('Use blobMetaDescriptor instead')
const BlobMeta$json = const {
  '1': 'BlobMeta',
  '2': const [
    const {'1': 'section_count', '3': 1, '4': 1, '5': 4, '10': 'sectionCount'},
    const {'1': 'mime', '3': 2, '4': 1, '5': 9, '10': 'mime'},
  ],
};

/// Descriptor for `BlobMeta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blobMetaDescriptor = $convert.base64Decode('CghCbG9iTWV0YRIjCg1zZWN0aW9uX2NvdW50GAEgASgEUgxzZWN0aW9uQ291bnQSEgoEbWltZRgCIAEoCVIEbWltZQ==');
@$core.Deprecated('Use blobSectionDescriptor instead')
const BlobSection$json = const {
  '1': 'BlobSection',
  '2': const [
    const {'1': 'meta_pointer', '3': 1, '4': 1, '5': 4, '10': 'metaPointer'},
    const {'1': 'content', '3': 2, '4': 1, '5': 12, '10': 'content'},
  ],
};

/// Descriptor for `BlobSection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blobSectionDescriptor = $convert.base64Decode('CgtCbG9iU2VjdGlvbhIhCgxtZXRhX3BvaW50ZXIYASABKARSC21ldGFQb2ludGVyEhgKB2NvbnRlbnQYAiABKAxSB2NvbnRlbnQ=');
@$core.Deprecated('Use eventDescriptor instead')
const Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'system', '3': 1, '4': 1, '5': 11, '6': '.userpackage.PublicKey', '10': 'system'},
    const {'1': 'process', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    const {'1': 'logical_clock', '3': 3, '4': 1, '5': 4, '10': 'logicalClock'},
    const {'1': 'content_type', '3': 4, '4': 1, '5': 4, '10': 'contentType'},
    const {'1': 'content', '3': 5, '4': 1, '5': 12, '10': 'content'},
    const {'1': 'vector_clock', '3': 6, '4': 1, '5': 11, '6': '.userpackage.VectorClock', '10': 'vectorClock'},
    const {'1': 'indices', '3': 7, '4': 1, '5': 11, '6': '.userpackage.Indices', '10': 'indices'},
    const {'1': 'lww_element_set', '3': 8, '4': 1, '5': 11, '6': '.userpackage.LWWElementSet', '9': 0, '10': 'lwwElementSet', '17': true},
    const {'1': 'lww_element', '3': 9, '4': 1, '5': 11, '6': '.userpackage.LWWElement', '9': 1, '10': 'lwwElement', '17': true},
    const {'1': 'references', '3': 10, '4': 3, '5': 11, '6': '.userpackage.Reference', '10': 'references'},
  ],
  '8': const [
    const {'1': '_lww_element_set'},
    const {'1': '_lww_element'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode('CgVFdmVudBIuCgZzeXN0ZW0YASABKAsyFi51c2VycGFja2FnZS5QdWJsaWNLZXlSBnN5c3RlbRIuCgdwcm9jZXNzGAIgASgLMhQudXNlcnBhY2thZ2UuUHJvY2Vzc1IHcHJvY2VzcxIjCg1sb2dpY2FsX2Nsb2NrGAMgASgEUgxsb2dpY2FsQ2xvY2sSIQoMY29udGVudF90eXBlGAQgASgEUgtjb250ZW50VHlwZRIYCgdjb250ZW50GAUgASgMUgdjb250ZW50EjsKDHZlY3Rvcl9jbG9jaxgGIAEoCzIYLnVzZXJwYWNrYWdlLlZlY3RvckNsb2NrUgt2ZWN0b3JDbG9jaxIuCgdpbmRpY2VzGAcgASgLMhQudXNlcnBhY2thZ2UuSW5kaWNlc1IHaW5kaWNlcxJHCg9sd3dfZWxlbWVudF9zZXQYCCABKAsyGi51c2VycGFja2FnZS5MV1dFbGVtZW50U2V0SABSDWx3d0VsZW1lbnRTZXSIAQESPQoLbHd3X2VsZW1lbnQYCSABKAsyFy51c2VycGFja2FnZS5MV1dFbGVtZW50SAFSCmx3d0VsZW1lbnSIAQESNgoKcmVmZXJlbmNlcxgKIAMoCzIWLnVzZXJwYWNrYWdlLlJlZmVyZW5jZVIKcmVmZXJlbmNlc0ISChBfbHd3X2VsZW1lbnRfc2V0Qg4KDF9sd3dfZWxlbWVudA==');
@$core.Deprecated('Use digestDescriptor instead')
const Digest$json = const {
  '1': 'Digest',
  '2': const [
    const {'1': 'digest_type', '3': 1, '4': 1, '5': 4, '10': 'digestType'},
    const {'1': 'digest', '3': 2, '4': 1, '5': 12, '10': 'digest'},
  ],
};

/// Descriptor for `Digest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List digestDescriptor = $convert.base64Decode('CgZEaWdlc3QSHwoLZGlnZXN0X3R5cGUYASABKARSCmRpZ2VzdFR5cGUSFgoGZGlnZXN0GAIgASgMUgZkaWdlc3Q=');
@$core.Deprecated('Use pointerDescriptor instead')
const Pointer$json = const {
  '1': 'Pointer',
  '2': const [
    const {'1': 'system', '3': 1, '4': 1, '5': 11, '6': '.userpackage.PublicKey', '10': 'system'},
    const {'1': 'process', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    const {'1': 'logical_clock', '3': 3, '4': 1, '5': 4, '10': 'logicalClock'},
    const {'1': 'event_digest', '3': 4, '4': 1, '5': 11, '6': '.userpackage.Digest', '10': 'eventDigest'},
  ],
};

/// Descriptor for `Pointer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointerDescriptor = $convert.base64Decode('CgdQb2ludGVyEi4KBnN5c3RlbRgBIAEoCzIWLnVzZXJwYWNrYWdlLlB1YmxpY0tleVIGc3lzdGVtEi4KB3Byb2Nlc3MYAiABKAsyFC51c2VycGFja2FnZS5Qcm9jZXNzUgdwcm9jZXNzEiMKDWxvZ2ljYWxfY2xvY2sYAyABKARSDGxvZ2ljYWxDbG9jaxI2CgxldmVudF9kaWdlc3QYBCABKAsyEy51c2VycGFja2FnZS5EaWdlc3RSC2V2ZW50RGlnZXN0');
@$core.Deprecated('Use deleteDescriptor instead')
const Delete$json = const {
  '1': 'Delete',
  '2': const [
    const {'1': 'process', '3': 1, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    const {'1': 'logical_clock', '3': 2, '4': 1, '5': 4, '10': 'logicalClock'},
    const {'1': 'indices', '3': 3, '4': 1, '5': 11, '6': '.userpackage.Indices', '10': 'indices'},
  ],
};

/// Descriptor for `Delete`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDescriptor = $convert.base64Decode('CgZEZWxldGUSLgoHcHJvY2VzcxgBIAEoCzIULnVzZXJwYWNrYWdlLlByb2Nlc3NSB3Byb2Nlc3MSIwoNbG9naWNhbF9jbG9jaxgCIAEoBFIMbG9naWNhbENsb2NrEi4KB2luZGljZXMYAyABKAsyFC51c2VycGFja2FnZS5JbmRpY2VzUgdpbmRpY2Vz');
@$core.Deprecated('Use eventsDescriptor instead')
const Events$json = const {
  '1': 'Events',
  '2': const [
    const {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.userpackage.SignedEvent', '10': 'events'},
  ],
};

/// Descriptor for `Events`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventsDescriptor = $convert.base64Decode('CgZFdmVudHMSMAoGZXZlbnRzGAEgAygLMhgudXNlcnBhY2thZ2UuU2lnbmVkRXZlbnRSBmV2ZW50cw==');
@$core.Deprecated('Use rangeDescriptor instead')
const Range$json = const {
  '1': 'Range',
  '2': const [
    const {'1': 'low', '3': 1, '4': 1, '5': 4, '10': 'low'},
    const {'1': 'high', '3': 2, '4': 1, '5': 4, '10': 'high'},
  ],
};

/// Descriptor for `Range`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rangeDescriptor = $convert.base64Decode('CgVSYW5nZRIQCgNsb3cYASABKARSA2xvdxISCgRoaWdoGAIgASgEUgRoaWdo');
@$core.Deprecated('Use rangesForProcessDescriptor instead')
const RangesForProcess$json = const {
  '1': 'RangesForProcess',
  '2': const [
    const {'1': 'process', '3': 1, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    const {'1': 'ranges', '3': 2, '4': 3, '5': 11, '6': '.userpackage.Range', '10': 'ranges'},
  ],
};

/// Descriptor for `RangesForProcess`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rangesForProcessDescriptor = $convert.base64Decode('ChBSYW5nZXNGb3JQcm9jZXNzEi4KB3Byb2Nlc3MYASABKAsyFC51c2VycGFja2FnZS5Qcm9jZXNzUgdwcm9jZXNzEioKBnJhbmdlcxgCIAMoCzISLnVzZXJwYWNrYWdlLlJhbmdlUgZyYW5nZXM=');
@$core.Deprecated('Use rangesForSystemDescriptor instead')
const RangesForSystem$json = const {
  '1': 'RangesForSystem',
  '2': const [
    const {'1': 'ranges_for_processes', '3': 1, '4': 3, '5': 11, '6': '.userpackage.RangesForProcess', '10': 'rangesForProcesses'},
  ],
};

/// Descriptor for `RangesForSystem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rangesForSystemDescriptor = $convert.base64Decode('Cg9SYW5nZXNGb3JTeXN0ZW0STwoUcmFuZ2VzX2Zvcl9wcm9jZXNzZXMYASADKAsyHS51c2VycGFja2FnZS5SYW5nZXNGb3JQcm9jZXNzUhJyYW5nZXNGb3JQcm9jZXNzZXM=');
@$core.Deprecated('Use uRLInfoDescriptor instead')
const URLInfo$json = const {
  '1': 'URLInfo',
  '2': const [
    const {'1': 'system', '3': 1, '4': 1, '5': 11, '6': '.userpackage.PublicKey', '10': 'system'},
    const {'1': 'process', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Process', '9': 0, '10': 'process', '17': true},
    const {'1': 'logical_clock', '3': 3, '4': 1, '5': 4, '9': 1, '10': 'logicalClock', '17': true},
    const {'1': 'servers', '3': 4, '4': 3, '5': 9, '10': 'servers'},
  ],
  '8': const [
    const {'1': '_process'},
    const {'1': '_logical_clock'},
  ],
};

/// Descriptor for `URLInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uRLInfoDescriptor = $convert.base64Decode('CgdVUkxJbmZvEi4KBnN5c3RlbRgBIAEoCzIWLnVzZXJwYWNrYWdlLlB1YmxpY0tleVIGc3lzdGVtEjMKB3Byb2Nlc3MYAiABKAsyFC51c2VycGFja2FnZS5Qcm9jZXNzSABSB3Byb2Nlc3OIAQESKAoNbG9naWNhbF9jbG9jaxgDIAEoBEgBUgxsb2dpY2FsQ2xvY2uIAQESGAoHc2VydmVycxgEIAMoCVIHc2VydmVyc0IKCghfcHJvY2Vzc0IQCg5fbG9naWNhbF9jbG9jaw==');
@$core.Deprecated('Use privateKeyDescriptor instead')
const PrivateKey$json = const {
  '1': 'PrivateKey',
  '2': const [
    const {'1': 'key_type', '3': 1, '4': 1, '5': 4, '10': 'keyType'},
    const {'1': 'key', '3': 2, '4': 1, '5': 12, '10': 'key'},
  ],
};

/// Descriptor for `PrivateKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List privateKeyDescriptor = $convert.base64Decode('CgpQcml2YXRlS2V5EhkKCGtleV90eXBlGAEgASgEUgdrZXlUeXBlEhAKA2tleRgCIAEoDFIDa2V5');
@$core.Deprecated('Use keyPairDescriptor instead')
const KeyPair$json = const {
  '1': 'KeyPair',
  '2': const [
    const {'1': 'key_type', '3': 1, '4': 1, '5': 4, '10': 'keyType'},
    const {'1': 'private_key', '3': 2, '4': 1, '5': 12, '10': 'privateKey'},
    const {'1': 'public_key', '3': 3, '4': 1, '5': 12, '10': 'publicKey'},
  ],
};

/// Descriptor for `KeyPair`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyPairDescriptor = $convert.base64Decode('CgdLZXlQYWlyEhkKCGtleV90eXBlGAEgASgEUgdrZXlUeXBlEh8KC3ByaXZhdGVfa2V5GAIgASgMUgpwcml2YXRlS2V5Eh0KCnB1YmxpY19rZXkYAyABKAxSCXB1YmxpY0tleQ==');
@$core.Deprecated('Use exportBundleDescriptor instead')
const ExportBundle$json = const {
  '1': 'ExportBundle',
  '2': const [
    const {'1': 'key_pair', '3': 1, '4': 1, '5': 11, '6': '.userpackage.KeyPair', '10': 'keyPair'},
    const {'1': 'events', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Events', '10': 'events'},
  ],
};

/// Descriptor for `ExportBundle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportBundleDescriptor = $convert.base64Decode('CgxFeHBvcnRCdW5kbGUSLwoIa2V5X3BhaXIYASABKAsyFC51c2VycGFja2FnZS5LZXlQYWlyUgdrZXlQYWlyEisKBmV2ZW50cxgCIAEoCzITLnVzZXJwYWNrYWdlLkV2ZW50c1IGZXZlbnRz');
@$core.Deprecated('Use resultEventsAndRelatedEventsAndCursorDescriptor instead')
const ResultEventsAndRelatedEventsAndCursor$json = const {
  '1': 'ResultEventsAndRelatedEventsAndCursor',
  '2': const [
    const {'1': 'result_events', '3': 1, '4': 1, '5': 11, '6': '.userpackage.Events', '10': 'resultEvents'},
    const {'1': 'related_events', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Events', '10': 'relatedEvents'},
    const {'1': 'cursor', '3': 3, '4': 1, '5': 4, '10': 'cursor'},
  ],
};

/// Descriptor for `ResultEventsAndRelatedEventsAndCursor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resultEventsAndRelatedEventsAndCursorDescriptor = $convert.base64Decode('CiVSZXN1bHRFdmVudHNBbmRSZWxhdGVkRXZlbnRzQW5kQ3Vyc29yEjgKDXJlc3VsdF9ldmVudHMYASABKAsyEy51c2VycGFja2FnZS5FdmVudHNSDHJlc3VsdEV2ZW50cxI6Cg5yZWxhdGVkX2V2ZW50cxgCIAEoCzITLnVzZXJwYWNrYWdlLkV2ZW50c1INcmVsYXRlZEV2ZW50cxIWCgZjdXJzb3IYAyABKARSBmN1cnNvcg==');
@$core.Deprecated('Use referenceDescriptor instead')
const Reference$json = const {
  '1': 'Reference',
  '2': const [
    const {'1': 'reference_type', '3': 1, '4': 1, '5': 4, '10': 'referenceType'},
    const {'1': 'reference', '3': 2, '4': 1, '5': 12, '10': 'reference'},
  ],
};

/// Descriptor for `Reference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referenceDescriptor = $convert.base64Decode('CglSZWZlcmVuY2USJQoOcmVmZXJlbmNlX3R5cGUYASABKARSDXJlZmVyZW5jZVR5cGUSHAoJcmVmZXJlbmNlGAIgASgMUglyZWZlcmVuY2U=');
@$core.Deprecated('Use postDescriptor instead')
const Post$json = const {
  '1': 'Post',
  '2': const [
    const {'1': 'content', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'content', '17': true},
    const {'1': 'image', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Pointer', '9': 1, '10': 'image', '17': true},
    const {'1': 'boost', '3': 3, '4': 1, '5': 11, '6': '.userpackage.Pointer', '9': 2, '10': 'boost', '17': true},
  ],
  '8': const [
    const {'1': '_content'},
    const {'1': '_image'},
    const {'1': '_boost'},
  ],
};

/// Descriptor for `Post`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postDescriptor = $convert.base64Decode('CgRQb3N0Eh0KB2NvbnRlbnQYASABKAlIAFIHY29udGVudIgBARIvCgVpbWFnZRgCIAEoCzIULnVzZXJwYWNrYWdlLlBvaW50ZXJIAVIFaW1hZ2WIAQESLwoFYm9vc3QYAyABKAsyFC51c2VycGFja2FnZS5Qb2ludGVySAJSBWJvb3N0iAEBQgoKCF9jb250ZW50QggKBl9pbWFnZUIICgZfYm9vc3Q=');
@$core.Deprecated('Use claimDescriptor instead')
const Claim$json = const {
  '1': 'Claim',
  '2': const [
    const {'1': 'claim_type', '3': 1, '4': 1, '5': 9, '10': 'claimType'},
    const {'1': 'claim', '3': 2, '4': 1, '5': 12, '10': 'claim'},
  ],
};

/// Descriptor for `Claim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List claimDescriptor = $convert.base64Decode('CgVDbGFpbRIdCgpjbGFpbV90eXBlGAEgASgJUgljbGFpbVR5cGUSFAoFY2xhaW0YAiABKAxSBWNsYWlt');
@$core.Deprecated('Use claimIdentifierDescriptor instead')
const ClaimIdentifier$json = const {
  '1': 'ClaimIdentifier',
  '2': const [
    const {'1': 'identifier', '3': 1, '4': 1, '5': 9, '10': 'identifier'},
  ],
};

/// Descriptor for `ClaimIdentifier`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List claimIdentifierDescriptor = $convert.base64Decode('Cg9DbGFpbUlkZW50aWZpZXISHgoKaWRlbnRpZmllchgBIAEoCVIKaWRlbnRpZmllcg==');
@$core.Deprecated('Use claimOccupationDescriptor instead')
const ClaimOccupation$json = const {
  '1': 'ClaimOccupation',
  '2': const [
    const {'1': 'organization', '3': 1, '4': 1, '5': 9, '10': 'organization'},
    const {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    const {'1': 'location', '3': 3, '4': 1, '5': 9, '10': 'location'},
  ],
};

/// Descriptor for `ClaimOccupation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List claimOccupationDescriptor = $convert.base64Decode('Cg9DbGFpbU9jY3VwYXRpb24SIgoMb3JnYW5pemF0aW9uGAEgASgJUgxvcmdhbml6YXRpb24SEgoEcm9sZRgCIAEoCVIEcm9sZRIaCghsb2NhdGlvbhgDIAEoCVIIbG9jYXRpb24=');
@$core.Deprecated('Use vouchDescriptor instead')
const Vouch$json = const {
  '1': 'Vouch',
};

/// Descriptor for `Vouch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vouchDescriptor = $convert.base64Decode('CgVWb3VjaA==');
@$core.Deprecated('Use storageTypeProcessSecretDescriptor instead')
const StorageTypeProcessSecret$json = const {
  '1': 'StorageTypeProcessSecret',
  '2': const [
    const {'1': 'system', '3': 1, '4': 1, '5': 11, '6': '.userpackage.PrivateKey', '10': 'system'},
    const {'1': 'process', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
  ],
};

/// Descriptor for `StorageTypeProcessSecret`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeProcessSecretDescriptor = $convert.base64Decode('ChhTdG9yYWdlVHlwZVByb2Nlc3NTZWNyZXQSLwoGc3lzdGVtGAEgASgLMhcudXNlcnBhY2thZ2UuUHJpdmF0ZUtleVIGc3lzdGVtEi4KB3Byb2Nlc3MYAiABKAsyFC51c2VycGFja2FnZS5Qcm9jZXNzUgdwcm9jZXNz');
@$core.Deprecated('Use storageTypeProcessStateDescriptor instead')
const StorageTypeProcessState$json = const {
  '1': 'StorageTypeProcessState',
  '2': const [
    const {'1': 'logical_clock', '3': 1, '4': 1, '5': 4, '10': 'logicalClock'},
    const {'1': 'ranges', '3': 2, '4': 3, '5': 11, '6': '.userpackage.Range', '10': 'ranges'},
    const {'1': 'indices', '3': 3, '4': 1, '5': 11, '6': '.userpackage.Indices', '10': 'indices'},
  ],
};

/// Descriptor for `StorageTypeProcessState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeProcessStateDescriptor = $convert.base64Decode('ChdTdG9yYWdlVHlwZVByb2Nlc3NTdGF0ZRIjCg1sb2dpY2FsX2Nsb2NrGAEgASgEUgxsb2dpY2FsQ2xvY2sSKgoGcmFuZ2VzGAIgAygLMhIudXNlcnBhY2thZ2UuUmFuZ2VSBnJhbmdlcxIuCgdpbmRpY2VzGAMgASgLMhQudXNlcnBhY2thZ2UuSW5kaWNlc1IHaW5kaWNlcw==');
@$core.Deprecated('Use storageTypeCRDTSetItemDescriptor instead')
const StorageTypeCRDTSetItem$json = const {
  '1': 'StorageTypeCRDTSetItem',
  '2': const [
    const {'1': 'content_type', '3': 1, '4': 1, '5': 4, '10': 'contentType'},
    const {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
    const {'1': 'unix_milliseconds', '3': 3, '4': 1, '5': 4, '10': 'unixMilliseconds'},
    const {'1': 'operation', '3': 4, '4': 1, '5': 14, '6': '.userpackage.LWWElementSet.Operation', '10': 'operation'},
  ],
};

/// Descriptor for `StorageTypeCRDTSetItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeCRDTSetItemDescriptor = $convert.base64Decode('ChZTdG9yYWdlVHlwZUNSRFRTZXRJdGVtEiEKDGNvbnRlbnRfdHlwZRgBIAEoBFILY29udGVudFR5cGUSFAoFdmFsdWUYAiABKAxSBXZhbHVlEisKEXVuaXhfbWlsbGlzZWNvbmRzGAMgASgEUhB1bml4TWlsbGlzZWNvbmRzEkIKCW9wZXJhdGlvbhgEIAEoDjIkLnVzZXJwYWNrYWdlLkxXV0VsZW1lbnRTZXQuT3BlcmF0aW9uUglvcGVyYXRpb24=');
@$core.Deprecated('Use storageTypeCRDTItemDescriptor instead')
const StorageTypeCRDTItem$json = const {
  '1': 'StorageTypeCRDTItem',
  '2': const [
    const {'1': 'content_type', '3': 1, '4': 1, '5': 4, '10': 'contentType'},
    const {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
    const {'1': 'unix_milliseconds', '3': 3, '4': 1, '5': 4, '10': 'unixMilliseconds'},
  ],
};

/// Descriptor for `StorageTypeCRDTItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeCRDTItemDescriptor = $convert.base64Decode('ChNTdG9yYWdlVHlwZUNSRFRJdGVtEiEKDGNvbnRlbnRfdHlwZRgBIAEoBFILY29udGVudFR5cGUSFAoFdmFsdWUYAiABKAxSBXZhbHVlEisKEXVuaXhfbWlsbGlzZWNvbmRzGAMgASgEUhB1bml4TWlsbGlzZWNvbmRz');
@$core.Deprecated('Use storageTypeSystemStateDescriptor instead')
const StorageTypeSystemState$json = const {
  '1': 'StorageTypeSystemState',
  '2': const [
    const {'1': 'crdt_set_items', '3': 1, '4': 3, '5': 11, '6': '.userpackage.StorageTypeCRDTSetItem', '10': 'crdtSetItems'},
    const {'1': 'processes', '3': 2, '4': 3, '5': 11, '6': '.userpackage.Process', '10': 'processes'},
    const {'1': 'crdt_items', '3': 3, '4': 3, '5': 11, '6': '.userpackage.StorageTypeCRDTItem', '10': 'crdtItems'},
  ],
};

/// Descriptor for `StorageTypeSystemState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeSystemStateDescriptor = $convert.base64Decode('ChZTdG9yYWdlVHlwZVN5c3RlbVN0YXRlEkkKDmNyZHRfc2V0X2l0ZW1zGAEgAygLMiMudXNlcnBhY2thZ2UuU3RvcmFnZVR5cGVDUkRUU2V0SXRlbVIMY3JkdFNldEl0ZW1zEjIKCXByb2Nlc3NlcxgCIAMoCzIULnVzZXJwYWNrYWdlLlByb2Nlc3NSCXByb2Nlc3NlcxI/CgpjcmR0X2l0ZW1zGAMgAygLMiAudXNlcnBhY2thZ2UuU3RvcmFnZVR5cGVDUkRUSXRlbVIJY3JkdEl0ZW1z');
@$core.Deprecated('Use storageTypeEventDescriptor instead')
const StorageTypeEvent$json = const {
  '1': 'StorageTypeEvent',
  '2': const [
    const {'1': 'event', '3': 1, '4': 1, '5': 11, '6': '.userpackage.SignedEvent', '9': 0, '10': 'event', '17': true},
    const {'1': 'mutation_pointer', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Pointer', '9': 1, '10': 'mutationPointer', '17': true},
  ],
  '8': const [
    const {'1': '_event'},
    const {'1': '_mutation_pointer'},
  ],
};

/// Descriptor for `StorageTypeEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeEventDescriptor = $convert.base64Decode('ChBTdG9yYWdlVHlwZUV2ZW50EjMKBWV2ZW50GAEgASgLMhgudXNlcnBhY2thZ2UuU2lnbmVkRXZlbnRIAFIFZXZlbnSIAQESRAoQbXV0YXRpb25fcG9pbnRlchgCIAEoCzIULnVzZXJwYWNrYWdlLlBvaW50ZXJIAVIPbXV0YXRpb25Qb2ludGVyiAEBQggKBl9ldmVudEITChFfbXV0YXRpb25fcG9pbnRlcg==');
@$core.Deprecated('Use repeatedUInt64Descriptor instead')
const RepeatedUInt64$json = const {
  '1': 'RepeatedUInt64',
  '2': const [
    const {'1': 'numbers', '3': 1, '4': 3, '5': 4, '10': 'numbers'},
  ],
};

/// Descriptor for `RepeatedUInt64`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repeatedUInt64Descriptor = $convert.base64Decode('Cg5SZXBlYXRlZFVJbnQ2NBIYCgdudW1iZXJzGAEgAygEUgdudW1iZXJz');
