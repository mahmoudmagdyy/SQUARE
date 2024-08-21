import 'package:aqarat/data/data_source/remote/settings/base_settings_remote_data_source.dart';
import 'package:aqarat/domain/repository/settings/base_settings_respository.dart';
import 'package:dartz/dartz.dart';
import '/index.dart';

class SettingsRepositoryImp implements BaseSettingsRepository {
  SettingsRepositoryImp(this._remoteData, this._networkInfo);
  final BaseSettingsRemoteDataSource _remoteData;

  final NetworkInfo _networkInfo;
  @override
  ResultVoid logout() async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteData.logout();
        return const Right(null);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No Intrenet Connection !!!! '));
    }
  }

  @override
  ResultVoid deleteAccount() async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteData.deleteAccount();

        return const Right(null);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No Intrenet Connection !!!! '));
    }
  }
}
