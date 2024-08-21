part of 'search_for_me_bloc.dart';

sealed class SearchForMeState extends Equatable {
  const SearchForMeState({
    this.requestState = RequestState.none,
    this.searchForMeType = 'جديدة',
    this.isCheckBox1 = false,
    this.isCheckBox2 = false,
  });
  final RequestState requestState;
  final String searchForMeType;

  final bool isCheckBox1;
  final bool isCheckBox2;
  @override
  List<Object> get props =>
      [requestState, isCheckBox1, isCheckBox2, searchForMeType];
}

final class SearchForMeInitial extends SearchForMeState {
  const SearchForMeInitial({
    super.requestState,
    super.isCheckBox1,
    super.isCheckBox2,
    super.searchForMeType,
  });
  SearchForMeInitial copyWith({
    RequestState? requestState,
    String? searchForMeType,
    bool? isCheckBox1,
    bool? isCheckBox2,
  }) =>
      SearchForMeInitial(
        requestState: requestState ?? this.requestState,
        searchForMeType: searchForMeType ?? this.searchForMeType,
        isCheckBox1: isCheckBox1 ?? this.isCheckBox1,
        isCheckBox2: isCheckBox2 ?? this.isCheckBox2,
      );
}
