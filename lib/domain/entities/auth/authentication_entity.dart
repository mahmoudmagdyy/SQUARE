import 'package:aqarat/index.dart';

class AuthenticationEntity extends Equatable {
  final bool status;
  final int code;
  final String message;
  final Authentication data;
  const AuthenticationEntity({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [status, code, message, data];
}

class Authentication extends Equatable {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final String avatar;
  final String phone;
  final String email;
  final String role;
  final String token;
  final String gender;
  final String status;
  final String createdAt;
  const Authentication({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.phone,
    required this.email,
    required this.role,
    required this.token,
    required this.gender,
    required this.status,
    required this.createdAt,
  });
  Authentication copyWith({
    int? id,
    String? name,
    String? firstName,
    String? lastName,
    String? avatar,
    String? phone,
    String? email,
    String? token,
    String? gender,
    String? status,
    String? createdAt,
    String? role,
  }) =>
      Authentication(
        id: id ?? this.id,
        name: name ?? this.name,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        role: role ?? this.role,
        token: token ?? this.token,
        gender: gender ?? this.gender,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  String toString() {
    return '''SignUpEntity(
id:$id,
name:$name,
firstName:$firstName,
lastName:$lastName,
avatar:$avatar,
phone:$phone,
email:$email,
token:$token,
gender:$gender,
status:$status,
createdAt:$createdAt

    ) ''';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        firstName,
        lastName,
        avatar,
        phone,
        email,
        role,
        token,
        gender,
        status,
        createdAt,
      ];
}

/* 
class Data {
  final int? id;
  final String? name;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? avatar;
  final String? phone;
  final String? email;
  final String? token;
  final String? gender;
  final String? status;
  final String? createdAt;
  const Data(
      {this.id,
      this.name,
      this.firstName,
      this.middleName,
      this.lastName,
      this.avatar,
      this.phone,
      this.email,
      this.token,
      this.gender,
      this.status,
      this.createdAt});
  Data copyWith(
      {int? id,
      String? name,
      String? firstName,
      String? middleName,
      String? lastName,
      String? avatar,
      String? phone,
      String? email,
      String? token,
      String? gender,
      String? status,
      String? createdAt}) {
    return Data(
        id: id ?? this.id,
        name: name ?? this.name,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        token: token ?? this.token,
        gender: gender ?? this.gender,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'avatar': avatar,
      'phone': phone,
      'email': email,
      'token': token,
      'gender': gender,
      'status': status,
      'created_at': createdAt
    };
  }

  static Data fromJson(Map<String, Object?> json) {
    return Data(
        id: json['id'] == null ? null : json['id'] as int,
        name: json['name'] == null ? null : json['name'] as String,
        firstName:
            json['first_name'] == null ? null : json['first_name'] as String,
        middleName:
            json['middle_name'] == null ? null : json['middle_name'] as String,
        lastName:
            json['last_name'] == null ? null : json['last_name'] as String,
        avatar: json['avatar'] == null ? null : json['avatar'] as String,
        phone: json['phone'] == null ? null : json['phone'] as String,
        email: json['email'] == null ? null : json['email'] as String,
        token: json['token'] == null ? null : json['token'] as String,
        gender: json['gender'] == null ? null : json['gender'] as String,
        status: json['status'] == null ? null : json['status'] as String,
        createdAt:
            json['created_at'] == null ? null : json['created_at'] as String);
  }

  @override
  String toString() {
    return '''Data(
                id:$id,
name:$name,
firstName:$firstName,
middleName:$middleName,
lastName:$lastName,
avatar:$avatar,
phone:$phone,
email:$email,
token:$token,
gender:$gender,
status:$status,
createdAt:$createdAt
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.name == name &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.avatar == avatar &&
        other.phone == phone &&
        other.email == email &&
        other.token == token &&
        other.gender == gender &&
        other.status == status &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, name, firstName, middleName, lastName,
        avatar, phone, email, token, gender, status, createdAt);
  }
}
 */
/* class Authentication {
  SignEntity? signEntity;
  Authentication(this.signEntity);
} */
