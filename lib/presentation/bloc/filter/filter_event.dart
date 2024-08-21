part of 'filter_bloc.dart';

sealed class FilterEvent extends Equatable {
  final String cityId;
  final String? lat;
  final String? lng;
  final List<String> areaId;

  const FilterEvent({
    this.cityId = '',
    this.lat = '',
    this.lng = '',
    this.areaId = const [],
  });

  @override
  List<Object?> get props => [
        lat,
        lng,
        cityId,
        areaId,
      ];
}

class GetAdsByFilterEvent extends FilterEvent {
  const GetAdsByFilterEvent();
}

class GetCityIdEvent extends FilterEvent {
  const GetCityIdEvent({super.cityId});
}

class GetAreaIdEvent extends FilterEvent {
  const GetAreaIdEvent({super.areaId});
}

class GetLatEvent extends FilterEvent {
  const GetLatEvent({super.lat});
}

class GetLngEvent extends FilterEvent {
  const GetLngEvent({super.lng});
}
