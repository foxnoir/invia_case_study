import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class NoConnectivityException extends DioException with EquatableMixin {
  NoConnectivityException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions, error: 'NoConnectivityException');

  @override
  String get message => 'No internet connection.';

  final int statusCode = 0;

  @override
  List<Object> get props => [message, statusCode];
}

class DatabaseException extends Equatable implements Exception {
  const DatabaseException({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
