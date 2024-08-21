import '/index.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMsgModel;

  const ServerException({required this.errorMsgModel});
}

class LocalDatabaseException implements Exception {
  final String message;

  const LocalDatabaseException({required this.message});
}
