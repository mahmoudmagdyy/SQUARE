import 'package:aqarat/domain/entities/profile/profile_entity.dart';


class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.status,
    required super.code,
    required super.message,
    required super.data,
  });
  factory ProfileModel.fromJson(Map<String, Object?> json) =>
      ProfileModel(
        status: json['status'] as bool,
        code: json['code'] as int,
        message: json['message'] as String,
        data: DataModel.fromJson(json['data'] as Map<String, Object?>),
      );

  @override
  String toString() {
    return '''ProfileResponse(
        status:$status,
        code:$code,
        message:$message,
        data:${data.toString()}
    ) ''';
  }
}

class DataModel extends DataEntity {
  const DataModel({
    required super.id,
    required super.name,
    required super.firstName,
    required super.lastName,
    required super.avatar,
    required super.username,
    required super.phone,
    required super.email,
    required super.gender,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json['id'],
        name: json['name'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        avatar: json['avatar'],
        phone: json['phone'],
        username: json['username'],
        email: json['email'],
        gender: json['gender'],
      );
}
