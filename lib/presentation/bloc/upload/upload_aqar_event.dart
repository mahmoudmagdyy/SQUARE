part of 'upload_aqar_bloc.dart';

abstract class UploadAqarEvent extends Equatable {
  const UploadAqarEvent({
    this.payment = '',
    this.realedType = '',
    this.space = 0,
    this.adType = '',
    this.adIdType = '',
    this.aqarType = '',
    this.aqarIdType = '',
    this.city = '',
    this.cityId = '',
    this.selectedCity = 0,
    this.district = '',
    this.districtId = '',
    this.images = const [],
    this.mainImage,
    this.selectedImage = 0,
    this.price = '',
    this.isCheckBox = false,
    this.badrooms = '0',
    this.boards = '0',
    this.bathrooms = '0',
    this.age = '',
    this.title = '',
    this.description = '',
    this.value = const {},
    this.values = const [],
    this.selectExtraOption = '',
    this.selectExtraOptions = const [],
  });
  final String adIdType;
  final String adType;
  final String payment;
  final String realedType;
  final int space;
  final String aqarType;
  final String aqarIdType;
  final String city;
  final String cityId;
  final int selectedCity;
  final String district;
  final String districtId;
  final List<File> images;
  final File? mainImage;
  final int selectedImage;
  final String price;
  final bool isCheckBox;
  final String badrooms;
  final String boards;
  final String bathrooms;
  final String age;
  final String title;
  final String description;
  final Map<String, String> value;
  final List<Map<String, String>> values;
  final String selectExtraOption;
  final List<String> selectExtraOptions;
  @override
  List<Object?> get props => [
        adType,
        adIdType,
        aqarType,
        aqarIdType,
        city,
        selectedCity,
        district,
        districtId,
        images,
        mainImage,
        selectedImage,
        price,
        isCheckBox,
        badrooms,
        boards,
        bathrooms,
        age,
        title,
        description,
        value,
        values,
        selectExtraOption,
        selectExtraOptions,
      ];
}

class GetCitiesEvent extends UploadAqarEvent {}

class GetTypesAqarEvent extends UploadAqarEvent {}

class GetQuestionsEvent extends UploadAqarEvent {}

class GetExtraOptionsEvent extends UploadAqarEvent {}

class GetTypeAdEvent extends UploadAqarEvent {
  const GetTypeAdEvent({super.adIdType, super.adType});
}

class GetTypeAqarEvent extends UploadAqarEvent {
  const GetTypeAqarEvent({super.aqarIdType, super.aqarType});
}

class GetCityAqarEvent extends UploadAqarEvent {
  const GetCityAqarEvent({super.city, super.cityId, super.selectedCity});
}

class GetDistrictAqarEvent extends UploadAqarEvent {
  const GetDistrictAqarEvent({super.district, super.districtId});
}

class GetValueAqarEvent extends UploadAqarEvent {
  const GetValueAqarEvent({super.value});
}

class RemoveImageAqarEvent extends UploadAqarEvent {
  const RemoveImageAqarEvent({super.selectedImage});
}

class GetPriceAqarEvent extends UploadAqarEvent {
  const GetPriceAqarEvent({super.price});
}

class GetSpaceEvent extends UploadAqarEvent {
  const GetSpaceEvent({super.space});
}

class GetPaymentEvent extends UploadAqarEvent {
  const GetPaymentEvent({super.payment});
}

class GetRealedTypeEvent extends UploadAqarEvent {
  const GetRealedTypeEvent({super.realedType});
}

class GetCheckBoxAqarEvent extends UploadAqarEvent {
  const GetCheckBoxAqarEvent({super.isCheckBox});
}

class GetImagesAqarEvent extends UploadAqarEvent {
  const GetImagesAqarEvent({super.images});
}

class GetMainImagesAqarEvent extends UploadAqarEvent {
  const GetMainImagesAqarEvent({super.mainImage});
}

class GetBadRoomsAqarEvent extends UploadAqarEvent {
  const GetBadRoomsAqarEvent({super.badrooms});
}

class GetBoardsAqarEvent extends UploadAqarEvent {
  const GetBoardsAqarEvent({super.boards});
}

class GetBathRoomsAqarEvent extends UploadAqarEvent {
  const GetBathRoomsAqarEvent({super.bathrooms});
}

class GetAgeAqarEvent extends UploadAqarEvent {
  const GetAgeAqarEvent({super.age});
}

class GetTitleAqarEvent extends UploadAqarEvent {
  const GetTitleAqarEvent({super.title});
}

class GetDescriptionAqarEvent extends UploadAqarEvent {
  const GetDescriptionAqarEvent({super.description});
}

class GetExtraOptionAqarEvent extends UploadAqarEvent {
  const GetExtraOptionAqarEvent({super.selectExtraOption});
}

/* class GetExtraOptionsAqarEvent extends UploadAqarEvent {
  const GetExtraOptionsAqarEvent({super.selectExtraOptions});
} */
class UploadNewAqarEvent extends UploadAqarEvent {}
