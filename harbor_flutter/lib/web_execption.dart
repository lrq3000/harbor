class WebException implements Exception {
  final int statusCode;
  final String endpointName;
  final String response;
  final String message;

  WebException(this.statusCode, this.endpointName, this.response, [this.message = ""]);

  @override
  String toString() {
    return "$endpointName, $statusCode, $response, $message";
  }
}
