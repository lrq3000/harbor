//
//  Generated code. Do not modify.
//  source: protocol.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use publicKeyDescriptor instead')
const PublicKey$json = {
  '1': 'PublicKey',
  '2': [
    {'1': 'key_type', '3': 1, '4': 1, '5': 4, '10': 'keyType'},
    {'1': 'key', '3': 2, '4': 1, '5': 12, '10': 'key'},
  ],
};

/// Descriptor for `PublicKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeyDescriptor = $convert.base64Decode(
    'CglQdWJsaWNLZXkSGQoIa2V5X3R5cGUYASABKARSB2tleVR5cGUSEAoDa2V5GAIgASgMUgNrZX'
    'k=');

@$core.Deprecated('Use processDescriptor instead')
const Process$json = {
  '1': 'Process',
  '2': [
    {'1': 'process', '3': 1, '4': 1, '5': 12, '10': 'process'},
  ],
};

/// Descriptor for `Process`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processDescriptor = $convert.base64Decode(
    'CgdQcm9jZXNzEhgKB3Byb2Nlc3MYASABKAxSB3Byb2Nlc3M=');

@$core.Deprecated('Use indexDescriptor instead')
const Index$json = {
  '1': 'Index',
  '2': [
    {'1': 'index_type', '3': 1, '4': 1, '5': 4, '10': 'indexType'},
    {'1': 'logical_clock', '3': 2, '4': 1, '5': 4, '10': 'logicalClock'},
  ],
};

/// Descriptor for `Index`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexDescriptor = $convert.base64Decode(
    'CgVJbmRleBIdCgppbmRleF90eXBlGAEgASgEUglpbmRleFR5cGUSIwoNbG9naWNhbF9jbG9jax'
    'gCIAEoBFIMbG9naWNhbENsb2Nr');

@$core.Deprecated('Use indicesDescriptor instead')
const Indices$json = {
  '1': 'Indices',
  '2': [
    {'1': 'indices', '3': 1, '4': 3, '5': 11, '6': '.userpackage.Index', '10': 'indices'},
  ],
};

/// Descriptor for `Indices`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indicesDescriptor = $convert.base64Decode(
    'CgdJbmRpY2VzEiwKB2luZGljZXMYASADKAsyEi51c2VycGFja2FnZS5JbmRleFIHaW5kaWNlcw'
    '==');

@$core.Deprecated('Use vectorClockDescriptor instead')
const VectorClock$json = {
  '1': 'VectorClock',
  '2': [
    {'1': 'logical_clocks', '3': 1, '4': 3, '5': 4, '10': 'logicalClocks'},
  ],
};

/// Descriptor for `VectorClock`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vectorClockDescriptor = $convert.base64Decode(
    'CgtWZWN0b3JDbG9jaxIlCg5sb2dpY2FsX2Nsb2NrcxgBIAMoBFINbG9naWNhbENsb2Nrcw==');

@$core.Deprecated('Use signedEventDescriptor instead')
const SignedEvent$json = {
  '1': 'SignedEvent',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 12, '10': 'signature'},
    {'1': 'event', '3': 2, '4': 1, '5': 12, '10': 'event'},
  ],
};

/// Descriptor for `SignedEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signedEventDescriptor = $convert.base64Decode(
    'CgtTaWduZWRFdmVudBIcCglzaWduYXR1cmUYASABKAxSCXNpZ25hdHVyZRIUCgVldmVudBgCIA'
    'EoDFIFZXZlbnQ=');

@$core.Deprecated('Use lWWElementSetDescriptor instead')
const LWWElementSet$json = {
  '1': 'LWWElementSet',
  '2': [
    {'1': 'operation', '3': 1, '4': 1, '5': 14, '6': '.userpackage.LWWElementSet.Operation', '10': 'operation'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
    {'1': 'unix_milliseconds', '3': 3, '4': 1, '5': 4, '10': 'unixMilliseconds'},
  ],
  '4': [LWWElementSet_Operation$json],
};

@$core.Deprecated('Use lWWElementSetDescriptor instead')
const LWWElementSet_Operation$json = {
  '1': 'Operation',
  '2': [
    {'1': 'ADD', '2': 0},
    {'1': 'REMOVE', '2': 1},
  ],
};

/// Descriptor for `LWWElementSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lWWElementSetDescriptor = $convert.base64Decode(
    'Cg1MV1dFbGVtZW50U2V0EkIKCW9wZXJhdGlvbhgBIAEoDjIkLnVzZXJwYWNrYWdlLkxXV0VsZW'
    '1lbnRTZXQuT3BlcmF0aW9uUglvcGVyYXRpb24SFAoFdmFsdWUYAiABKAxSBXZhbHVlEisKEXVu'
    'aXhfbWlsbGlzZWNvbmRzGAMgASgEUhB1bml4TWlsbGlzZWNvbmRzIiAKCU9wZXJhdGlvbhIHCg'
    'NBREQQABIKCgZSRU1PVkUQAQ==');

@$core.Deprecated('Use lWWElementDescriptor instead')
const LWWElement$json = {
  '1': 'LWWElement',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
    {'1': 'unix_milliseconds', '3': 2, '4': 1, '5': 4, '10': 'unixMilliseconds'},
  ],
};

/// Descriptor for `LWWElement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lWWElementDescriptor = $convert.base64Decode(
    'CgpMV1dFbGVtZW50EhQKBXZhbHVlGAEgASgMUgV2YWx1ZRIrChF1bml4X21pbGxpc2Vjb25kcx'
    'gCIAEoBFIQdW5peE1pbGxpc2Vjb25kcw==');

@$core.Deprecated('Use serverDescriptor instead')
const Server$json = {
  '1': 'Server',
  '2': [
    {'1': 'server', '3': 1, '4': 1, '5': 9, '10': 'server'},
  ],
};

/// Descriptor for `Server`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverDescriptor = $convert.base64Decode(
    'CgZTZXJ2ZXISFgoGc2VydmVyGAEgASgJUgZzZXJ2ZXI=');

@$core.Deprecated('Use imageManifestDescriptor instead')
const ImageManifest$json = {
  '1': 'ImageManifest',
  '2': [
    {'1': 'mime', '3': 1, '4': 1, '5': 9, '10': 'mime'},
    {'1': 'width', '3': 2, '4': 1, '5': 4, '10': 'width'},
    {'1': 'height', '3': 3, '4': 1, '5': 4, '10': 'height'},
    {'1': 'byte_count', '3': 4, '4': 1, '5': 4, '10': 'byteCount'},
    {'1': 'process', '3': 5, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    {'1': 'sections', '3': 6, '4': 3, '5': 11, '6': '.userpackage.Range', '10': 'sections'},
  ],
};

/// Descriptor for `ImageManifest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageManifestDescriptor = $convert.base64Decode(
    'Cg1JbWFnZU1hbmlmZXN0EhIKBG1pbWUYASABKAlSBG1pbWUSFAoFd2lkdGgYAiABKARSBXdpZH'
    'RoEhYKBmhlaWdodBgDIAEoBFIGaGVpZ2h0Eh0KCmJ5dGVfY291bnQYBCABKARSCWJ5dGVDb3Vu'
    'dBIuCgdwcm9jZXNzGAUgASgLMhQudXNlcnBhY2thZ2UuUHJvY2Vzc1IHcHJvY2VzcxIuCghzZW'
    'N0aW9ucxgGIAMoCzISLnVzZXJwYWNrYWdlLlJhbmdlUghzZWN0aW9ucw==');

@$core.Deprecated('Use imageBundleDescriptor instead')
const ImageBundle$json = {
  '1': 'ImageBundle',
  '2': [
    {'1': 'image_manifests', '3': 1, '4': 3, '5': 11, '6': '.userpackage.ImageManifest', '10': 'imageManifests'},
  ],
};

/// Descriptor for `ImageBundle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageBundleDescriptor = $convert.base64Decode(
    'CgtJbWFnZUJ1bmRsZRJDCg9pbWFnZV9tYW5pZmVzdHMYASADKAsyGi51c2VycGFja2FnZS5JbW'
    'FnZU1hbmlmZXN0Ug5pbWFnZU1hbmlmZXN0cw==');

@$core.Deprecated('Use eventDescriptor instead')
const Event$json = {
  '1': 'Event',
  '2': [
    {'1': 'system', '3': 1, '4': 1, '5': 11, '6': '.userpackage.PublicKey', '10': 'system'},
    {'1': 'process', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    {'1': 'logical_clock', '3': 3, '4': 1, '5': 4, '10': 'logicalClock'},
    {'1': 'content_type', '3': 4, '4': 1, '5': 4, '10': 'contentType'},
    {'1': 'content', '3': 5, '4': 1, '5': 12, '10': 'content'},
    {'1': 'vector_clock', '3': 6, '4': 1, '5': 11, '6': '.userpackage.VectorClock', '10': 'vectorClock'},
    {'1': 'indices', '3': 7, '4': 1, '5': 11, '6': '.userpackage.Indices', '10': 'indices'},
    {'1': 'lww_element_set', '3': 8, '4': 1, '5': 11, '6': '.userpackage.LWWElementSet', '9': 0, '10': 'lwwElementSet', '17': true},
    {'1': 'lww_element', '3': 9, '4': 1, '5': 11, '6': '.userpackage.LWWElement', '9': 1, '10': 'lwwElement', '17': true},
    {'1': 'references', '3': 10, '4': 3, '5': 11, '6': '.userpackage.Reference', '10': 'references'},
    {'1': 'unix_milliseconds', '3': 11, '4': 1, '5': 4, '9': 2, '10': 'unixMilliseconds', '17': true},
  ],
  '8': [
    {'1': '_lww_element_set'},
    {'1': '_lww_element'},
    {'1': '_unix_milliseconds'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode(
    'CgVFdmVudBIuCgZzeXN0ZW0YASABKAsyFi51c2VycGFja2FnZS5QdWJsaWNLZXlSBnN5c3RlbR'
    'IuCgdwcm9jZXNzGAIgASgLMhQudXNlcnBhY2thZ2UuUHJvY2Vzc1IHcHJvY2VzcxIjCg1sb2dp'
    'Y2FsX2Nsb2NrGAMgASgEUgxsb2dpY2FsQ2xvY2sSIQoMY29udGVudF90eXBlGAQgASgEUgtjb2'
    '50ZW50VHlwZRIYCgdjb250ZW50GAUgASgMUgdjb250ZW50EjsKDHZlY3Rvcl9jbG9jaxgGIAEo'
    'CzIYLnVzZXJwYWNrYWdlLlZlY3RvckNsb2NrUgt2ZWN0b3JDbG9jaxIuCgdpbmRpY2VzGAcgAS'
    'gLMhQudXNlcnBhY2thZ2UuSW5kaWNlc1IHaW5kaWNlcxJHCg9sd3dfZWxlbWVudF9zZXQYCCAB'
    'KAsyGi51c2VycGFja2FnZS5MV1dFbGVtZW50U2V0SABSDWx3d0VsZW1lbnRTZXSIAQESPQoLbH'
    'd3X2VsZW1lbnQYCSABKAsyFy51c2VycGFja2FnZS5MV1dFbGVtZW50SAFSCmx3d0VsZW1lbnSI'
    'AQESNgoKcmVmZXJlbmNlcxgKIAMoCzIWLnVzZXJwYWNrYWdlLlJlZmVyZW5jZVIKcmVmZXJlbm'
    'NlcxIwChF1bml4X21pbGxpc2Vjb25kcxgLIAEoBEgCUhB1bml4TWlsbGlzZWNvbmRziAEBQhIK'
    'EF9sd3dfZWxlbWVudF9zZXRCDgoMX2x3d19lbGVtZW50QhQKEl91bml4X21pbGxpc2Vjb25kcw'
    '==');

@$core.Deprecated('Use digestDescriptor instead')
const Digest$json = {
  '1': 'Digest',
  '2': [
    {'1': 'digest_type', '3': 1, '4': 1, '5': 4, '10': 'digestType'},
    {'1': 'digest', '3': 2, '4': 1, '5': 12, '10': 'digest'},
  ],
};

/// Descriptor for `Digest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List digestDescriptor = $convert.base64Decode(
    'CgZEaWdlc3QSHwoLZGlnZXN0X3R5cGUYASABKARSCmRpZ2VzdFR5cGUSFgoGZGlnZXN0GAIgAS'
    'gMUgZkaWdlc3Q=');

@$core.Deprecated('Use pointerDescriptor instead')
const Pointer$json = {
  '1': 'Pointer',
  '2': [
    {'1': 'system', '3': 1, '4': 1, '5': 11, '6': '.userpackage.PublicKey', '10': 'system'},
    {'1': 'process', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    {'1': 'logical_clock', '3': 3, '4': 1, '5': 4, '10': 'logicalClock'},
    {'1': 'event_digest', '3': 4, '4': 1, '5': 11, '6': '.userpackage.Digest', '10': 'eventDigest'},
  ],
};

/// Descriptor for `Pointer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointerDescriptor = $convert.base64Decode(
    'CgdQb2ludGVyEi4KBnN5c3RlbRgBIAEoCzIWLnVzZXJwYWNrYWdlLlB1YmxpY0tleVIGc3lzdG'
    'VtEi4KB3Byb2Nlc3MYAiABKAsyFC51c2VycGFja2FnZS5Qcm9jZXNzUgdwcm9jZXNzEiMKDWxv'
    'Z2ljYWxfY2xvY2sYAyABKARSDGxvZ2ljYWxDbG9jaxI2CgxldmVudF9kaWdlc3QYBCABKAsyEy'
    '51c2VycGFja2FnZS5EaWdlc3RSC2V2ZW50RGlnZXN0');

@$core.Deprecated('Use deleteDescriptor instead')
const Delete$json = {
  '1': 'Delete',
  '2': [
    {'1': 'process', '3': 1, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    {'1': 'logical_clock', '3': 2, '4': 1, '5': 4, '10': 'logicalClock'},
    {'1': 'indices', '3': 3, '4': 1, '5': 11, '6': '.userpackage.Indices', '10': 'indices'},
    {'1': 'unix_milliseconds', '3': 4, '4': 1, '5': 4, '9': 0, '10': 'unixMilliseconds', '17': true},
    {'1': 'content_type', '3': 5, '4': 1, '5': 4, '10': 'contentType'},
  ],
  '8': [
    {'1': '_unix_milliseconds'},
  ],
};

/// Descriptor for `Delete`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDescriptor = $convert.base64Decode(
    'CgZEZWxldGUSLgoHcHJvY2VzcxgBIAEoCzIULnVzZXJwYWNrYWdlLlByb2Nlc3NSB3Byb2Nlc3'
    'MSIwoNbG9naWNhbF9jbG9jaxgCIAEoBFIMbG9naWNhbENsb2NrEi4KB2luZGljZXMYAyABKAsy'
    'FC51c2VycGFja2FnZS5JbmRpY2VzUgdpbmRpY2VzEjAKEXVuaXhfbWlsbGlzZWNvbmRzGAQgAS'
    'gESABSEHVuaXhNaWxsaXNlY29uZHOIAQESIQoMY29udGVudF90eXBlGAUgASgEUgtjb250ZW50'
    'VHlwZUIUChJfdW5peF9taWxsaXNlY29uZHM=');

@$core.Deprecated('Use eventsDescriptor instead')
const Events$json = {
  '1': 'Events',
  '2': [
    {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.userpackage.SignedEvent', '10': 'events'},
  ],
};

/// Descriptor for `Events`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventsDescriptor = $convert.base64Decode(
    'CgZFdmVudHMSMAoGZXZlbnRzGAEgAygLMhgudXNlcnBhY2thZ2UuU2lnbmVkRXZlbnRSBmV2ZW'
    '50cw==');

@$core.Deprecated('Use publicKeysDescriptor instead')
const PublicKeys$json = {
  '1': 'PublicKeys',
  '2': [
    {'1': 'systems', '3': 1, '4': 3, '5': 11, '6': '.userpackage.PublicKey', '10': 'systems'},
  ],
};

/// Descriptor for `PublicKeys`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeysDescriptor = $convert.base64Decode(
    'CgpQdWJsaWNLZXlzEjAKB3N5c3RlbXMYASADKAsyFi51c2VycGFja2FnZS5QdWJsaWNLZXlSB3'
    'N5c3RlbXM=');

@$core.Deprecated('Use rangeDescriptor instead')
const Range$json = {
  '1': 'Range',
  '2': [
    {'1': 'low', '3': 1, '4': 1, '5': 4, '10': 'low'},
    {'1': 'high', '3': 2, '4': 1, '5': 4, '10': 'high'},
  ],
};

/// Descriptor for `Range`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rangeDescriptor = $convert.base64Decode(
    'CgVSYW5nZRIQCgNsb3cYASABKARSA2xvdxISCgRoaWdoGAIgASgEUgRoaWdo');

@$core.Deprecated('Use rangesForProcessDescriptor instead')
const RangesForProcess$json = {
  '1': 'RangesForProcess',
  '2': [
    {'1': 'process', '3': 1, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    {'1': 'ranges', '3': 2, '4': 3, '5': 11, '6': '.userpackage.Range', '10': 'ranges'},
  ],
};

/// Descriptor for `RangesForProcess`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rangesForProcessDescriptor = $convert.base64Decode(
    'ChBSYW5nZXNGb3JQcm9jZXNzEi4KB3Byb2Nlc3MYASABKAsyFC51c2VycGFja2FnZS5Qcm9jZX'
    'NzUgdwcm9jZXNzEioKBnJhbmdlcxgCIAMoCzISLnVzZXJwYWNrYWdlLlJhbmdlUgZyYW5nZXM=');

@$core.Deprecated('Use rangesForSystemDescriptor instead')
const RangesForSystem$json = {
  '1': 'RangesForSystem',
  '2': [
    {'1': 'ranges_for_processes', '3': 1, '4': 3, '5': 11, '6': '.userpackage.RangesForProcess', '10': 'rangesForProcesses'},
  ],
};

/// Descriptor for `RangesForSystem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rangesForSystemDescriptor = $convert.base64Decode(
    'Cg9SYW5nZXNGb3JTeXN0ZW0STwoUcmFuZ2VzX2Zvcl9wcm9jZXNzZXMYASADKAsyHS51c2VycG'
    'Fja2FnZS5SYW5nZXNGb3JQcm9jZXNzUhJyYW5nZXNGb3JQcm9jZXNzZXM=');

@$core.Deprecated('Use privateKeyDescriptor instead')
const PrivateKey$json = {
  '1': 'PrivateKey',
  '2': [
    {'1': 'key_type', '3': 1, '4': 1, '5': 4, '10': 'keyType'},
    {'1': 'key', '3': 2, '4': 1, '5': 12, '10': 'key'},
  ],
};

/// Descriptor for `PrivateKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List privateKeyDescriptor = $convert.base64Decode(
    'CgpQcml2YXRlS2V5EhkKCGtleV90eXBlGAEgASgEUgdrZXlUeXBlEhAKA2tleRgCIAEoDFIDa2'
    'V5');

@$core.Deprecated('Use keyPairDescriptor instead')
const KeyPair$json = {
  '1': 'KeyPair',
  '2': [
    {'1': 'key_type', '3': 1, '4': 1, '5': 4, '10': 'keyType'},
    {'1': 'private_key', '3': 2, '4': 1, '5': 12, '10': 'privateKey'},
    {'1': 'public_key', '3': 3, '4': 1, '5': 12, '10': 'publicKey'},
  ],
};

/// Descriptor for `KeyPair`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyPairDescriptor = $convert.base64Decode(
    'CgdLZXlQYWlyEhkKCGtleV90eXBlGAEgASgEUgdrZXlUeXBlEh8KC3ByaXZhdGVfa2V5GAIgAS'
    'gMUgpwcml2YXRlS2V5Eh0KCnB1YmxpY19rZXkYAyABKAxSCXB1YmxpY0tleQ==');

@$core.Deprecated('Use exportBundleDescriptor instead')
const ExportBundle$json = {
  '1': 'ExportBundle',
  '2': [
    {'1': 'key_pair', '3': 1, '4': 1, '5': 11, '6': '.userpackage.KeyPair', '10': 'keyPair'},
    {'1': 'events', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Events', '10': 'events'},
  ],
};

/// Descriptor for `ExportBundle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportBundleDescriptor = $convert.base64Decode(
    'CgxFeHBvcnRCdW5kbGUSLwoIa2V5X3BhaXIYASABKAsyFC51c2VycGFja2FnZS5LZXlQYWlyUg'
    'drZXlQYWlyEisKBmV2ZW50cxgCIAEoCzITLnVzZXJwYWNrYWdlLkV2ZW50c1IGZXZlbnRz');

@$core.Deprecated('Use resultEventsAndRelatedEventsAndCursorDescriptor instead')
const ResultEventsAndRelatedEventsAndCursor$json = {
  '1': 'ResultEventsAndRelatedEventsAndCursor',
  '2': [
    {'1': 'result_events', '3': 1, '4': 1, '5': 11, '6': '.userpackage.Events', '10': 'resultEvents'},
    {'1': 'related_events', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Events', '10': 'relatedEvents'},
    {'1': 'cursor', '3': 3, '4': 1, '5': 12, '9': 0, '10': 'cursor', '17': true},
  ],
  '8': [
    {'1': '_cursor'},
  ],
};

/// Descriptor for `ResultEventsAndRelatedEventsAndCursor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resultEventsAndRelatedEventsAndCursorDescriptor = $convert.base64Decode(
    'CiVSZXN1bHRFdmVudHNBbmRSZWxhdGVkRXZlbnRzQW5kQ3Vyc29yEjgKDXJlc3VsdF9ldmVudH'
    'MYASABKAsyEy51c2VycGFja2FnZS5FdmVudHNSDHJlc3VsdEV2ZW50cxI6Cg5yZWxhdGVkX2V2'
    'ZW50cxgCIAEoCzITLnVzZXJwYWNrYWdlLkV2ZW50c1INcmVsYXRlZEV2ZW50cxIbCgZjdXJzb3'
    'IYAyABKAxIAFIGY3Vyc29yiAEBQgkKB19jdXJzb3I=');

@$core.Deprecated('Use referenceDescriptor instead')
const Reference$json = {
  '1': 'Reference',
  '2': [
    {'1': 'reference_type', '3': 1, '4': 1, '5': 4, '10': 'referenceType'},
    {'1': 'reference', '3': 2, '4': 1, '5': 12, '10': 'reference'},
  ],
};

/// Descriptor for `Reference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List referenceDescriptor = $convert.base64Decode(
    'CglSZWZlcmVuY2USJQoOcmVmZXJlbmNlX3R5cGUYASABKARSDXJlZmVyZW5jZVR5cGUSHAoJcm'
    'VmZXJlbmNlGAIgASgMUglyZWZlcmVuY2U=');

@$core.Deprecated('Use postDescriptor instead')
const Post$json = {
  '1': 'Post',
  '2': [
    {'1': 'content', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'content', '17': true},
    {'1': 'image', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Pointer', '9': 1, '10': 'image', '17': true},
  ],
  '8': [
    {'1': '_content'},
    {'1': '_image'},
  ],
};

/// Descriptor for `Post`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postDescriptor = $convert.base64Decode(
    'CgRQb3N0Eh0KB2NvbnRlbnQYASABKAlIAFIHY29udGVudIgBARIvCgVpbWFnZRgCIAEoCzIULn'
    'VzZXJwYWNrYWdlLlBvaW50ZXJIAVIFaW1hZ2WIAQFCCgoIX2NvbnRlbnRCCAoGX2ltYWdl');

@$core.Deprecated('Use claimDescriptor instead')
const Claim$json = {
  '1': 'Claim',
  '2': [
    {'1': 'claim_type', '3': 1, '4': 1, '5': 4, '10': 'claimType'},
    {'1': 'claim_fields', '3': 2, '4': 3, '5': 11, '6': '.userpackage.ClaimFieldEntry', '10': 'claimFields'},
  ],
};

/// Descriptor for `Claim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List claimDescriptor = $convert.base64Decode(
    'CgVDbGFpbRIdCgpjbGFpbV90eXBlGAEgASgEUgljbGFpbVR5cGUSPwoMY2xhaW1fZmllbGRzGA'
    'IgAygLMhwudXNlcnBhY2thZ2UuQ2xhaW1GaWVsZEVudHJ5UgtjbGFpbUZpZWxkcw==');

@$core.Deprecated('Use claimFieldEntryDescriptor instead')
const ClaimFieldEntry$json = {
  '1': 'ClaimFieldEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `ClaimFieldEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List claimFieldEntryDescriptor = $convert.base64Decode(
    'Cg9DbGFpbUZpZWxkRW50cnkSEAoDa2V5GAEgASgEUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbH'
    'Vl');

@$core.Deprecated('Use vouchDescriptor instead')
const Vouch$json = {
  '1': 'Vouch',
};

/// Descriptor for `Vouch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vouchDescriptor = $convert.base64Decode(
    'CgVWb3VjaA==');

@$core.Deprecated('Use storageTypeProcessSecretDescriptor instead')
const StorageTypeProcessSecret$json = {
  '1': 'StorageTypeProcessSecret',
  '2': [
    {'1': 'system', '3': 1, '4': 1, '5': 11, '6': '.userpackage.PrivateKey', '10': 'system'},
    {'1': 'process', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
  ],
};

/// Descriptor for `StorageTypeProcessSecret`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeProcessSecretDescriptor = $convert.base64Decode(
    'ChhTdG9yYWdlVHlwZVByb2Nlc3NTZWNyZXQSLwoGc3lzdGVtGAEgASgLMhcudXNlcnBhY2thZ2'
    'UuUHJpdmF0ZUtleVIGc3lzdGVtEi4KB3Byb2Nlc3MYAiABKAsyFC51c2VycGFja2FnZS5Qcm9j'
    'ZXNzUgdwcm9jZXNz');

@$core.Deprecated('Use storageTypeProcessStateDescriptor instead')
const StorageTypeProcessState$json = {
  '1': 'StorageTypeProcessState',
  '2': [
    {'1': 'logical_clock', '3': 1, '4': 1, '5': 4, '10': 'logicalClock'},
    {'1': 'ranges', '3': 2, '4': 3, '5': 11, '6': '.userpackage.Range', '10': 'ranges'},
    {'1': 'indices', '3': 3, '4': 1, '5': 11, '6': '.userpackage.Indices', '10': 'indices'},
  ],
};

/// Descriptor for `StorageTypeProcessState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeProcessStateDescriptor = $convert.base64Decode(
    'ChdTdG9yYWdlVHlwZVByb2Nlc3NTdGF0ZRIjCg1sb2dpY2FsX2Nsb2NrGAEgASgEUgxsb2dpY2'
    'FsQ2xvY2sSKgoGcmFuZ2VzGAIgAygLMhIudXNlcnBhY2thZ2UuUmFuZ2VSBnJhbmdlcxIuCgdp'
    'bmRpY2VzGAMgASgLMhQudXNlcnBhY2thZ2UuSW5kaWNlc1IHaW5kaWNlcw==');

@$core.Deprecated('Use storageTypeCRDTSetItemDescriptor instead')
const StorageTypeCRDTSetItem$json = {
  '1': 'StorageTypeCRDTSetItem',
  '2': [
    {'1': 'content_type', '3': 1, '4': 1, '5': 4, '10': 'contentType'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
    {'1': 'unix_milliseconds', '3': 3, '4': 1, '5': 4, '10': 'unixMilliseconds'},
    {'1': 'operation', '3': 4, '4': 1, '5': 14, '6': '.userpackage.LWWElementSet.Operation', '10': 'operation'},
  ],
};

/// Descriptor for `StorageTypeCRDTSetItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeCRDTSetItemDescriptor = $convert.base64Decode(
    'ChZTdG9yYWdlVHlwZUNSRFRTZXRJdGVtEiEKDGNvbnRlbnRfdHlwZRgBIAEoBFILY29udGVudF'
    'R5cGUSFAoFdmFsdWUYAiABKAxSBXZhbHVlEisKEXVuaXhfbWlsbGlzZWNvbmRzGAMgASgEUhB1'
    'bml4TWlsbGlzZWNvbmRzEkIKCW9wZXJhdGlvbhgEIAEoDjIkLnVzZXJwYWNrYWdlLkxXV0VsZW'
    '1lbnRTZXQuT3BlcmF0aW9uUglvcGVyYXRpb24=');

@$core.Deprecated('Use storageTypeCRDTItemDescriptor instead')
const StorageTypeCRDTItem$json = {
  '1': 'StorageTypeCRDTItem',
  '2': [
    {'1': 'content_type', '3': 1, '4': 1, '5': 4, '10': 'contentType'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
    {'1': 'unix_milliseconds', '3': 3, '4': 1, '5': 4, '10': 'unixMilliseconds'},
  ],
};

/// Descriptor for `StorageTypeCRDTItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeCRDTItemDescriptor = $convert.base64Decode(
    'ChNTdG9yYWdlVHlwZUNSRFRJdGVtEiEKDGNvbnRlbnRfdHlwZRgBIAEoBFILY29udGVudFR5cG'
    'USFAoFdmFsdWUYAiABKAxSBXZhbHVlEisKEXVuaXhfbWlsbGlzZWNvbmRzGAMgASgEUhB1bml4'
    'TWlsbGlzZWNvbmRz');

@$core.Deprecated('Use storageTypeSystemStateDescriptor instead')
const StorageTypeSystemState$json = {
  '1': 'StorageTypeSystemState',
  '2': [
    {'1': 'crdt_set_items', '3': 1, '4': 3, '5': 11, '6': '.userpackage.StorageTypeCRDTSetItem', '10': 'crdtSetItems'},
    {'1': 'processes', '3': 2, '4': 3, '5': 11, '6': '.userpackage.Process', '10': 'processes'},
    {'1': 'crdt_items', '3': 3, '4': 3, '5': 11, '6': '.userpackage.StorageTypeCRDTItem', '10': 'crdtItems'},
  ],
};

/// Descriptor for `StorageTypeSystemState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeSystemStateDescriptor = $convert.base64Decode(
    'ChZTdG9yYWdlVHlwZVN5c3RlbVN0YXRlEkkKDmNyZHRfc2V0X2l0ZW1zGAEgAygLMiMudXNlcn'
    'BhY2thZ2UuU3RvcmFnZVR5cGVDUkRUU2V0SXRlbVIMY3JkdFNldEl0ZW1zEjIKCXByb2Nlc3Nl'
    'cxgCIAMoCzIULnVzZXJwYWNrYWdlLlByb2Nlc3NSCXByb2Nlc3NlcxI/CgpjcmR0X2l0ZW1zGA'
    'MgAygLMiAudXNlcnBhY2thZ2UuU3RvcmFnZVR5cGVDUkRUSXRlbVIJY3JkdEl0ZW1z');

@$core.Deprecated('Use storageTypeEventDescriptor instead')
const StorageTypeEvent$json = {
  '1': 'StorageTypeEvent',
  '2': [
    {'1': 'event', '3': 1, '4': 1, '5': 11, '6': '.userpackage.SignedEvent', '9': 0, '10': 'event', '17': true},
    {'1': 'mutation_pointer', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Pointer', '9': 1, '10': 'mutationPointer', '17': true},
  ],
  '8': [
    {'1': '_event'},
    {'1': '_mutation_pointer'},
  ],
};

/// Descriptor for `StorageTypeEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageTypeEventDescriptor = $convert.base64Decode(
    'ChBTdG9yYWdlVHlwZUV2ZW50EjMKBWV2ZW50GAEgASgLMhgudXNlcnBhY2thZ2UuU2lnbmVkRX'
    'ZlbnRIAFIFZXZlbnSIAQESRAoQbXV0YXRpb25fcG9pbnRlchgCIAEoCzIULnVzZXJwYWNrYWdl'
    'LlBvaW50ZXJIAVIPbXV0YXRpb25Qb2ludGVyiAEBQggKBl9ldmVudEITChFfbXV0YXRpb25fcG'
    '9pbnRlcg==');

@$core.Deprecated('Use repeatedUInt64Descriptor instead')
const RepeatedUInt64$json = {
  '1': 'RepeatedUInt64',
  '2': [
    {'1': 'numbers', '3': 1, '4': 3, '5': 4, '10': 'numbers'},
  ],
};

/// Descriptor for `RepeatedUInt64`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repeatedUInt64Descriptor = $convert.base64Decode(
    'Cg5SZXBlYXRlZFVJbnQ2NBIYCgdudW1iZXJzGAEgAygEUgdudW1iZXJz');

@$core.Deprecated('Use queryReferencesRequestDescriptor instead')
const QueryReferencesRequest$json = {
  '1': 'QueryReferencesRequest',
  '2': [
    {'1': 'reference', '3': 1, '4': 1, '5': 11, '6': '.userpackage.Reference', '10': 'reference'},
    {'1': 'cursor', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'cursor', '17': true},
    {'1': 'request_events', '3': 3, '4': 1, '5': 11, '6': '.userpackage.QueryReferencesRequestEvents', '9': 1, '10': 'requestEvents', '17': true},
    {'1': 'count_lww_element_references', '3': 4, '4': 3, '5': 11, '6': '.userpackage.QueryReferencesRequestCountLWWElementReferences', '10': 'countLwwElementReferences'},
    {'1': 'count_references', '3': 5, '4': 3, '5': 11, '6': '.userpackage.QueryReferencesRequestCountReferences', '10': 'countReferences'},
  ],
  '8': [
    {'1': '_cursor'},
    {'1': '_request_events'},
  ],
};

/// Descriptor for `QueryReferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryReferencesRequestDescriptor = $convert.base64Decode(
    'ChZRdWVyeVJlZmVyZW5jZXNSZXF1ZXN0EjQKCXJlZmVyZW5jZRgBIAEoCzIWLnVzZXJwYWNrYW'
    'dlLlJlZmVyZW5jZVIJcmVmZXJlbmNlEhsKBmN1cnNvchgCIAEoDEgAUgZjdXJzb3KIAQESVQoO'
    'cmVxdWVzdF9ldmVudHMYAyABKAsyKS51c2VycGFja2FnZS5RdWVyeVJlZmVyZW5jZXNSZXF1ZX'
    'N0RXZlbnRzSAFSDXJlcXVlc3RFdmVudHOIAQESfQocY291bnRfbHd3X2VsZW1lbnRfcmVmZXJl'
    'bmNlcxgEIAMoCzI8LnVzZXJwYWNrYWdlLlF1ZXJ5UmVmZXJlbmNlc1JlcXVlc3RDb3VudExXV0'
    'VsZW1lbnRSZWZlcmVuY2VzUhljb3VudEx3d0VsZW1lbnRSZWZlcmVuY2VzEl0KEGNvdW50X3Jl'
    'ZmVyZW5jZXMYBSADKAsyMi51c2VycGFja2FnZS5RdWVyeVJlZmVyZW5jZXNSZXF1ZXN0Q291bn'
    'RSZWZlcmVuY2VzUg9jb3VudFJlZmVyZW5jZXNCCQoHX2N1cnNvckIRCg9fcmVxdWVzdF9ldmVu'
    'dHM=');

@$core.Deprecated('Use queryReferencesRequestEventsDescriptor instead')
const QueryReferencesRequestEvents$json = {
  '1': 'QueryReferencesRequestEvents',
  '2': [
    {'1': 'from_type', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'fromType', '17': true},
    {'1': 'count_lww_element_references', '3': 2, '4': 3, '5': 11, '6': '.userpackage.QueryReferencesRequestCountLWWElementReferences', '10': 'countLwwElementReferences'},
    {'1': 'count_references', '3': 3, '4': 3, '5': 11, '6': '.userpackage.QueryReferencesRequestCountReferences', '10': 'countReferences'},
  ],
  '8': [
    {'1': '_from_type'},
  ],
};

/// Descriptor for `QueryReferencesRequestEvents`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryReferencesRequestEventsDescriptor = $convert.base64Decode(
    'ChxRdWVyeVJlZmVyZW5jZXNSZXF1ZXN0RXZlbnRzEiAKCWZyb21fdHlwZRgBIAEoBEgAUghmcm'
    '9tVHlwZYgBARJ9Chxjb3VudF9sd3dfZWxlbWVudF9yZWZlcmVuY2VzGAIgAygLMjwudXNlcnBh'
    'Y2thZ2UuUXVlcnlSZWZlcmVuY2VzUmVxdWVzdENvdW50TFdXRWxlbWVudFJlZmVyZW5jZXNSGW'
    'NvdW50THd3RWxlbWVudFJlZmVyZW5jZXMSXQoQY291bnRfcmVmZXJlbmNlcxgDIAMoCzIyLnVz'
    'ZXJwYWNrYWdlLlF1ZXJ5UmVmZXJlbmNlc1JlcXVlc3RDb3VudFJlZmVyZW5jZXNSD2NvdW50Um'
    'VmZXJlbmNlc0IMCgpfZnJvbV90eXBl');

@$core.Deprecated('Use queryReferencesRequestCountLWWElementReferencesDescriptor instead')
const QueryReferencesRequestCountLWWElementReferences$json = {
  '1': 'QueryReferencesRequestCountLWWElementReferences',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
    {'1': 'from_type', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'fromType', '17': true},
  ],
  '8': [
    {'1': '_from_type'},
  ],
};

/// Descriptor for `QueryReferencesRequestCountLWWElementReferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryReferencesRequestCountLWWElementReferencesDescriptor = $convert.base64Decode(
    'Ci9RdWVyeVJlZmVyZW5jZXNSZXF1ZXN0Q291bnRMV1dFbGVtZW50UmVmZXJlbmNlcxIUCgV2YW'
    'x1ZRgBIAEoDFIFdmFsdWUSIAoJZnJvbV90eXBlGAIgASgESABSCGZyb21UeXBliAEBQgwKCl9m'
    'cm9tX3R5cGU=');

@$core.Deprecated('Use queryReferencesRequestCountReferencesDescriptor instead')
const QueryReferencesRequestCountReferences$json = {
  '1': 'QueryReferencesRequestCountReferences',
  '2': [
    {'1': 'from_type', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'fromType', '17': true},
  ],
  '8': [
    {'1': '_from_type'},
  ],
};

/// Descriptor for `QueryReferencesRequestCountReferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryReferencesRequestCountReferencesDescriptor = $convert.base64Decode(
    'CiVRdWVyeVJlZmVyZW5jZXNSZXF1ZXN0Q291bnRSZWZlcmVuY2VzEiAKCWZyb21fdHlwZRgBIA'
    'EoBEgAUghmcm9tVHlwZYgBAUIMCgpfZnJvbV90eXBl');

@$core.Deprecated('Use queryReferencesResponseEventItemDescriptor instead')
const QueryReferencesResponseEventItem$json = {
  '1': 'QueryReferencesResponseEventItem',
  '2': [
    {'1': 'event', '3': 1, '4': 1, '5': 11, '6': '.userpackage.SignedEvent', '10': 'event'},
    {'1': 'counts', '3': 2, '4': 3, '5': 4, '10': 'counts'},
  ],
};

/// Descriptor for `QueryReferencesResponseEventItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryReferencesResponseEventItemDescriptor = $convert.base64Decode(
    'CiBRdWVyeVJlZmVyZW5jZXNSZXNwb25zZUV2ZW50SXRlbRIuCgVldmVudBgBIAEoCzIYLnVzZX'
    'JwYWNrYWdlLlNpZ25lZEV2ZW50UgVldmVudBIWCgZjb3VudHMYAiADKARSBmNvdW50cw==');

@$core.Deprecated('Use queryReferencesResponseDescriptor instead')
const QueryReferencesResponse$json = {
  '1': 'QueryReferencesResponse',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.userpackage.QueryReferencesResponseEventItem', '10': 'items'},
    {'1': 'related_events', '3': 2, '4': 3, '5': 11, '6': '.userpackage.SignedEvent', '10': 'relatedEvents'},
    {'1': 'cursor', '3': 3, '4': 1, '5': 12, '9': 0, '10': 'cursor', '17': true},
    {'1': 'counts', '3': 4, '4': 3, '5': 4, '10': 'counts'},
  ],
  '8': [
    {'1': '_cursor'},
  ],
};

/// Descriptor for `QueryReferencesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryReferencesResponseDescriptor = $convert.base64Decode(
    'ChdRdWVyeVJlZmVyZW5jZXNSZXNwb25zZRJDCgVpdGVtcxgBIAMoCzItLnVzZXJwYWNrYWdlLl'
    'F1ZXJ5UmVmZXJlbmNlc1Jlc3BvbnNlRXZlbnRJdGVtUgVpdGVtcxI/Cg5yZWxhdGVkX2V2ZW50'
    'cxgCIAMoCzIYLnVzZXJwYWNrYWdlLlNpZ25lZEV2ZW50Ug1yZWxhdGVkRXZlbnRzEhsKBmN1cn'
    'NvchgDIAEoDEgAUgZjdXJzb3KIAQESFgoGY291bnRzGAQgAygEUgZjb3VudHNCCQoHX2N1cnNv'
    'cg==');

@$core.Deprecated('Use queryClaimToSystemRequestDescriptor instead')
const QueryClaimToSystemRequest$json = {
  '1': 'QueryClaimToSystemRequest',
  '2': [
    {'1': 'claim_type', '3': 1, '4': 1, '5': 4, '10': 'claimType'},
    {'1': 'trust_root', '3': 2, '4': 1, '5': 11, '6': '.userpackage.PublicKey', '10': 'trustRoot'},
    {'1': 'match_any_field', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'matchAnyField', '17': true},
  ],
  '8': [
    {'1': '_match_any_field'},
  ],
};

/// Descriptor for `QueryClaimToSystemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryClaimToSystemRequestDescriptor = $convert.base64Decode(
    'ChlRdWVyeUNsYWltVG9TeXN0ZW1SZXF1ZXN0Eh0KCmNsYWltX3R5cGUYASABKARSCWNsYWltVH'
    'lwZRI1Cgp0cnVzdF9yb290GAIgASgLMhYudXNlcnBhY2thZ2UuUHVibGljS2V5Ugl0cnVzdFJv'
    'b3QSKwoPbWF0Y2hfYW55X2ZpZWxkGAMgASgJSABSDW1hdGNoQW55RmllbGSIAQFCEgoQX21hdG'
    'NoX2FueV9maWVsZA==');

@$core.Deprecated('Use queryClaimToSystemResponseDescriptor instead')
const QueryClaimToSystemResponse$json = {
  '1': 'QueryClaimToSystemResponse',
  '2': [
    {'1': 'matches', '3': 1, '4': 3, '5': 11, '6': '.userpackage.QueryClaimToSystemResponseMatch', '10': 'matches'},
  ],
};

/// Descriptor for `QueryClaimToSystemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryClaimToSystemResponseDescriptor = $convert.base64Decode(
    'ChpRdWVyeUNsYWltVG9TeXN0ZW1SZXNwb25zZRJGCgdtYXRjaGVzGAEgAygLMiwudXNlcnBhY2'
    'thZ2UuUXVlcnlDbGFpbVRvU3lzdGVtUmVzcG9uc2VNYXRjaFIHbWF0Y2hlcw==');

@$core.Deprecated('Use queryClaimToSystemResponseMatchDescriptor instead')
const QueryClaimToSystemResponseMatch$json = {
  '1': 'QueryClaimToSystemResponseMatch',
  '2': [
    {'1': 'claim', '3': 1, '4': 1, '5': 11, '6': '.userpackage.SignedEvent', '10': 'claim'},
    {'1': 'proof_chain', '3': 2, '4': 3, '5': 11, '6': '.userpackage.SignedEvent', '10': 'proofChain'},
  ],
};

/// Descriptor for `QueryClaimToSystemResponseMatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryClaimToSystemResponseMatchDescriptor = $convert.base64Decode(
    'Ch9RdWVyeUNsYWltVG9TeXN0ZW1SZXNwb25zZU1hdGNoEi4KBWNsYWltGAEgASgLMhgudXNlcn'
    'BhY2thZ2UuU2lnbmVkRXZlbnRSBWNsYWltEjkKC3Byb29mX2NoYWluGAIgAygLMhgudXNlcnBh'
    'Y2thZ2UuU2lnbmVkRXZlbnRSCnByb29mQ2hhaW4=');

@$core.Deprecated('Use queryIndexResponseDescriptor instead')
const QueryIndexResponse$json = {
  '1': 'QueryIndexResponse',
  '2': [
    {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.userpackage.SignedEvent', '10': 'events'},
    {'1': 'proof', '3': 2, '4': 3, '5': 11, '6': '.userpackage.SignedEvent', '10': 'proof'},
  ],
};

/// Descriptor for `QueryIndexResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryIndexResponseDescriptor = $convert.base64Decode(
    'ChJRdWVyeUluZGV4UmVzcG9uc2USMAoGZXZlbnRzGAEgAygLMhgudXNlcnBhY2thZ2UuU2lnbm'
    'VkRXZlbnRSBmV2ZW50cxIuCgVwcm9vZhgCIAMoCzIYLnVzZXJwYWNrYWdlLlNpZ25lZEV2ZW50'
    'UgVwcm9vZg==');

@$core.Deprecated('Use uRLInfoDescriptor instead')
const URLInfo$json = {
  '1': 'URLInfo',
  '2': [
    {'1': 'url_type', '3': 1, '4': 1, '5': 4, '10': 'urlType'},
    {'1': 'body', '3': 2, '4': 1, '5': 12, '10': 'body'},
  ],
};

/// Descriptor for `URLInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uRLInfoDescriptor = $convert.base64Decode(
    'CgdVUkxJbmZvEhkKCHVybF90eXBlGAEgASgEUgd1cmxUeXBlEhIKBGJvZHkYAiABKAxSBGJvZH'
    'k=');

@$core.Deprecated('Use uRLInfoSystemLinkDescriptor instead')
const URLInfoSystemLink$json = {
  '1': 'URLInfoSystemLink',
  '2': [
    {'1': 'system', '3': 1, '4': 1, '5': 11, '6': '.userpackage.PublicKey', '10': 'system'},
    {'1': 'servers', '3': 2, '4': 3, '5': 9, '10': 'servers'},
  ],
};

/// Descriptor for `URLInfoSystemLink`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uRLInfoSystemLinkDescriptor = $convert.base64Decode(
    'ChFVUkxJbmZvU3lzdGVtTGluaxIuCgZzeXN0ZW0YASABKAsyFi51c2VycGFja2FnZS5QdWJsaW'
    'NLZXlSBnN5c3RlbRIYCgdzZXJ2ZXJzGAIgAygJUgdzZXJ2ZXJz');

@$core.Deprecated('Use uRLInfoEventLinkDescriptor instead')
const URLInfoEventLink$json = {
  '1': 'URLInfoEventLink',
  '2': [
    {'1': 'system', '3': 1, '4': 1, '5': 11, '6': '.userpackage.PublicKey', '10': 'system'},
    {'1': 'process', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    {'1': 'logical_clock', '3': 3, '4': 1, '5': 4, '10': 'logicalClock'},
    {'1': 'servers', '3': 4, '4': 3, '5': 9, '10': 'servers'},
  ],
};

/// Descriptor for `URLInfoEventLink`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uRLInfoEventLinkDescriptor = $convert.base64Decode(
    'ChBVUkxJbmZvRXZlbnRMaW5rEi4KBnN5c3RlbRgBIAEoCzIWLnVzZXJwYWNrYWdlLlB1YmxpY0'
    'tleVIGc3lzdGVtEi4KB3Byb2Nlc3MYAiABKAsyFC51c2VycGFja2FnZS5Qcm9jZXNzUgdwcm9j'
    'ZXNzEiMKDWxvZ2ljYWxfY2xvY2sYAyABKARSDGxvZ2ljYWxDbG9jaxIYCgdzZXJ2ZXJzGAQgAy'
    'gJUgdzZXJ2ZXJz');

@$core.Deprecated('Use uRLInfoDataLinkDescriptor instead')
const URLInfoDataLink$json = {
  '1': 'URLInfoDataLink',
  '2': [
    {'1': 'system', '3': 1, '4': 1, '5': 11, '6': '.userpackage.PublicKey', '10': 'system'},
    {'1': 'process', '3': 2, '4': 1, '5': 11, '6': '.userpackage.Process', '10': 'process'},
    {'1': 'servers', '3': 3, '4': 3, '5': 9, '10': 'servers'},
    {'1': 'byte_count', '3': 4, '4': 1, '5': 4, '10': 'byteCount'},
    {'1': 'sections', '3': 5, '4': 3, '5': 11, '6': '.userpackage.Range', '10': 'sections'},
    {'1': 'mime', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'mime', '17': true},
  ],
  '8': [
    {'1': '_mime'},
  ],
};

/// Descriptor for `URLInfoDataLink`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uRLInfoDataLinkDescriptor = $convert.base64Decode(
    'Cg9VUkxJbmZvRGF0YUxpbmsSLgoGc3lzdGVtGAEgASgLMhYudXNlcnBhY2thZ2UuUHVibGljS2'
    'V5UgZzeXN0ZW0SLgoHcHJvY2VzcxgCIAEoCzIULnVzZXJwYWNrYWdlLlByb2Nlc3NSB3Byb2Nl'
    'c3MSGAoHc2VydmVycxgDIAMoCVIHc2VydmVycxIdCgpieXRlX2NvdW50GAQgASgEUglieXRlQ2'
    '91bnQSLgoIc2VjdGlvbnMYBSADKAsyEi51c2VycGFja2FnZS5SYW5nZVIIc2VjdGlvbnMSFwoE'
    'bWltZRgGIAEoCUgAUgRtaW1liAEBQgcKBV9taW1l');

