import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
  
  String get message;
  
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String message;
  final int? statusCode;
  
  const ServerFailure(this.message, [this.statusCode]);
  
  @override
  List<Object> get props => [message, statusCode ?? 0];
}

class NetworkFailure extends Failure {
  final String message;
  
  const NetworkFailure(this.message);
  
  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  final String message;
  
  const CacheFailure(this.message);
  
  @override
  List<Object> get props => [message];
}

class ValidationFailure extends Failure {
  final String message;
  final String? field;
  
  const ValidationFailure(this.message, [this.field]);
  
  @override
  List<Object> get props => [message, field ?? ''];
}

class AuthenticationFailure extends Failure {
  final String message;
  
  const AuthenticationFailure(this.message);
  
  @override
  List<Object> get props => [message];
}

class UnknownFailure extends Failure {
  final String message;
  
  const UnknownFailure(this.message);
  
  @override
  List<Object> get props => [message];
}
