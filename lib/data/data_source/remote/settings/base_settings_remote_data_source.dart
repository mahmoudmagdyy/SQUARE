import '/index.dart';

abstract class BaseSettingsRemoteDataSource {
  Future<void> logout();
  Future<void> deleteAccount();
}

class SettingsRemoteDataSourceImp extends BaseSettingsRemoteDataSource {
  @override
  Future<void> logout() async {
    Response response = await DioFactory().post(
      ApiConstance.logout,
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "lang": "ar"
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<void> deleteAccount() async {
    Response response = await DioFactory().delete(
      ApiConstance.deleteAccount,
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "lang": "ar"
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
