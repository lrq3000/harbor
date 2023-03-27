import 'package:http/http.dart' as HTTP;

import 'protocol.pb.dart' as Protocol;

Future<void> postEvents(Protocol.Events payload) async {
  try {
    final response = await HTTP.post(
      Uri.parse('https://srv1-stg.polycentric.io/events'),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
      },
      body: payload.writeToBuffer(),
    );

    if (response.statusCode != 200) {
      print('post events failed');
      print(response.statusCode);
      print(response.body);
    }
  } catch (err) {
    print(err);
  }
}

Future<bool> requestVerification(
  Protocol.Pointer pointer,
  String claimType,
) async {
  final url = "https://autoupdate.unkto.com/verifiers/" +
    claimType.toLowerCase() +
    "/api/v1/vouch";

  try {
    final response = await HTTP.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
      },
      body: pointer.writeToBuffer(),
    );
 
    if (response.statusCode != 200) {
      print('request verification failed');
      print(response.statusCode);
      print(response.body);

      return false;
    } else {
      return true;
    }
  } catch (err) {
    print(err);
  }

  return false;
}

