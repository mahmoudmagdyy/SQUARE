// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_for_me_cubit.dart';

class SearchForMeCubitState extends Equatable {
  const SearchForMeCubitState({
    this.getSearchForMeRequestState = RequestState.none,
    this.requestState = RequestState.none,
    this.failure,
  });
  final RequestState requestState;
  final Failure? failure;
  final RequestState getSearchForMeRequestState;

  @override
  List<Object?> get props => [
        getSearchForMeRequestState,
        requestState,
        failure,
      ];

  SearchForMeCubitState copyWith({
    RequestState? requestState,
    Failure? failure,
    RequestState? getSearchForMeRequestState,
  }) {
    return SearchForMeCubitState(
      requestState: requestState ?? this.requestState,
      failure: failure ?? this.failure,
      getSearchForMeRequestState:
          getSearchForMeRequestState ?? this.getSearchForMeRequestState,
    );
  }
}
