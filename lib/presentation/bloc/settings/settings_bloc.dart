import 'dart:async';
import 'package:aqarat/domain/usecases/settings/delete_account_usecase.dart';
import 'package:aqarat/domain/usecases/settings/logout_usecase.dart';
import 'package:aqarat/index.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsInitial> {
  final AppPreferences _appPreferences;
  final LogOutUseCase _logOutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  SettingsBloc(this._logOutUseCase, this._deleteAccountUseCase, this._appPreferences)
      : super(const SettingsInitial()) {
    on<LogOutEvent>(_logOutEvent);
    on<DeleteAccountEvent>(_deleteAccountEvent);
  }

  Future<void> _logOutEvent(
      LogOutEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _logOutUseCase();

    result.fold(
      (left) {
        showSnackBar(message: left.message, isError: true);
        emit(state.copyWith(requestState: RequestState.error));
      },
      (right) {
        showSnackBar(message: "تم تسجيل الخروج بنجاح");
        i<NavigationService>().toNamedAndRemoveUntil(Routes.login);
        _appPreferences.logout();
        emit(state.copyWith(requestState: RequestState.loaded));
      },
    );
    emit(state.copyWith(requestState: RequestState.none));
  }

  Future<void> _deleteAccountEvent(
      DeleteAccountEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _deleteAccountUseCase();

    result.fold(
      (left) {
        showSnackBar(message: left.message, isError: true);
        emit(state.copyWith(requestState: RequestState.error));
      },
      (right) {
        showSnackBar(message: "تم حذف الحساب بنجاح");
        i<NavigationService>().toNamedAndRemoveUntil(Routes.login);
        _appPreferences.logout();
        emit(state.copyWith(requestState: RequestState.loaded));
      },
    );
    emit(state.copyWith(requestState: RequestState.none));
  }
}
