import 'package:equatable/equatable.dart';
import 'user.dart';

class AuthResponse extends Equatable {
  final User user;
  final String accessToken;
  final String refreshToken;
  
  const AuthResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });
  
  @override
  List<Object> get props => [user, accessToken, refreshToken];
  
  AuthResponse copyWith({
    User? user,
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthResponse(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
  
  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      user: User.fromMap(map['user']),
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }
}
