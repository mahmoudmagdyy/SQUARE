part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent({this.phone = '', this.password = ''});
  final String phone;
  final String password;
  @override
  List<Object> get props => [phone, password];
}

class GetPhoneEvent extends LoginEvent {
  const GetPhoneEvent({super.phone});
}

class GetPasswordEvent extends LoginEvent {
  const GetPasswordEvent({super.password});
}

class OnTapedLoginEvent extends LoginEvent {
  const OnTapedLoginEvent();
}
