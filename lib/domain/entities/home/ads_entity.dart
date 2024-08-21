import 'package:aqarat/index.dart';

class AdsEntity extends Equatable {
  final int id;
  final String city;
  final String? payment;
  final int? space;
  final String area;
  final String title;
  final String type;
  final String price;

  final int age;
  final String lat;
  final String lng;
  final String description;
  final String firstImage;
  final UserEntity user;
  final PropertyEntity property;
  final List<ImagesEntity> images;
  final String status;
  final String? typeStatus;
  final String views;
  final String createdAt;
  final String code;
  final String category;

  const AdsEntity({
    required this.typeStatus,
    required this.category,
    required this.payment,
    required this.space,
    required this.id,
    required this.city,
    required this.area,
    required this.title,
    required this.type,
    required this.price,
    required this.age,
    required this.lat,
    required this.lng,
    required this.description,
    required this.firstImage,
    required this.user,
    required this.property,
    required this.images,
    required this.status,
    required this.views,
    required this.createdAt,
    required this.code,
  });

  @override
  List<Object?> get props => [
        typeStatus,
        id,
        city,
        area,
        title,
        type,
        price,
        age,
        lat,
        lng,
        description,
        firstImage,
        user,
        property,
        images,
        status,
        views,
        createdAt,
        code,
      ];
}

class ImagesEntity extends Equatable {
  final int id;
  final String image;
  const ImagesEntity({required this.id, required this.image});

  @override
  List<Object> get props => [id, image];
}

class PropertyEntity extends Equatable {
  final List<QuestionsEntity> questions;
  final List<TypesAndToolsEntity> tools;
  const PropertyEntity({required this.questions, required this.tools});

  @override
  List<Object> get props => [questions, tools];
}

class TypesAndToolsEntity extends Equatable {
  final int id;
  final String title;
  const TypesAndToolsEntity({required this.id, required this.title});

  @override
  List<Object> get props => [id, title];
}

class QuestionsEntity extends Equatable {
  final int id;
  final String title;
  final dynamic value;
  const QuestionsEntity(
      {required this.id, required this.title, required this.value});

  @override
  List<Object> get props => [id, title, value];
}

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String image;
  const UserEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.image,
  });

  @override
  List<Object> get props => [id, name, phone, email, image];
}
