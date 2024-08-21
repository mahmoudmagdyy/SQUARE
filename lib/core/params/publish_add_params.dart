import 'package:aqarat/index.dart';

class PublishAddParams extends Equatable {
  final String? cityId;
  final List<String>? listOfareaId;

  const PublishAddParams({
    this.cityId,
    this.listOfareaId,
  });

  @override
  List<Object?> get props => [
        cityId,
        listOfareaId,
      ];
}
