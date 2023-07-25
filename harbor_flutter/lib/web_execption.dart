class WebException implements Exception {
  final int statusCode;
  final String endpointName;
  final String response;

  WebException(this.statusCode, this.endpointName, this.response);

  @override
  String toString() {
    return "$endpointName, $statusCode, $response";
  }
}
