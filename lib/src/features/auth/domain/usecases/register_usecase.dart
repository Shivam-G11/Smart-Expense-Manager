import 'package:dartz/dartz.dart';
import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/errors/exceptions.dart';

class RegisterUseCase {
  final AuthRepository repository;
  
  RegisterUseCase(this.repository);
  
  Future<Either<Failure, AuthResponse>> call(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      return const Left(ValidationFailure('Name, email, and password are required'));
    }
    
    if (name.length < 2) {
      return const Left(ValidationFailure('Name must be at least 2 characters'));
    }
    
    if (!_isValidEmail(email)) {
      return const Left(ValidationFailure('Invalid email format'));
    }
    
    if (password.length < 6) {
      return const Left(ValidationFailure('Password must be at least 6 characters'));
    }
    
    return await repository.register(name, email, password);
  }
  
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
