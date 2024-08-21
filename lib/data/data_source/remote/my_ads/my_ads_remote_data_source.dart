import 'dart:developer';
import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';
import 'package:dartz/dartz.dart';

import '../../../model/property.dart';

class MyAdsRemoteDataSource {
  Future<List<Property>> getMyAds() async {
    final Response response = await DioFactory().get(
      ApiConstance.myAds,
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
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

  Future<Property> getAdById(int id) async {
    final Response response = await DioFactory().get(
      '${ApiConstance.specificAds}/$id',
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
        },
      ),
    );
    if (response.statusCode == ApiRequestStatusCode.success) {
      return Property.fromMap(response.data["data"]);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  Future<Unit> deleteAd(String id) async {
    final Response response = await DioFactory().delete(
      '${ApiConstance.removeMyAds}/$id',
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
      return unit;
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  Future<void> editMyAds(
      {required int id, required UploadParameter params}) async {
    List<int> deleteImages =[] ;
   for (var i = 0; i <EditMyAdCubit.deletedImage.length;i++) {
    deleteImages.add(EditMyAdCubit.deletedImage[i]);
    }
   // print("ssss${deleteImages}");
     List<MultipartFile> images = [];
    for (var element in params.images!) {
      if(element.path.contains("http")){
        images=[];
      }else{
        images.add(await MultipartFile.fromFile(element.path));
      }

    }
    ///main Image
    MultipartFile?  mainImage ;
    if(params.firstImage!.path.contains("http")){
      mainImage ==null;
    }else{
     mainImage= await MultipartFile.fromFile(params.firstImage!.path);
    }
    

    
   //  final File firstImage;
   //  // if(params.firstImage!.path==null){
   //  //   firstImage=File();
   //  // }
   //   if(params.images!.length == 0){
   //     for (var element in params.images!) {
   //       images.add(await MultipartFile.fromFile(element.path));
   //     }
   //   }else{
   //     images=[];
   //   }

    Response response = await DioFactory().postForm(
      '${ApiConstance.updateMyAds}/$id',
      data: {
        "cat_id":params.cat_id,
         // if (params.aqarIdType != null) "cat_id": params.aqarIdType,
        if (params.adIdType != null) "type": params.adIdType,
        if (params.cityId != null) "city_id": params.cityId,
        if (params.areaId != null) "area_id": params.areaId,
        "lat": params.lat,
        "lng": params.lng,
         // if (params.firstImage != null)
        "first_image":mainImage ,
        "images[]":images,
        "price": params.price,
        "questions": params.questions,
        "age": params.age,
        "title": params.title,
        "description": params.description,
        "tools":
            params.tools.toString().replaceAll('[', '').replaceAll(']', ''),
        "old_images[]":params.deletImages,

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
