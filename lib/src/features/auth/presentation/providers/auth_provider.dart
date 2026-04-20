import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/entities/auth_response.dart';
import '../../../../core/errors/exceptions.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final User? user;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    User? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthNotifier(this._loginUseCase, this._registerUseCase)
      : super(const AuthState()) {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isAuthenticated = prefs.getBool('is_authenticated') ?? false;
      
      if (isAuthenticated) {
        final userName = prefs.getString('user_name') ?? '';
        final userEmail = prefs.getString('user_email') ?? '';
        final userId = prefs.getString('user_id') ?? '1';
        
        final user = User(
          id: userId,
          email: userEmail,
          name: userName,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        state = state.copyWith(
          isAuthenticated: true,
          user: user,
        );
        
        print('Auth state loaded from storage: $userName');
      }
    } catch (e) {
      print('Error loading auth state: $e');
    }
  }

  Future<void> _saveAuthState({
    required bool isAuthenticated,
    User? user,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_authenticated', isAuthenticated);
      
      if (user != null) {
        await prefs.setString('user_name', user.name);
        await prefs.setString('user_email', user.email);
        await prefs.setString('user_id', user.id);
      }
      
      print('Auth state saved to storage');
    } catch (e) {
      print('Error saving auth state: $e');
    }
  }

  Future<void> _clearAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print('Auth state cleared from storage');
    } catch (e) {
      print('Error clearing auth state: $e');
    }
  }

  Future<void> login(String email, String password) async {
    print('AuthNotifier: Login started for email: $email');
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _loginUseCase(email, password);
    
    result.fold(
      (failure) {
        print('AuthNotifier: Login failed - ${failure.message}');
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (authResponse) async {
        print('AuthNotifier: Login successful - User: ${authResponse.user.name}');
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: authResponse.user,
          error: null,
        );
        
        // Save auth state to persistent storage
        await _saveAuthState(
          isAuthenticated: true,
          user: authResponse.user,
        );
      },
    );
  }

  Future<void> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _registerUseCase(name, email, password);
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (authResponse) async {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: authResponse.user,
          error: null,
        );
        
        // Save auth state to persistent storage
        await _saveAuthState(
          isAuthenticated: true,
          user: authResponse.user,
        );
      },
    );
  }

  Future<void> logout() async {
    state = const AuthState();
    await _clearAuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  // TODO: Implement actual use cases
  // final loginUseCase = ref.watch(loginUseCaseProvider);
  // final registerUseCase = ref.watch(registerUseCaseProvider);
  // return AuthNotifier(loginUseCase, registerUseCase);
  
  // Temporary implementation
  return AuthNotifier(
    MockLoginUseCase(),
    MockRegisterUseCase(),
  );
});

// Mock implementations for now
class MockLoginUseCase extends LoginUseCase {
  MockLoginUseCase() : super(MockAuthRepository());
}

class MockRegisterUseCase extends RegisterUseCase {
  MockRegisterUseCase() : super(MockAuthRepository());
}

class MockAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, AuthResponse>> login(String email, String password) async {
    print('MockAuthRepository: Checking credentials - Email: "$email", Password: "$password"');
    await Future.delayed(const Duration(seconds: 1));
    
    if (email == 'test@example.com' && password == 'password') {
      print('MockAuthRepository: Credentials match - Login successful');
      final user = User(
        id: '1',
        email: email,
        name: 'Test User',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      return Right(AuthResponse(
        user: user,
        accessToken: 'mock_token',
        refreshToken: 'mock_refresh_token',
      ));
    }
    print('MockAuthRepository: Credentials do not match - Login failed');
    return const Left(AuthenticationFailure('Invalid email or password'));
  }

  @override
  Future<Either<Failure, AuthResponse>> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = User(
      id: '1',
      email: email,
      name: name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return Right(AuthResponse(
      user: user,
      accessToken: 'mock_token',
      refreshToken: 'mock_refresh_token',
    ));
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> refreshToken(String refreshToken) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> updateProfile(Map<String, dynamic> userData) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Stream<User?> get userChanges {
    // TODO: implement userChanges
    throw UnimplementedError();
  }
}

