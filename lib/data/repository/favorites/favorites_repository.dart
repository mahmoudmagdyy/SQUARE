import 'dart:developer';

import 'package:aqarat/data/data_source/remote/favorite/favorite_remote_data_source.dart';
import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/index.dart';
import 'package:dartz/dartz.dart';

class FavoritesRepository {
  final FavoriteRemoteDataSource _favoriteRemoteDataSource;
  final NetworkInfo _networkInfo;

  const FavoritesRepository(
    this._networkInfo,
    this._favoriteRemoteDataSource,
  );

  ResultFuture<List<Property>> getMyFavorites() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _favoriteRemoteDataSource.getMyFavorites();
        return Right(result);
      } on DioError catch (error) {
        if (error.response?.statusCode == 401) {
          sl<AppPreferences>().logout().then(
                (value) =>
                    sl<NavigationService>().toNamedAndRemoveUntil(Routes.login),
              );
        }
        log('Get My Favorites Error 1  $error');
        return Left(ServerFailure(createErrorEntity(error).message,
            statusCode: error.response?.statusCode));
      }
    } else {
      return const Left(ServerFailure('No internet Connection !!!! '));
    }
  }

  ResultFuture<Unit> addOrRemoveFavorite(int id) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _favoriteRemoteDataSource.addOrRemoveFavorite(id);
        return Right(result);
      } on DioError catch (error) {
        log('Error in add or remove from favorite $error');
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No internet Connection !!!! '));
    }
  }
}
