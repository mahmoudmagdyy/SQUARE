import 'package:aqarat/index.dart';
import 'package:dartz/dartz.dart';

import '../../../model/property.dart';

class FavoriteRemoteDataSource {
  Future<List<Property>> getMyFavorites() async {
    final Response response = await DioFactory().get(
      ApiConstance.myFavorites,
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "lang": "ar",
        },
      ),
    );
    if (response.statusCode == ApiRequestStatusCode.success) {
      return List<Property>.from(
        (response.data["data"] as List).map(
          (e) => Property.fromMap(e),
        ),
      );
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  Future<Unit> addOrRemoveFavorite(int id) async {
    final Response response =
        await DioFactory().post(ApiConstance.addOrRemoveFav,
            options: Options(
              headers: {
                "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
                "Content-Type": "application/json",
                "Accept": "application/json",
                "lang": "ar",
              },
            ),
            data: {
          "property_id": id,
        });
    if (response.statusCode == ApiRequestStatusCode.success) {
      return unit;
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
