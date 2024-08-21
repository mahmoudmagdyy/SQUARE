part of 'main_bloc.dart';

  class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}
class ChangePage extends MainEvent {
  const ChangePage({required this.index});

  final int index;
  @override
  List<Object> get props => [index];
}
