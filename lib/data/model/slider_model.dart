import 'package:aqarat/domain/entities/home/slider_entity.dart';

class SlidersModel extends SlidersEntity {
  const SlidersModel({required super.id, required super.image});

  factory SlidersModel.fromJson(Map<String, dynamic> json) => SlidersModel(
        id: json['id'] as int,
        image: json['image'] as String,
      );
}