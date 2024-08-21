import 'package:aqarat/data/data_source/remote/notification/notitication_remote_data_source.dart';
import 'package:aqarat/data/model/notification.dart';
import 'package:aqarat/index.dart';
import 'package:dartz/dartz.dart';

class NotificationRepository {
  final NotificationRemoteDataSource _notificationRemoteDataSource;
  final NetworkInfo _networkInfo;

  const NotificationRepository(
    this._networkInfo,
    this._notificationRemoteDataSource,
  );

  ResultFuture<NotificationModel> getAllNotification() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _notificationRemoteDataSource.getAllNotification();
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No internet Connection !!!! '));
    }
  }

  ResultFuture<Unit> updateNotificationStatus(int id) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _notificationRemoteDataSource.updateNotificationStatus(id);
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No internet Connection !!!! '));
    }
  }

  ResultFuture<Unit> deleteNotificationStatus(int id) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _notificationRemoteDataSource.remoteNotificationStatus(id);
        return Right(result);
      } on DioError catch (error) {
        return Left(ServerFailure(createErrorEntity(error).message));
      }
    } else {
      return const Left(ServerFailure('No internet Connection !!!! '));
    }
  }
}
