import 'package:aqarat/data/data_source/remote/my_ads/my_ads_remote_data_source.dart';
import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/index.dart';
import 'package:dartz/dartz.dart';

class MyAdsRepository {
  final MyAdsRemoteDataSource _adsRemoteDataSource;
  final NetworkInfo _networkInfo;

  const MyAdsRepository(
    this._networkInfo,
    this._adsRemoteDataSource,
  );

  ResultFuture<List<Property>> getMyAds() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _adsRemoteDataSource.getMyAds();
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No internet Connection !!!! '));
    }
  }

  ResultFuture<Property> getAdById(int id) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _adsRemoteDataSource.getAdById(id);
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No internet Connection !!!! '));
    }
  }

  ResultFuture<Unit> deleteAd(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _adsRemoteDataSource.deleteAd(id);
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No internet Connection !!!! '));
    }
  }

  ResultFuture<void> editMyAd(int id, UploadParameter params) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _adsRemoteDataSource.editMyAds(id: id, params: params);
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No internet Connection !!!! '));
    }
  }
}
