import 'package:aqarat/index.dart';

class CityEntity extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final List<AreaEntity>? area;

  const CityEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.area,
  });

  @override
  List<Object?> get props => [id, name, image, area];
}

class AreaEntity extends Equatable {
  final int? id;
  final String? name;

  const AreaEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
