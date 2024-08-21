import 'package:aqarat/data/data_source/remote/home/base_home_remote_data_source.dart';
import 'package:aqarat/data/model/slider_model.dart';
import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/domain/repository/home/base_home_repository.dart';
import 'package:aqarat/domain/usecases/home/search_usecase.dart';
import 'package:dartz/dartz.dart';

import '/index.dart';
import '../../model/cities_with_area_model.dart';

class HomeRepositoryImp implements BaseHomeRepository {
  HomeRepositoryImp(this._remoteData, this._networkInfo);
  final BaseHomeRemoteDataSource _remoteData;

  final NetworkInfo _networkInfo;
  @override
  ResultFuture<List<SlidersModel>> getSlider() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.getSlider();
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
  ResultFuture<List<AdsEntity>> getAds() async {
    if (await _networkInfo.isConnected) {
      final result = await _remoteData.getAds();
      return Right(result);
      // try {
      //   final result = await _remoteData.getAds();
      //   return Right(result);
      // } on DioError catch (error) {
      //   return Left(ServerFailure(createErrorEntity(error).message));
      // }
    } else {
      return const Left(
          ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }

  @override
  ResultFuture<List<CityEntity>> getCities() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.getCities();
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
  ResultFuture<List<AdsEntity>> search(SearchParameter params) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.search(params: params);
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
  ResultFuture<CitiesWithAreamodel> getCitiesWithArea() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.getCitiesWithArea();
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(
          ServerFailure('لا يوجد اتصال بالانترنت , برجاء المحاولة لاحقاً'));
    }
  }
}
