class NetworkException implements Exception {}

class ServerException implements Exception {}

class DataException implements Exception {
  final String message;

  DataException({required this.message});
}
