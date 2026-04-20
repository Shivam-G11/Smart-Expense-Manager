import 'package:dartz/dartz.dart';
import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/errors/exceptions.dart';

class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  Future<Either<Failure, AuthResponse>> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return const Left(ValidationFailure('Email and password are required'));
    }
    
    if (!_isValidEmail(email)) {
      return const Left(ValidationFailure('Invalid email format'));
    }
    
    return await repository.login(email, password);
  }
  
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
