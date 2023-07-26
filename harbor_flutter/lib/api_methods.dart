import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:http/http.dart' as http;
import 'web_execption.dart';
import 'protocol.pb.dart' as protocol;
import 'logger.dart';

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

Future<protocol.Events> getQueryLatest(
    String server, protocol.PublicKey system, List<Int64> eventTypes) async {
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

Future<void> requestVerification(protocol.Pointer pointer, String claimType,
    {String? challengeResponse}) async {
  var url = "https://verifiers.grayjay.app/"
      "${claimType.toLowerCase()}"
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
  String claimType,
) async {
  final url = "https://verifiers.grayjay.app/"
      "${claimType.toLowerCase()}"
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
  String claimType,
) async {
  final url = "https://verifiers.grayjay.app/"
      "${claimType.toLowerCase()}"
      "/api/v1/oauth_handle?token=$token";

  final response = await http.get(
    Uri.parse(url),
  );

  checkResponse('getOAuthUsername', response);

  return convert.jsonDecode(response.body);
}
