import 'dart:convert' as convert;
import 'dart:typed_data';
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:http/http.dart' as http;

import 'web_execption.dart';
import 'protocol.pb.dart' as protocol;
import 'models.dart' as models;
import 'logger.dart';

// const authorityServer = "https://verifiers.grayjay.app";
const authorityServer = "http://10.10.10.58:9000";

void checkResponse(String name, http.Response response) {
  if (response.statusCode != 200) {
    throw WebException(response.statusCode, name, response.body);
  }
}

Future<void> postEvents(String server, protocol.Events payload) async {
  try {
    final url = "$server/events";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
      },
      body: payload.writeToBuffer(),
    );

    checkResponse('postEvents', response);
  } catch (err) {
    logger.w(err);
  }
}

Future<protocol.RangesForSystem> getRanges(
  String server,
  protocol.PublicKey system,
) async {
  final systemQuery = convert.base64Url.encode(system.writeToBuffer());

  final url = "$server/ranges?system=$systemQuery";

  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/octet-stream',
    },
  );

  checkResponse('getRanges', response);

  return protocol.RangesForSystem.fromBuffer(response.bodyBytes);
}

Future<protocol.Events> getEvents(
  String server,
  protocol.PublicKey system,
  protocol.RangesForSystem ranges,
) async {
  final systemQuery = convert.base64Url.encode(system.writeToBuffer());

  final rangesQuery = convert.base64Url.encode(ranges.writeToBuffer());

  final url = "$server/events?system=$systemQuery&ranges=$rangesQuery";

  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/octet-stream',
    },
  );

  checkResponse('getEvents', response);

  return protocol.Events.fromBuffer(response.bodyBytes);
}

Future<protocol.QueryReferencesResponse> getQueryReferences(
  String server,
  protocol.Reference reference,
  Uint8List? cursor,
  protocol.QueryReferencesRequestEvents? requestEvents,
  List<protocol.QueryReferencesRequestCountLWWElementReferences>?
      countLwwElementReferences,
  List<protocol.QueryReferencesRequestCountReferences>? countReferences,
) async {
  final request = protocol.QueryReferencesRequest()..reference = reference;

  if (requestEvents != null) {
    request.requestEvents = requestEvents;
  }

  if (cursor != null) {
    request.cursor = cursor;
  }

  if (countLwwElementReferences != null) {
    request.countLwwElementReferences.addAll(countLwwElementReferences);
  }

  if (countReferences != null) {
    request.countReferences.addAll(countReferences);
  }

  final encodedQuery = convert.base64Url.encode(request.writeToBuffer());
  final url = "$server/query_references?query=$encodedQuery";

  final response = await http.get(Uri.parse(url), headers: <String, String>{
    'Content-Type': 'application/octet-stream',
  });

  checkResponse('getQueryReferences', response);

  return protocol.QueryReferencesResponse.fromBuffer(response.bodyBytes);
}

Future<protocol.Events> getQueryLatest(String server, protocol.PublicKey system,
    List<fixnum.Int64> eventTypes) async {
  final systemQuery = convert.base64Url.encode(system.writeToBuffer());

  final eventTypesBuilder = protocol.RepeatedUInt64()
    ..numbers.addAll(eventTypes);

  final eventTypesQuery =
      convert.base64Url.encode(eventTypesBuilder.writeToBuffer());

  final url =
      "$server/query_latest?system=$systemQuery&event_types=$eventTypesQuery";
  final response = await http.get(Uri.parse(url),
      headers: <String, String>{'Content-Type': 'application/octet-stream'});

  checkResponse('getQueryLatest', response);

  return protocol.Events.fromBuffer(response.bodyBytes);
}

Future<List<protocol.ClaimFieldEntry>> getClaimFieldsByUrl(
  fixnum.Int64 claimType,
  String subject,
) async {
  final url = "$authorityServer/platforms"
      "/${models.ClaimType.claimTypeToString(claimType)}"
      "/text/getClaimFieldsByUrl";

  logger.d(subject);

  final Map<String, String> body = {};
  body["url"] = subject;

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: convert.jsonEncode(body),
  );

  checkResponse('getClaimFieldsByUrl', response);

  logger.d(response.body);

  final List<dynamic> decoded = convert.jsonDecode(
    response.body,
  ) as List<dynamic>;

  final List<protocol.ClaimFieldEntry> result = [];

  for (final itemDynamic in decoded) {
    final item = itemDynamic as Map<String, dynamic>;

    final entry = protocol.ClaimFieldEntry()
      ..key = fixnum.Int64(item['key'] as int)
      ..value = item['value'] as String;

    result.add(entry);
  }

  for (final entry in result) {
    logger.d("${entry.key} ${entry.value}");
  }

  return result;
}

Future<void> requestVerification(
    protocol.Pointer pointer, fixnum.Int64 claimType,
    {String? challengeResponse}) async {
  var url = "$authorityServer${claimType.toString()}"
      "/api/v1/vouch";

  if (challengeResponse != null) {
    url += "?challengeResponse=$challengeResponse";
  }
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/octet-stream',
    },
    body: pointer.writeToBuffer(),
  );

  checkResponse('requestVerification', response);
}

Future<String> getOAuthURL(
  fixnum.Int64 claimType,
) async {
  final url = "$authorityServer/${claimType.toString()}"
      "/api/v1/oauth";

  final response = await http.get(
    Uri.parse(url),
  );

  checkResponse('getOAuthURL', response);

  final oAuthUrl = convert.jsonDecode(response.body)["url"] as String;

  return oAuthUrl;
}

Future<dynamic> getOAuthUsername(
  String token,
  fixnum.Int64 claimType,
) async {
  final url = "$authorityServer/${claimType.toString()}"
      "/api/v1/oauth_handle?token=$token";

  final response = await http.get(
    Uri.parse(url),
  );

  checkResponse('getOAuthUsername', response);

  return convert.jsonDecode(response.body);
}
