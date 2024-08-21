import 'package:aqarat/domain/usecases/auth/reset_password_usecase.dart';
import 'package:aqarat/domain/usecases/auth/send_otp_usecase.dart';
import 'package:aqarat/domain/usecases/auth/set_otp_usecase.dart';

import '/index.dart';

abstract class BaseAuthenticationRepository {
  ResultFuture<AuthenticationEntity> register(RegisterParameter params);
  ResultFuture<AuthenticationEntity> login(LoginParameter params);
  ResultFuture<AuthenticationEntity> getOtp(SendOtpParameter params);
  ResultFuture<AuthenticationEntity> setOtp(SetOtpParameter params);
  ResultFuture<AuthenticationEntity> resetPassword(
      ResetPasswordParameter params);
}
