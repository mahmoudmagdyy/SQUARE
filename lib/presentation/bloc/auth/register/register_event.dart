part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent({
    this.nickname,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.password,
    this.otp,
    this.gender,
    this.isPassword,
  });
  final String? nickname;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? password;
  final String? otp;
  final int? gender;
  final bool? isPassword;
  @override
  List<Object?> get props => [
        nickname,
        firstName,
        lastName,
        phone,
        email,
        password,
        otp,
        gender,
        isPassword,
      ];
}

class PhoneRegisterEvent extends RegisterEvent {
  const PhoneRegisterEvent({super.phone});
}

class PasswordRegisterEvent extends RegisterEvent {
  const PasswordRegisterEvent({super.password});
}

class FristNameRegisterEvent extends RegisterEvent {
  const FristNameRegisterEvent({super.firstName});
}

class LastNameRegisterEvent extends RegisterEvent {
  const LastNameRegisterEvent({super.lastName});
}

class NickNameRegisterEvent extends RegisterEvent {
  const NickNameRegisterEvent({super.nickname});
}

class EmailRegisterEvent extends RegisterEvent {
  const EmailRegisterEvent({super.email});
}

class GenderRegisterEvent extends RegisterEvent {
  const GenderRegisterEvent({super.gender});
}

class OtpRegisterEvent extends RegisterEvent {
  const OtpRegisterEvent({super.otp});
}

class OnTapedRegisterEvent extends RegisterEvent {
  const OnTapedRegisterEvent();
}

class OnTapedSetOtpRegisterEvent extends RegisterEvent {
  const OnTapedSetOtpRegisterEvent();
}

class HiddenPasswordEvent extends RegisterEvent {
  const HiddenPasswordEvent({super.isPassword});
}
