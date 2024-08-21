import '../../../../core/params/publish_add_params.dart';
import '../../../../index.dart';

class PublishAddDataSource {
  PublishAddDataSource();
  Future<Response> getpublishAddSlider() async {
    Response response = await DioFactory().get(
      ApiConstance.banner,
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "lang": "ar",
        },
      ),
    );
    print('000000000000000000000000000000000000000000$response');
    return response;
  }

  Future<Response> getAdminPhoneNumber() async {
    Response response = await DioFactory().get(
      ApiConstance.setting,
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "lang": "ar",
        },
      ),
    );
    print('000000000000000000000000000000000000000000$response');
    return response;
  }

  Future<Response> getpublishAdd({required PublishAddParams params}) async {
    Response response = await DioFactory().post(
      ApiConstance.filter,
      data: {
        'share': 1,
        if (params.cityId != null) "city_id": params.cityId,
        params.listOfareaId!.isEmpty ? '' : "area_id": params.listOfareaId,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "lang": "ar",
        },
      ),
    );
    print('000000000000000000000000000000000000000000$response');
    return response;
  }
}
