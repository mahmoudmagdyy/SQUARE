// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'publish_add_cubit.dart';

class PublishAddState extends Equatable {
  const PublishAddState({
    this.adsEntityList,
    this.adsFailure,
    this.adsState = RequestState.none,
    this.sliderModel,
    this.sliderFailure,
    this.sliderState = RequestState.none,
  });

  //! Slider
  final List<SlidersModel>? sliderModel;
  final Failure? sliderFailure;
  final RequestState sliderState;

  // getpublishAdd
  final List<AdsEntity>? adsEntityList;
  final Failure? adsFailure;
  final RequestState adsState;

  @override
  List<Object?> get props => [
        adsEntityList,
        adsFailure,
        adsState,
        sliderModel,
        sliderFailure,
        sliderState,
      ];

  PublishAddState copyWith({
    List<SlidersModel>? sliderModel,
    Failure? sliderFailure,
    RequestState? sliderState,
    List<AdsEntity>? adsEntityList,
    Failure? adsFailure,
    RequestState? adsState,
  }) {
    return PublishAddState(
      sliderModel: sliderModel ?? this.sliderModel,
      sliderFailure: sliderFailure ?? this.sliderFailure,
      sliderState: sliderState ?? this.sliderState,
      adsEntityList: adsEntityList ?? this.adsEntityList,
      adsFailure: adsFailure ?? this.adsFailure,
      adsState: adsState ?? this.adsState,
    );
  }
}
