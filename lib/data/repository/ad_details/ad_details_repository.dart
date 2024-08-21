import 'package:aqarat/data/data_source/remote/ad_details/ad_details_remote_data_source.dart';
import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/index.dart';
import 'package:dartz/dartz.dart';

class AdDetailsRepository {
  final AdDetailsRemoteDataSource _adDetailsRemoteDataSource;
  final NetworkInfo _networkInfo;

  AdDetailsRepository(this._adDetailsRemoteDataSource, this._networkInfo);

  ResultFuture<List<Property>> getSimilarAds(int id) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _adDetailsRemoteDataSource.getSimilarAds(id);
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No internet Connection !!!! '));
    }
  }
}
