part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LogOutEvent extends SettingsEvent {
  const LogOutEvent();

 }

class DeleteAccountEvent extends SettingsEvent {
  const DeleteAccountEvent();

 }