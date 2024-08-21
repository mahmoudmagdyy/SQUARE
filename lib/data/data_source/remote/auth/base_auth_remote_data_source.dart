import 'package:aqarat/domain/usecases/auth/reset_password_usecase.dart';
import 'package:aqarat/domain/usecases/auth/send_otp_usecase.dart';
import 'package:aqarat/domain/usecases/auth/set_otp_usecase.dart';
import 'package:dartz/dartz.dart';

import '/index.dart';

abstract class BaseAuthRemoteDataSource {
  Future<AuthenticationModel> register({required RegisterParameter param});
  Future<AuthenticationModel> login({required LoginParameter param});
  Future<AuthenticationModel> getOtp({required SendOtpParameter param});
  Future<AuthenticationModel> setOtp({required SetOtpParameter param});
  Future<AuthenticationModel> resetPassword(
      {required ResetPasswordParameter param});

  Future<Unit> updateFCMToken(String token);
}

class AuthRemoteDataSourceImp extends BaseAuthRemoteDataSource {
  @override
  Future<AuthenticationModel> register(
      {required RegisterParameter param}) async {
    Response response = await DioFactory().post(
      ApiConstance.register,
      data: {
        'email': param.email,
        "username": param.name,
        "first_name": param.fristName,
        "last_name": param.lastName,
        "phone": param.phone,
        "password": param.password,
        "password_confirmation": param.password,
        "gender": param.gender,
      },
    );

    if (response.statusCode == 200) {
      return AuthenticationModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<AuthenticationModel> login({required LoginParameter param}) async {
    final response = await DioFactory().post(
      ApiConstance.login,
      data: {"phone": param.phone, "password": param.password},
    );

    if (response.statusCode == 200) {
      return AuthenticationModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<AuthenticationModel> getOtp({required SendOtpParameter param}) async {
    Response response = await DioFactory().post(
      ApiConstance.sendOtp,
      data: {"phone": param.phone},
    );

    if (response.statusCode == 200) {
      return AuthenticationModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<AuthenticationModel> setOtp({required SetOtpParameter param}) async {
    Response response = await DioFactory().post(ApiConstance.otp(param.otp));

    if (response.statusCode == 200) {
      return AuthenticationModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<AuthenticationModel> resetPassword(
      {required ResetPasswordParameter param}) async {
    Response response = await DioFactory().post(
      ApiConstance.resetPassword(param.phone),
      data: {"password": param.password},
    );

    if (response.statusCode == 200) {
      return AuthenticationModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<Unit> updateFCMToken(String token) async {
    Response response = await DioFactory().post(
      ApiConstance.updateFCMToken,
      data: {"fcm_token": token},
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "lang": "ar",
        },
      ),
    );

    if (response.statusCode == 200) {
      return unit;
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
