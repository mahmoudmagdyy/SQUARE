import '/index.dart';

class ProfileEntity extends Equatable {
  final bool status;
  final int code;
  final String message;
  final DataEntity data;
  const ProfileEntity({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [status, code, message, data];
}

class DataEntity extends Equatable {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final String gender;
  final String avatar;
  const DataEntity({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.gender,
    required this.avatar,
  });

  @override
  List<Object?> get props =>
      [id, name, firstName, lastName, username, email, phone, gender, avatar];
}
