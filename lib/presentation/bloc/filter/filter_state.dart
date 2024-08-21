part of 'filter_bloc.dart';

sealed class FilterState extends Equatable {
  final RequestState requestState;
  final List<AdsEntity> adsEntity;
  final String cityId;
  final String? lat;
  final String? lng;
  final List<String> listOfareaId;
  final String categoryId;

  const FilterState({
    this.lat = '',
    this.lng = '',
    this.requestState = RequestState.none,
    this.adsEntity = const [],
    this.cityId = '',
    this.listOfareaId = const [],
    this.categoryId = '',
  });

  @override
  List<Object?> get props => [
        lat,
        lng,
        requestState,
        adsEntity,
        cityId,
        listOfareaId,
        categoryId,
      ];
}

final class FilterInitial extends FilterState {
  const FilterInitial({
    super.requestState,
    super.adsEntity,
    super.cityId,
    super.lat,
    super.lng,
    super.listOfareaId,
    super.categoryId,
  });
  FilterInitial copyWith({
    RequestState? requestState,
    List<AdsEntity>? adsEntity,
    String? cityId,
    String? lat,
    String? lng,
    String? categoryId,
    List<String>? listOfareaId,
  }) {
    return FilterInitial(
      requestState: requestState ?? this.requestState,
      adsEntity: adsEntity ?? this.adsEntity,
      cityId: cityId ?? this.cityId,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      categoryId: categoryId ?? this.categoryId,
      listOfareaId: listOfareaId ?? this.listOfareaId,
    );
  }
}
