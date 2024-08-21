import '/index.dart';

class AuthenticationModel extends AuthenticationEntity {
  const AuthenticationModel({
    required super.status,
    required super.code,
    required super.message,
    required super.data,
  });
  factory AuthenticationModel.fromJson(Map<String, Object?> json) =>
      AuthenticationModel(
        status: json['status'] as bool,
        code: json['code'] as int,
        message: json['message'] as String,
        data: DataModel.fromJson(json['data'] as Map<String, Object?>),
      );

  @override
  String toString() {
    return '''AuthenticationResponse(
        status:$status,
        code:$code,
        message:$message,
        data:${data.toString()}
    ) ''';
  }
}

class DataModel extends Authentication {
  const DataModel({
    required super.id,
    required super.name,
    required super.firstName,
    required super.lastName,
    required super.avatar,
    required super.phone,
    required super.email,
    required super.token,
    required super.gender,
    required super.status,
    required super.createdAt,
    required super.role,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json['id'],
        name: json['name'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        avatar: json['avatar'],
        phone: json['phone'],
        email: json['email'],
        role: json['role'],
        token: json['token'],
        gender: json['gender'],
        status: json['status'],
        createdAt: json['created_at'],
      );
}
