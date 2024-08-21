part of 'forget_password_bloc.dart';

class ForgetPasswordState extends Equatable {
  final RequestState requestState;
  final Authentication? model;
  final String message;

  final String password;
  final String phone;
  final String otp;

  const ForgetPasswordState({
    this.requestState = RequestState.none,
    this.model,
    this.message = '',
    this.password = '',
    this.phone = '',
    this.otp = '',
  });

  ForgetPasswordState copyWith({
    RequestState? requestState,
    Authentication? model,
    String? message,
    String? password,
    String? phone,
    String? otp,
  }) =>
      ForgetPasswordState(
        model: model ?? this.model,
        requestState: requestState ?? this.requestState,
        message: message ?? this.message,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        otp: otp ?? this.otp,
      );
  @override
  List<Object?> get props =>
      [model, requestState, message, password, phone, otp];
}
