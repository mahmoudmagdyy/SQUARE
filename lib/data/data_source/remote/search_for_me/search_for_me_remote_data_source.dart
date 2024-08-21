import '../../../../core/params/search_for_me_params.dart';
import '../../../../index.dart';

class SearchForMeDataSource {
  SearchForMeDataSource();

  Future<Response> searchForMe(SearchForMeParams params) async {
    final response = await DioFactory().post(
      ApiConstance.searchForMe,
      data: {
        "city_id": params.cityId,
        "area_id": params.areaId,
        "cat_id": params.catId,
        "desc": params.desc,
        "type": params.type,
        "price": {"from": params.fromPrice, "to": params.toPrice},
        "space": params.space
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
    return response;
  }

  Future<Response> getSearchForMe() async {
    final response = await DioFactory().get(
      ApiConstance.searchForMe,
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "lang": "ar",
        },
      ),
    );
    return response;
  }
}
