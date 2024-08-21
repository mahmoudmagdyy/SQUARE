import 'package:aqarat/domain/usecases/auth/reset_password_usecase.dart';
import 'package:aqarat/domain/usecases/auth/send_otp_usecase.dart';
import 'package:aqarat/domain/usecases/auth/set_otp_usecase.dart';
import 'package:dartz/dartz.dart';
import '/index.dart';

class AuthenticationRepositoryImp implements BaseAuthenticationRepository {
  AuthenticationRepositoryImp(this._remoteData, this._networkInfo);
  final BaseAuthRemoteDataSource _remoteData;

  final NetworkInfo _networkInfo;
  @override
  ResultFuture<AuthenticationEntity> register(
      RegisterParameter parameters) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.register(param: parameters);

        if (result.code == ApiRequestStatusCode.success) {
          return Right(result);
        } else {
          return Left(ServerFailure(result.message));
        }
      } on DioError catch (e) {
        return Left(ServerFailure(createErrorEntity(e).message));
      }
    } else {
      return const Left(ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }

  @override
  ResultFuture<AuthenticationEntity> login(LoginParameter parameters) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.login(param: parameters);
        debugPrint("result in login ==> $result ");
        if (result.code == ApiRequestStatusCode.success) {
          return Right(result);
        } else {
          return Left(ServerFailure(result.message));
        }
      } on DioError catch (e) {
        return Left(ServerFailure(createErrorEntity(e).message));
      }
    } else {
      return const Left(ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }

  @override
  ResultFuture<AuthenticationEntity> getOtp(SendOtpParameter param) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.getOtp(param: param);
        if (result.code == ApiRequestStatusCode.success) {
          return Right(result);
        } else {
          return Left(ServerFailure(result.message));
        }
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }

  @override
  ResultFuture<AuthenticationEntity> resetPassword(
      ResetPasswordParameter param) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.resetPassword(param: param);
        if (result.code == ApiRequestStatusCode.success) {
          return Right(result);
        } else {
          return Left(ServerFailure(result.message));
        }
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }

  @override
  ResultFuture<AuthenticationEntity> setOtp(SetOtpParameter params) {
    throw UnimplementedError();
  }
}
