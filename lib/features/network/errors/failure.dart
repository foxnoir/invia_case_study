import 'package:equatable/equatable.dart';
import 'package:invia_case_study/features/network/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  ApiFailure.fromException(ApiException exception)
      : super(message: exception.message, statusCode: exception.statusCode);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message, super.statusCode});

  @override
  String toString() => 'DatabaseFailure: $message';
}
