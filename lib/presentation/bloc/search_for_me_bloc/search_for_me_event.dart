part of 'search_for_me_bloc.dart';

sealed class SearchForMeEvent extends Equatable {
  const SearchForMeEvent({
    this.isCheckBox1 = false,
    this.isCheckBox2 = false,
  });

  final bool isCheckBox1;
  final bool isCheckBox2;
  @override
  List<Object> get props => [isCheckBox1, isCheckBox2];
}

class GetCheckBox1Event extends SearchForMeEvent {
  const GetCheckBox1Event({super.isCheckBox1});
}

class GetCheckBox2Event extends SearchForMeEvent {
  const GetCheckBox2Event({super.isCheckBox2});
}
