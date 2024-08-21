import 'dart:async';

import 'package:aqarat/domain/usecases/auth/reset_password_usecase.dart';
import 'package:aqarat/domain/usecases/auth/send_otp_usecase.dart';
import 'package:aqarat/domain/usecases/auth/set_otp_usecase.dart';

import '/index.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc(
      this._passwordUseCase, this._sendOtpUseCase, this._setOtpUseCase)
      : super(const ForgetPasswordState()) {
    on<ForgetPassPhoneEvent>(_phone);
    on<ForgetPassPasswordEvent>(_password);
    on<ForgetPassOtpEvent>(_otp);

    on<OnTapedGoToSetOtpEvent>(_onTapedGoToSetOtpEvent);
    on<OnTapedGoToSetPasswordEvent>(_onTapedGoToSetPasswordEvent);
    on<OnTapedResetPasswordEvent>(_onTapedResetPasswordEvent);
  }
  final ResetPasswordUseCase _passwordUseCase;
  final SendOtpUseCase _sendOtpUseCase;
  final SetOtpUseCase _setOtpUseCase;

  Future<void> _onTapedResetPasswordEvent(OnTapedResetPasswordEvent event,
      Emitter<ForgetPasswordState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await _passwordUseCase(
      ResetPasswordParameter(password: state.password, phone: state.phone),
    );
    result.fold((left) {
      showSnackBar(message: left.message);
      emit(state.copyWith(requestState: RequestState.error));
    }, (right) {
      showSnackBar(message: right.message);
      sl<NavigationService>().toNamedAndRemoveUntil(Routes.login);
      emit(state.copyWith(requestState: RequestState.loaded));
    });
  }

  Future<void> _onTapedGoToSetPasswordEvent(OnTapedGoToSetPasswordEvent event,
      Emitter<ForgetPasswordState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await _setOtpUseCase(SetOtpParameter(otp: state.otp));

    result.fold((left) {
      showSnackBar(message: left.message);
      emit(state.copyWith(requestState: RequestState.error));
    }, (right) {
      showSnackBar(message: right.message);
      sl<NavigationService>().toNamed(Routes.setNewPassword);
      emit(state.copyWith(requestState: RequestState.loaded));
    });
  }

  Future<void> _onTapedGoToSetOtpEvent(
      OnTapedGoToSetOtpEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await _sendOtpUseCase(SendOtpParameter(phone: state.phone));

    result.fold((left) {
      /* sl<NavigationService>().toNamed(Routes.errorVerificationScreen); */
      showSnackBar(message: left.message, isError: true);
      emit(state.copyWith(requestState: RequestState.error));
    }, (right) {
      showSnackBar(message: right.message);

      sl<NavigationService>().toNamed(Routes.verificationForget);
      emit(state.copyWith(requestState: RequestState.loaded));
    });
  }

  void _password(
          ForgetPassPasswordEvent event, Emitter<ForgetPasswordState> emit) =>
      emit(state.copyWith(password: event.password));

  void _otp(ForgetPassOtpEvent event, Emitter<ForgetPasswordState> emit) =>
      emit(state.copyWith(otp: event.otp));

  void _phone(ForgetPassPhoneEvent event, Emitter<ForgetPasswordState> emit) =>
      emit(state.copyWith(phone: event.phone));
}
