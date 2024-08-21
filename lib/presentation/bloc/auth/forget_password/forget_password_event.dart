part of 'forget_password_bloc.dart';

sealed class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent({
    this.password = '',
    this.phone = '',
    this.otp = '',
  });
  final String password;
  final String phone;
  final String otp;
  @override
  List<Object> get props => [password, phone, otp];
}

class ForgetPassPhoneEvent extends ForgetPasswordEvent {
  const ForgetPassPhoneEvent({super.phone});
}

class ForgetPassPasswordEvent extends ForgetPasswordEvent {
  const ForgetPassPasswordEvent({super.password});
}

class ForgetPassOtpEvent extends ForgetPasswordEvent {
  const ForgetPassOtpEvent({super.otp});
}

class OnTapedGoToSetOtpEvent extends ForgetPasswordEvent {
  const OnTapedGoToSetOtpEvent();
}

class OnTapedGoToSetPasswordEvent extends ForgetPasswordEvent {
  const OnTapedGoToSetPasswordEvent();
}

class OnTapedResetPasswordEvent extends ForgetPasswordEvent {
  const OnTapedResetPasswordEvent();
}
