import 'dart:developer';

import 'package:aqarat/data/model/ads_model.dart';
import 'package:aqarat/domain/usecases/filter/filter_usecase.dart';
import 'package:aqarat/index.dart';

abstract class BaseFilterRemoteDataSource {
  Future<List<AdsModel>> getAds(
      {required FilterParameter params, int pageNumber = 1});
}

class FilterRemoteDataSourceImp extends BaseFilterRemoteDataSource {
  @override
  Future<List<AdsModel>> getAds(
      {required FilterParameter params, int pageNumber = 1}) async {
    print('8989898989898989898==> ${params.lng}}');
    Map<String, dynamic> data = {
      if (params.cityId != null) "city_id": params.cityId,
      if (params.lat != null) "lat": params.lat,
      if (params.lng != null) "lng": params.lng,
      params.listOfareaId!.isEmpty ? '' : "area_id": params.listOfareaId,
      params.categoryId?.isEmpty ?? true ? '' : "cat_id": params.categoryId,
      'share': 0,
    };
    log("====> $data");
    Response response = await DioFactory().post(
      'property/filter?page=$pageNumber',
      data: data,
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
      return List<AdsModel>.from(
        (response.data["data"] as List)
            .map((element) => AdsModel.fromJson(element)),
      );
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
