import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'protocol.pb.dart' as protocol;
import 'logger.dart';

void checkResponse(String name, http.Response response) {
  if (response.statusCode != 200) {
    final err = "$name, ${response.statusCode}, ${response.body}";
    throw Exception(err);
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

Future<void> requestVerification(protocol.Pointer pointer, String claimType,
    {String? challengeResponse}) async {
  //var url = "https://verifiers.grayjay.app/"
  //    "${claimType.toLowerCase()}"
  //    "/api/v1/vouch";

  var url = "http://10.0.0.121:3005/api/v1/vouch";

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
  //final url = "https://verifiers.grayjay.app/"
  //    "${claimType.toLowerCase()}"
  //    "/api/v1/oauth";

  final url = "http://10.0.0.121:3005/api/v1/oauth";

  final response = await http.get(
    Uri.parse(url),
  );

  checkResponse('getOAuthURL', response);

  final oAuthUrl = convert.jsonDecode(response.body)["url"];
  return oAuthUrl;
}

Future<dynamic> getOAuthUsername(
  String token,
  String claimType,
) async {
  //final url = "https://verifiers.grayjay.app/"
  //    "${claimType.toLowerCase()}"
  //    "/api/v1/oauth";
  final url = "http://10.0.0.121:3005/api/v1/oauth_handle?token=" + token;

  final response = await http.get(
    Uri.parse(url),
  );

  checkResponse('getOAuthURL', response);

  return convert.jsonDecode(response.body);
}
