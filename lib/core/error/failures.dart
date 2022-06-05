import 'package:equatable/equatable.dart';
import 'package:genderize/core/util/constant_error_message.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ConnectionFailure extends Failure {
  final String errorMessage = ConstantErrorMessage().connectionError;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $errorMessage}';
  }
}

class GenderNotFoundFailure extends Failure {
  @override
  List<Object?> get props => [];
}
