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

Future<void> postEvents(protocol.Events payload) async {
  try {
    final response = await http.post(
      Uri.parse('https://srv1-stg.polycentric.io/events'),
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

Future<bool> requestVerification(
  protocol.Pointer pointer,
  String claimType,
) async {
  final url = "https://autoupdate.unkto.com/verifiers/"
      "${claimType.toLowerCase()}"
      "/api/v1/vouch";

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
      },
      body: pointer.writeToBuffer(),
    );

    checkResponse('requestVerification', response);

    return true;
  } catch (err) {
    logger.w(err);
  }

  return false;
}
