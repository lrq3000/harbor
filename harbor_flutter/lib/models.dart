import 'dart:convert';

import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:flutter/foundation.dart';
import 'package:harbor_flutter/protocol.pb.dart';

import 'protocol.pb.dart' as protocol;

class SystemState {
  List<String> servers = [];
  List<Process> processes = [];
  String username = '';
  String description = '';
  String store = '';
  Pointer? avatar;
  Pointer? banner;

  SystemState({
    required this.servers,
    required this.processes,
    required this.username,
    required this.description,
    required this.store,
    this.avatar,
    this.banner,
  });

  @override
  String toString() {
    return "(servers: $servers, processes: $processes, username: $username, description: $description, store: $store, avatar: $avatar, banner: $banner)";
  }

  static SystemState fromStorageTypeSystemState(StorageTypeSystemState state) {
    List<String> servers = [];
    servers = state.crdtSetItems
        .where((item) =>
            item.contentType == ContentType.contentTypeServer &&
            item.operation == LWWElementSet_Operation.ADD)
        .map((item) => utf8.decode(item.value))
        .toList();

    List<Process> processes = List.from(state.processes);

    String username = '';
    String description = '';
    String store = '';
    Pointer? avatar;
    Pointer? banner;

    for (var item in state.crdtItems) {
      if (item.contentType == ContentType.contentTypeUsername) {
        username = utf8.decode(item.value);
      } else if (item.contentType == ContentType.contentTypeDescription) {
        description = utf8.decode(item.value);
      } else if (item.contentType == ContentType.contentTypeStore) {
        store = utf8.decode(item.value);
      } else if (item.contentType == ContentType.contentTypeAvatar) {
        avatar = protocol.Pointer.fromBuffer(item.value);
      } else if (item.contentType == ContentType.contentTypeBanner) {
        banner = protocol.Pointer.fromBuffer(item.value);
      }
    }

    return SystemState(
      servers: servers,
      processes: processes,
      username: username,
      description: description,
      store: store,
      avatar: avatar,
      banner: banner,
    );
  }
}

class StorageTypeSystemState {
  final List<StorageTypeCRDTSetItem> crdtSetItems = List.empty(growable: true);
  final List<Process> processes = List.empty(growable: true);
  final List<StorageTypeCRDTItem> crdtItems = List.empty(growable: true);

  void update(Event event) {
    if (event.hasLwwElementSet()) {
      int foundIndex = crdtSetItems.indexWhere((item) =>
          item.contentType == event.contentType &&
          listEquals(item.value, event.lwwElementSet.value));

      bool found = false;
      if (foundIndex != -1) {
        var foundItem = crdtSetItems[foundIndex];
        if (foundItem.unixMilliseconds < event.lwwElementSet.unixMilliseconds) {
          foundItem.operation = event.lwwElementSet.operation;
          foundItem.unixMilliseconds = event.lwwElementSet.unixMilliseconds;
          found = true;
        }
      }

      if (!found) {
        crdtSetItems.add(StorageTypeCRDTSetItem()
            ..contentType = event.contentType
            ..value = event.lwwElementSet.value
            ..unixMilliseconds = event.lwwElementSet.unixMilliseconds
            ..operation = event.lwwElementSet.operation);
      }
    }

    if (event.hasLwwElement()) {
      int foundIndex = crdtItems.indexWhere((item) => item.contentType == event.contentType);
      bool found = false;
      if (foundIndex != -1) {
        var foundItem = crdtItems[foundIndex];
        if (foundItem.unixMilliseconds < event.lwwElement.unixMilliseconds) {
          foundItem.value = event.lwwElement.value;
          foundItem.unixMilliseconds = event.lwwElement.unixMilliseconds;
          found = true;
        }
      }

      if (!found) {
        crdtItems.add(StorageTypeCRDTItem()
          ..contentType = event.contentType
          ..value = event.lwwElement.value
          ..unixMilliseconds = event.lwwElement.unixMilliseconds);
      }
    }

    bool foundProcess = false;
    for (var rawProcess in processes) {
      if (rawProcess == event.process) {
        foundProcess = true;
        break;
      }
    }

    if (!foundProcess) {
      processes.add(event.process);
    }
  }
}

class ContentType {
  static final contentTypeDelete = fixnum.Int64(1);
  static final contentTypeSystemProcesses = fixnum.Int64(2);
  static final contentTypePost = fixnum.Int64(3);
  static final contentTypeFollow = fixnum.Int64(4);
  static final contentTypeUsername = fixnum.Int64(5);
  static final contentTypeDescription = fixnum.Int64(6);
  static final contentTypeBlobMeta = fixnum.Int64(7);
  static final contentTypeBlobSection = fixnum.Int64(8);
  static final contentTypeAvatar = fixnum.Int64(9);
  static final contentTypeServer = fixnum.Int64(10);
  static final contentTypeVouch = fixnum.Int64(11);
  static final contentTypeClaim = fixnum.Int64(12);
  static final contentTypeBanner = fixnum.Int64(13);
  static final contentTypeOpinion = fixnum.Int64(14);
  static final contentTypeStore = fixnum.Int64(15);
}

class ClaimType {
  static const claimTypeHackerNews = "HackerNews";
  static const claimTypeYouTube = "YouTube";
  static const claimTypeOdysee = "Odysee";
  static const claimTypeRumble = "Rumble";
  static const claimTypeTwitter = "Twitter";
  static const claimTypeBitcoin = "Bitcoin";
  static const claimTypeGeneric = "Generic";
  static const claimTypeUrl = "URL";
  static const claimTypeDiscord = "Discord";
  static const claimTypeInstagram = "Instagram";
  static const claimTypeTwitch = "Twitch";
  static const claimTypePatreon = "Patreon";
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

protocol.URLInfoEventLink urlInfoGetEventLink(
  protocol.URLInfo proto,
) {
  if (!(proto.urlType == URLInfoType.urlInfoTypeEventLink)) {
    throw "expected urlInfoTypeEventLink";
  }

  return protocol.URLInfoEventLink.fromBuffer(proto.body);
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
