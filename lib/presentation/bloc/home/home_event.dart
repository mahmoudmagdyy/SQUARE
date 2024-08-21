part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  final String text;
  const HomeEvent({
    this.text = '',
  });

  @override
  List<Object> get props => [
        text,
      ];
}

class GetAdsEvent extends HomeEvent {
  const GetAdsEvent();
}

class GetSliderEvent extends HomeEvent {
  const GetSliderEvent();
}

class GetCityEvent extends HomeEvent {
  const GetCityEvent();
}

class GetSearchProductsEvent extends HomeEvent {
  const GetSearchProductsEvent({super.text});
}
