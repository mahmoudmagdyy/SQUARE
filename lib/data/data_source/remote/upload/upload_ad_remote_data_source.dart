import 'dart:developer';

import 'package:aqarat/index.dart';

abstract class BaseUploadAdRemoteDataSource {
  Future<List<CityModel>> getCities();
  Future<List<AreaModel>> getTypesAqar();
  Future<List<QuestionsModel>> getQuestions();
  Future<List<QuestionsModel>> getExtraOptions();
  Future<void> upload({required UploadParameter params});
}

class UploadAdRemoteDataSourceImp extends BaseUploadAdRemoteDataSource {
  @override
  Future<List<CityModel>> getCities() async {
    Response response = await DioFactory().get(ApiConstance.cities);
    if (response.statusCode == ApiRequestStatusCode.success) {
      return List<CityModel>.from(
        (response.data["data"] as List)
            .map((element) => CityModel.fromJson(element)),
      );
    } else {
      throw ServerException(
          errorMsgModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<AreaModel>> getTypesAqar() async {
    Response response = await DioFactory().get(ApiConstance.type);
    if (response.statusCode == ApiRequestStatusCode.success) {
      return List<AreaModel>.from(
        (response.data["data"] as List)
            .map((element) => AreaModel.fromJson(element)),
      );
    } else {
      throw ServerException(
          errorMsgModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<QuestionsModel>> getQuestions() async {
    Response response = await DioFactory().get(ApiConstance.questions);
    if (response.statusCode == ApiRequestStatusCode.success) {
      return List<QuestionsModel>.from(
        (response.data["data"] as List)
            .map((element) => QuestionsModel.fromJson(element)),
      );
    } else {
      throw ServerException(
          errorMsgModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<QuestionsModel>> getExtraOptions() async {
    Response response = await DioFactory().get(ApiConstance.extraOptions);
    if (response.statusCode == ApiRequestStatusCode.success) {
      return List<QuestionsModel>.from(
        (response.data["data"] as List)
            .map((element) => QuestionsModel.fromJson(element)),
      );
    } else {
      throw ServerException(
          errorMsgModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<void> upload({required UploadParameter params}) async {
    List<MultipartFile> images = [];
    for (var element in params.images!) {
      images.add(await MultipartFile.fromFile(element.path));
    }
    Response response = await DioFactory().postForm(
      ApiConstance.upload,
      data:
      {

        // "cat_id": 3,
        // "type":"1",
        // "city_id": 2,
        // "type_status": 1,
        // "area_id": 3,
        // "lat": "31.258",
        // "lng": "31.99999",
        // "price": 55,
        // "questions": params.questions,
        // "first-image":"",
        // "age": 55,
        // "title":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        // "description": "55skkkkkkkkkkkkkkkkkksssssssssssss",
        // "payment": "vizaa",
        // "space":10,
        // "tools":
        // "1,2,3,",
        //

        "cat_id": params.aqarIdType,
        "type": params.adIdType,
        "city_id": params.cityId,
        "type_status": params.typeStatus,
        "area_id": params.areaId,
        "lat": params.lat,
        "lng": params.lng,
        "first_image": await MultipartFile.fromFile(params.firstImage!.path),
        "images[]": images,
        "price": params.price,
        "questions": params.questions,
        "age": params.age,
        "title": params.title,
        "description": params.description,
        "payment": params.payment,
        "space": params.space,
        "tools":
            params.tools.toString().replaceAll('[', '').replaceAll(']', ''),
      },
    );

    if (response.statusCode == ApiRequestStatusCode.success) {
      log("Upload New Aqar ===> ${response.data}");
    } else {
      throw ServerException(
        errorMsgModel: ErrorMessageModel.fromJson(
          response.data,
        ),
      );
    }
  }
}
