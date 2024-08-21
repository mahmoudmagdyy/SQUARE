part of 'login_bloc.dart';

class LoginState extends Equatable {
  final RequestState requestState;
  final AuthenticationEntity? model;
  final String message;

  final String phone;
  final String password;
  const LoginState({
    this.requestState = RequestState.none,
    this.model,
    this.message = '',
    this.phone = '',
    this.password = '',
  });

  LoginState copyWith({
    RequestState? requestState,
    AuthenticationEntity? model,
    String? message,
    String? phone,
    String? password,
  }) =>
      LoginState(
        model: model ?? this.model,
        requestState: requestState ?? this.requestState,
        message: message ?? this.message,
        phone: phone ?? this.phone,
        password: password ?? this.password,
      );

  @override
  List<Object?> get props => [model, requestState, message, phone, password];
}
