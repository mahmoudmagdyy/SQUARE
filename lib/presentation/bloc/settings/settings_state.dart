part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  final RequestState requestState;

  const SettingsState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial({super.requestState = RequestState.none});

  SettingsInitial copyWith({RequestState? requestState}) =>
      SettingsInitial(requestState: requestState ?? this.requestState);
}
