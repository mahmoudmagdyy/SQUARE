// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_ads_cubit.dart';

class MyAdsState extends Equatable {
  const MyAdsState({
    this.getMyAdsState = RequestState.none,
    this.myAds,
    this.getMyAdsErrorMessage,
    this.deleteAds = RequestState.none,
    this.deleteAdsErrorMessage,
    this.editAdsErrorMessage,
    this.editAdsRequestState = RequestState.none,
  });

  //! Get All Ads
  final RequestState getMyAdsState;
  final List<Property>? myAds;
  final String? getMyAdsErrorMessage;

  //! Delete Ads
  final RequestState deleteAds;
  final String? deleteAdsErrorMessage;

  //! Edit Ads
  final RequestState editAdsRequestState;
  final String? editAdsErrorMessage;

  @override
  List<Object?> get props => [
        getMyAdsState,
        myAds,
        getMyAdsErrorMessage,
        deleteAds,
        deleteAdsErrorMessage,
        editAdsRequestState,
        editAdsErrorMessage,
      ];

  MyAdsState copyWith({
    RequestState? getMyAdsState,
    List<Property>? myAds,
    String? getMyAdsErrorMessage,
    RequestState? deleteAds,
    String? deleteAdsErrorMessage,
    RequestState? editAdsRequestState,
    String? editAdsErrorMessage,
  }) {
    return MyAdsState(
      getMyAdsState: getMyAdsState ?? this.getMyAdsState,
      myAds: myAds ?? this.myAds,
      getMyAdsErrorMessage: getMyAdsErrorMessage ?? this.getMyAdsErrorMessage,
      deleteAds: deleteAds ?? this.deleteAds,
      deleteAdsErrorMessage:
          deleteAdsErrorMessage ?? this.deleteAdsErrorMessage,
      editAdsRequestState: editAdsRequestState ?? this.editAdsRequestState,
      editAdsErrorMessage: editAdsErrorMessage ?? this.editAdsErrorMessage,
    );
  }
}
