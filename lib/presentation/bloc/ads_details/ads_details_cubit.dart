import 'package:aqarat/data/repository/ad_details/ad_details_repository.dart';
import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/ads_details/ads_details_state.dart';

class AdsDetailsCubit extends Cubit<AdsDetailsState> {
  final AdDetailsRepository _adDetailsRepository;

  AdsDetailsCubit(
    this._adDetailsRepository,
  ) : super(const AdsDetailsState());

  void getAllSimilarAds(int id) async {
    emit(state.copyWith(getAllSimilarAdsRequestState: RequestState.loading));

    final result = await _adDetailsRepository.getSimilarAds(id);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getAllSimilarAdsRequestState: RequestState.error,
            errorMessage: failure.message,
          ),
        );
      },
      (right) {
        emit(
          state.copyWith(
            getAllSimilarAdsRequestState: RequestState.loaded,
            similarAds: right,
          ),
        );
      },
    );
  }
}
