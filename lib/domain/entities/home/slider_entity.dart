import 'package:aqarat/index.dart';

class SlidersEntity extends Equatable {
  final int id;
  final String image;
  const SlidersEntity({required this.id, required this.image});

  @override
  List<Object> get props => [id, image];
}