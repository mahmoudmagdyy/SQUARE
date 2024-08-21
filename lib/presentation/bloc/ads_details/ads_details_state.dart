import 'package:aqarat/core/utils/enums.dart';
import 'package:aqarat/data/model/property.dart';
import 'package:equatable/equatable.dart';

class AdsDetailsState extends Equatable {
  const AdsDetailsState({
    this.errorMessage,
    this.getAllSimilarAdsRequestState = RequestState.none,
    this.similarAds = const [],
  });

  final RequestState getAllSimilarAdsRequestState;
  final List<Property> similarAds;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        getAllSimilarAdsRequestState,
        similarAds,
        errorMessage,
      ];

  AdsDetailsState copyWith({
    RequestState? getAllSimilarAdsRequestState,
    List<Property>? similarAds,
    String? errorMessage,
  }) {
    return AdsDetailsState(
      getAllSimilarAdsRequestState:
          getAllSimilarAdsRequestState ?? this.getAllSimilarAdsRequestState,
      similarAds: similarAds ?? this.similarAds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
