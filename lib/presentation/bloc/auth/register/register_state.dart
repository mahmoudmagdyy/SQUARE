part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final RequestState requestState;
  final AuthenticationEntity? model;
  final String message;
  final String nickname;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final int gender;
  final String otp;
  final bool isPassword;
  const RegisterState({
    this.requestState = RequestState.none,
    this.model,
    this.message = '',
    this.nickname = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.phone = '',
    this.gender = 0,
    this.otp = '',
    this.isPassword = true,
  });

  RegisterState copyWith({
    RequestState? requestState,
    AuthenticationEntity? model,
    String? message,
    String? nickname,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? password,
    String? otp,
    int? gender,
    bool? isPassword,
  }) =>
      RegisterState(
        model: model ?? this.model,
        requestState: requestState ?? this.requestState,
        message: message ?? this.message,
        nickname: nickname ?? this.nickname,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        password: password ?? this.password,
        gender: gender ?? this.gender,
        otp: otp ?? this.otp,
        isPassword: isPassword ?? this.isPassword,
      );

  @override
  List<Object?> get props => [
        model,
        requestState,
        message,
        email,
        nickname,
        firstName,
        lastName,
        phone,
        password,
        gender,
        isPassword,
      ];
}
