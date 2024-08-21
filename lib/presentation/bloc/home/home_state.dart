part of 'home_bloc.dart';

class HomeState extends Equatable {
  final RequestState requestStateAds;
  final RequestState requestStateSlider;
  final RequestState requestStateCity;
  final RequestState requestStateCityWithArea;
  final RequestState requestStateSearch;
  final List<AdsEntity> ads;
  final List<SlidersEntity> slider;
  final List<CityEntity> cities;
  final CitiesWithAreamodel? cityWithAreaModel;
  final List<AdsEntity> search;
  final String message;
  const HomeState({
    this.requestStateCityWithArea = RequestState.none,
    this.cityWithAreaModel,
    this.requestStateAds = RequestState.loading,
    this.requestStateSlider = RequestState.loading,
    this.requestStateCity = RequestState.loading,
    this.requestStateSearch = RequestState.none,
    this.ads = const [],
    this.slider = const [],
    this.cities = const [],
    this.message = '',
    this.search = const [],
  });

  HomeState copyWith({
    RequestState? requestStateAds,
    RequestState? requestStateCityWithArea,
    RequestState? requestStateSlider,
    RequestState? requestStateCity,
    RequestState? requestStateSearch,
    List<AdsEntity>? ads,
    List<SlidersEntity>? slider,
    List<CityEntity>? cities,
    String? message,
    List<AdsEntity>? search,
    CitiesWithAreamodel? cityWithAreaModel,
  }) =>
      HomeState(
        ads: ads ?? this.ads,
        cityWithAreaModel: cityWithAreaModel ?? this.cityWithAreaModel,
        requestStateCityWithArea:
            requestStateCityWithArea ?? this.requestStateCityWithArea,
        slider: slider ?? this.slider,
        cities: cities ?? this.cities,
        requestStateAds: requestStateAds ?? this.requestStateAds,
        requestStateSlider: requestStateSlider ?? this.requestStateSlider,
        requestStateCity: requestStateCity ?? this.requestStateCity,
        requestStateSearch: requestStateSearch ?? this.requestStateSearch,
        message: message ?? this.message,
        search: search ?? this.search,
      );

  @override
  List<Object?> get props => [
        requestStateCityWithArea,
        cityWithAreaModel,
        ads,
        slider,
        cities,
        requestStateAds,
        requestStateSlider,
        requestStateCity,
        requestStateSearch,
        message,
        search,
      ];
}
