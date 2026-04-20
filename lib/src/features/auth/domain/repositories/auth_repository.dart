import 'package:dartz/dartz.dart';
import '../entities/auth_response.dart';
import '../entities/user.dart';
import '../../../../core/errors/exceptions.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login(String email, String password);
  Future<Either<Failure, AuthResponse>> register(String name, String email, String password);
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, String>> refreshToken(String refreshToken);
  Future<Either<Failure, User>> updateProfile(Map<String, dynamic> userData);
  Stream<User?> get userChanges;
}
