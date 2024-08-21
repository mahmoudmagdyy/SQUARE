import 'dart:developer';

import 'package:aqarat/data/model/profile_model.dart';
import 'package:aqarat/domain/usecases/profile/get_profile_id_usecase.dart';
import 'package:aqarat/domain/usecases/profile/update_profile_usecase.dart';

import '/index.dart';

abstract class BaseProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> getProfileId({required GetProfileIdParameter param});
  Future<ProfileModel> updateProfile({required UpdateProfileParameter param});
}

class ProfileRemoteDataSourceImp extends BaseProfileRemoteDataSource {
  @override
  Future<ProfileModel> getProfile() async {
    Response response = await DioFactory().get(
      ApiConstance.profile,
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
      return ProfileModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<ProfileModel> getProfileId(
      {required GetProfileIdParameter param}) async {
    debugPrint("id :" "${param.id}");
    Response response = await DioFactory().get(
      ApiConstance.getProfileId(param.id),
      options: Options(headers: {
        "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
        "Content-Type": "application/json",
        "Accept": "application/json",
        "lang": "ar"
      }),
    );
    debugPrint("response  $response");
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<ProfileModel> updateProfile(
      {required UpdateProfileParameter param}) async {
    log("==============> ${param.firstName}");
    MultipartFile? image;
    if (param.image != null) {
      image = await MultipartFile.fromFile(param.image!);
    }
    Response response = await DioFactory().postForm(
      ApiConstance.updateProfile,
      data: {
        "first_name": param.firstName,
        "last_name": param.lastName,
        "username": param.username,
        "email": param.email,
        "phone": param.phone,
        if (image != null) "avatar": image,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer ${sl<AppPreferences>().getToken}",
          "Content-Type": "multipart/form-data",
          "Accept": "application/json",
          "lang": "ar"
        },
      ),
    );
    log("response in update profile ==> $response");
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
