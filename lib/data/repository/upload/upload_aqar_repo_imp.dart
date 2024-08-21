import 'dart:developer';

import 'package:aqarat/index.dart';
import 'package:dartz/dartz.dart';

class UploadAqarRepositoryImp implements BaseUploadAqarRepository {
  UploadAqarRepositoryImp(this._remoteData, this._networkInfo);
  final BaseUploadAdRemoteDataSource _remoteData;

  final NetworkInfo _networkInfo;
  @override
  ResultFuture<List<CityEntity>> getCities() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.getCities();
        log("result in get all city ==> $result ");
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(
          ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }

  @override
  ResultFuture<List<AreaEntity>> getTypesAqar() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.getTypesAqar();
        log("result in get all type aqar ==> $result ");
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(
          ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }

  @override
  ResultFuture<List<InnerQuestionsEntity>> getQuestions() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.getQuestions();
        log("result in get all questions ==> $result ");
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(
          ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }

  @override
  ResultFuture<List<InnerQuestionsEntity>> getExtraOptions() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.getExtraOptions();
        log("result in get extra options ==> $result ");
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(
          ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }

  @override
  ResultFuture<void> upload(UploadParameter parameters) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.upload(params: parameters);
        return Right(result);
      } on DioError catch (e) {
        return Left(ServerFailure(createErrorEntity(e).message));
      }
    } else {
      return const Left(
          ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }
}
