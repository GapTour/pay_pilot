class LoginResponse {
  final String access;
  final String refresh;
  final DateTime expiresIn;

  LoginResponse({
    required this.access,
    required this.refresh,
    required this.expiresIn,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      access: map['access_token'] as String,
      refresh: map['refresh_token'] as String,
      expiresIn: DateTime.parse(map['expires_in']),
    );
  }
}
