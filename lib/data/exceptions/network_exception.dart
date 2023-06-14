class NetworkException implements Exception {
  final String request;
  final int? errorCode;
  final String? errorName;

  NetworkException({
    required this.request,
    this.errorCode,
    this.errorName,
  });

  @override
  String toString() {
    return "An error occurred in the request '$request': $errorCode $errorName";
  }
}
