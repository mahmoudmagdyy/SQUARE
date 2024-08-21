import 'package:aqarat/data/data_source/remote/filter/base_filter_remote_data_source.dart';
import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/domain/repository/filter/base_filter_repository.dart';
import 'package:aqarat/domain/usecases/filter/filter_usecase.dart';
import 'package:aqarat/index.dart';
import 'package:dartz/dartz.dart';

class FilterRepositoryImp implements BaseFilterRepository {
  FilterRepositoryImp(this._remoteData, this._networkInfo);
  final BaseFilterRemoteDataSource _remoteData;

  final NetworkInfo _networkInfo;

  @override
  ResultFuture<List<AdsEntity>> getAds(FilterParameter params,
      [int pageNumber = 1]) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _remoteData.getAds(params: params, pageNumber: pageNumber);
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
