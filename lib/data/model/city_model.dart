import 'package:aqarat/index.dart';

class CityModel extends CityEntity {
  const CityModel({
    required super.id,
    required super.name,
    required super.image,
    required super.area,
  });

  factory CityModel.fromJson(Map<String, Object?> json) {
    return CityModel(
      id: json['id'] == null ? null : json['id'] as int,
      name: json['name'] == null ? null : json['name'] as String,
      image: json['image'] == null ? null : json['image'] as String,
      area: json['area'] == null
          ? null
          : (json['area'] as List)
              .map<AreaModel>(
                  (data) => AreaModel.fromJson(data as Map<String, Object?>))
              .toList(),
    );
  }
}

class AreaModel extends AreaEntity {
  const AreaModel({required super.id, required super.name});

  factory AreaModel.fromJson(Map<String, Object?> json) {
    return AreaModel(
      id: json['id'] == null ? null : json['id'] as int,
      name: json['name'] == null ? null : json['name'] as String,
    );
  }
}
