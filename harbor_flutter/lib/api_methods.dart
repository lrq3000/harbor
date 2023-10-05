import 'dart:convert' as convert;
import 'dart:io' as dart_io;
import 'dart:typed_data';
import 'dart:collection';
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:http/http.dart' as http;

import 'web_execption.dart';
import 'protocol.pb.dart' as protocol;
import 'logger.dart';

class AuthorityException implements Exception {
  final String message;

  AuthorityException(this.message);
}

void checkAuthorityResponse(final String name, final http.Response response) {
  if (response.statusCode == 200) {
    return;
  }

  final Map<String, dynamic> fields =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

  throw AuthorityException(fields['message'] as String);
}

const authorityServer = "https://verifiers.polycentric.io";

void checkResponse(final String name, final http.Response response) {
  if (response.statusCode != 200) {
    throw WebException(response.statusCode, name, response.body);
  }
}

Future<void> postEvents(
    final String server, final protocol.Events payload) async {
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
  final String server,
  final protocol.PublicKey system,
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
  final String server,
  final protocol.PublicKey system,
  final protocol.RangesForSystem ranges,
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
  final String server,
  final protocol.Reference reference,
  final UnmodifiableUint8ListView? cursor,
  final protocol.QueryReferencesRequestEvents? requestEvents,
  final List<protocol.QueryReferencesRequestCountLWWElementReferences>?
      countLwwElementReferences,
  final List<protocol.QueryReferencesRequestCountReferences>? countReferences,
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
    final String server,
    final protocol.PublicKey system,
    final UnmodifiableListView<fixnum.Int64> eventTypes) async {
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
  final fixnum.Int64 claimType,
  final String subject,
) async {
  try {
    final url = "$authorityServer/platforms"
        "/${claimType.toString()}"
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

    checkAuthorityResponse('getClaimFieldsByUrl', response);

    logger.d(response.statusCode);
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
  } on dart_io.SocketException {
    throw AuthorityException("Failed to connect to authority");
  }
}

Future<void> requestVerification(
    final protocol.Pointer pointer, final fixnum.Int64 claimType,
    {final String? challengeResponse}) async {
  try {
    final verifierType = challengeResponse != null ? "oauth" : "text";

    var url = "$authorityServer/platforms"
        "/${claimType.toString()}"
        "/$verifierType/vouch";

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

    checkAuthorityResponse('requestVerification', response);
  } on dart_io.SocketException {
    throw AuthorityException("Failed to connect to authority");
  }
}

Future<String> getOAuthURL(
  final fixnum.Int64 claimType,
) async {
  final url = "$authorityServer/platforms"
      "/${claimType.toString()}"
      "/oauth/url";

  final response = await http.get(
    Uri.parse(url),
  );

  return convert.jsonDecode(response.body) as String;
}

class GetOAuthUsernameResponse {
  final String username;
  final String token;

  const GetOAuthUsernameResponse(this.username, this.token);
}

Future<GetOAuthUsernameResponse> getOAuthUsername(
  final String token,
  final fixnum.Int64 claimType,
) async {
  final url = "$authorityServer/platforms"
      "/${claimType.toString()}"
      "/oauth/token$token";

  final response = await http.get(
    Uri.parse(url),
  );

  checkResponse('getOAuthUsername', response);

  final parsed = convert.jsonDecode(response.body);

  return GetOAuthUsernameResponse(
    parsed["username"] as String,
    parsed["token"] as String,
  );
}

Future<protocol.HarborChallengeResponse> getChallenge(final Uri link) async {
  final response = await http.get(Uri.parse("${link.toString()}/challenge"));

  checkResponse('getChallenge', response);

  return protocol.HarborChallengeResponse.fromBuffer(response.bodyBytes);
}

Future<String> postValidate(
  final Uri link,
  final protocol.HarborValidateRequest request,
) async {
  final response = await http.post(
    Uri.parse("${link.toString()}/validate"),
    headers: <String, String>{
      'Content-Type': 'application/octet-stream',
    },
    body: request.writeToBuffer(),
  );

  checkResponse('getChallenge', response);

  return response.bodyBytes.toString();
}
