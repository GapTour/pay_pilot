// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterParams {
  final String email;
  final String password;
  final int permissionID;

  RegisterParams({
    required this.email,
    required this.password,
    required this.permissionID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'permission_id': permissionID,
    };
  }
}
