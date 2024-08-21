import 'dart:developer';

import 'package:aqarat/data/model/ads_model.dart';
import 'package:aqarat/data/model/slider_model.dart';
import 'package:aqarat/domain/usecases/home/search_usecase.dart';

import '../../../model/cities_with_area_model.dart';
import '/index.dart';

abstract class BaseHomeRemoteDataSource {
  Future<List<AdsModel>> getAds();
  Future<List<SlidersModel>> getSlider();
  Future<List<CityModel>> getCities();

  Future<CitiesWithAreamodel> getCitiesWithArea();
  Future<List<AdsModel>> search({required SearchParameter params});
}

class HomeRemoteDataSourceImp extends BaseHomeRemoteDataSource {
  @override
  Future<List<AdsModel>> getAds() async {
    Response response = await DioFactory().get(
      ApiConstance.home,
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
      log('Get Ads Success ${response.data["data"]['ads']}');
      return List<AdsModel>.from(
        (response.data["data"]['ads'] as List)
            .map((element) => AdsModel.fromJson(element)),
      );
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<List<AdsModel>> search({required SearchParameter params}) async {
    Response response = await DioFactory().get(
      ApiConstance.search,
      queryParameters: {"search": params.text},
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

  @override
  Future<List<SlidersModel>> getSlider() async {
    Response response = await DioFactory().get(
      ApiConstance.slider,
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
      return List<SlidersModel>.from(
        (response.data["data"] as List)
            .map((element) => SlidersModel.fromJson(element)),
      );
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<List<CityModel>> getCities() async {
    Response response = await DioFactory().get(
      ApiConstance.city,
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
      return List<CityModel>.from(
        (response.data["data"] as List)
            .map((element) => CityModel.fromJson(element)),
      );
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<CitiesWithAreamodel> getCitiesWithArea() async {
    Response response = await DioFactory().get(
      ApiConstance.cityWithArea,
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
      return CitiesWithAreamodel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
