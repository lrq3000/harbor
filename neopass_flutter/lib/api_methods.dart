import 'package:http/http.dart' as http;

import 'protocol.pb.dart' as protocol;

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
    print(err);
  }
}

Future<bool> requestVerification(
  protocol.Pointer pointer,
  String claimType,
) async {
  final url = "https://autoupdate.unkto.com/verifiers/"
      "${claimType.toLowerCase}"
      "/api/v1/vouch";

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
      },
      body: pointer.writeToBuffer(),
    );

    checkResponse('postEvents', response);

    return true;
  } catch (err) {
    print(err);
  }

  return false;
}
