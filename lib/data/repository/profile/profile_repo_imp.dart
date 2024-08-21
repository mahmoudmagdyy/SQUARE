import 'package:aqarat/data/data_source/remote/profile/base_profile_remote_data_source.dart';
import 'package:aqarat/domain/entities/profile/profile_entity.dart';
import 'package:aqarat/domain/repository/profile/base_profile_repository.dart';
import 'package:aqarat/domain/usecases/profile/get_profile_id_usecase.dart';
import 'package:aqarat/domain/usecases/profile/update_profile_usecase.dart';
import 'package:dartz/dartz.dart';
import '/index.dart';

class ProfileRepositoryImp implements BaseProfileRepository {
  ProfileRepositoryImp(this._remoteData, this._networkInfo);
  final BaseProfileRemoteDataSource _remoteData;

  final NetworkInfo _networkInfo;
  @override
  ResultFuture<ProfileEntity> getProfile() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.getProfile();
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No Intrenet Connection !!!! '));
    }
  }

  @override
  ResultFuture<ProfileEntity> getProfileId(GetProfileIdParameter parameters) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.getProfileId(param: parameters);
        if (result.code == 200) {
          return Right(result);
        } else {
          return Left(ServerFailure(result.message));
        }
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No Intrenet Connection !!!! '));
    }
  }

  @override
  ResultFuture<ProfileEntity> updateProfile(UpdateProfileParameter parameter) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteData.updateProfile(param: parameter);
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No Intrenet Connection !!!! '));
    }
  }
}