import 'dart:developer';

import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/data/repository/my_ads/my_ads_repository.dart';
import 'package:aqarat/index.dart';

part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  final MyAdsRepository _adsRepository;
  MyAdsCubit(
    this._adsRepository,
  ) : super(const MyAdsState());

  void getMyAds() async {
    sl<UploadAqarBloc>().add(GetCitiesEvent());

    emit(state.copyWith(getMyAdsState: RequestState.loading));

    final result = await _adsRepository.getMyAds();

    result.fold(
      (l) {
        log('Error in Get My Ads $l');
        emit(
          state.copyWith(
            getMyAdsState: RequestState.error,
            getMyAdsErrorMessage: l.message,
          ),
        );
      },
      (r) => emit(state.copyWith(getMyAdsState: RequestState.loaded, myAds: r)),
    );
  }

  Future deleteAds(String id) async {
    emit(state.copyWith(deleteAds: RequestState.loading));

    final result = await _adsRepository.deleteAd(id);

    result.fold(
      (l) {
        log('Error in Delete Ads $l');
        emit(
          state.copyWith(
            deleteAds: RequestState.error,
            deleteAdsErrorMessage: l.message,
          ),
        );
      },
      (r) {
        var ads = [...state.myAds!];
        ads.removeWhere((element) => element.id.toString() == id);
        emit(state.copyWith(deleteAds: RequestState.loaded, myAds: ads));
      },
    );
  }

  void editMyAd(int id, UploadParameter params) async {
    emit(state.copyWith(editAdsRequestState: RequestState.loading));

    final result = await _adsRepository.editMyAd(id, params);

    result.fold(
      (l) {
        log('Error in Edit My Ads $l');
        emit(
          state.copyWith(
            editAdsRequestState: RequestState.error,
            editAdsErrorMessage: l.message,
          ),
        );
      },
      (r) => emit(state.copyWith(editAdsRequestState: RequestState.loaded)),
    );
  }
}
