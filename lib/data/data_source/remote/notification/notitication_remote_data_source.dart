import 'package:aqarat/data/model/notification.dart';
import 'package:aqarat/index.dart';
import 'package:dartz/dartz.dart';

class NotificationRemoteDataSource {
  Future<NotificationModel> getAllNotification() async {
    final Response response = await DioFactory().get(
      ApiConstance.notification,
      options: Options(
        headers: {'Authorization': 'Bearer ${sl<AppPreferences>().getToken}'},
      ),
    );
    if (response.statusCode == ApiRequestStatusCode.success) {
      return NotificationModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  Future<Unit> updateNotificationStatus(int id) async {
    final Response response = await DioFactory().post(
      '${ApiConstance.notification}/$id',
      options: Options(
        headers: {'Authorization': 'Bearer ${sl<AppPreferences>().getToken}'},
      ),
    );
    if (response.statusCode == ApiRequestStatusCode.success) {
      return unit;
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  Future<Unit> remoteNotificationStatus(int id) async {
    final Response response = await DioFactory().delete(
      '${ApiConstance.notification}/$id',
      options: Options(
        headers: {'Authorization': 'Bearer ${sl<AppPreferences>().getToken}'},
      ),
    );
    if (response.statusCode == ApiRequestStatusCode.success) {
      return unit;
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
