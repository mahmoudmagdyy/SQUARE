part of 'upload_aqar_bloc.dart';

abstract class UploadAqarState extends Equatable {
  const UploadAqarState({
    this.realedType = '',
    this.requestState = RequestState.none,
    this.requestStateCity = RequestState.none,
    this.requestStateType = RequestState.none,
    this.requestStateQuestion = RequestState.none,
    this.requestStateExtraOptions = RequestState.none,
    this.cities = const [],
    this.types = const [],
    this.questions = const [],
    this.extraOptions = const [],
    this.adType = '',
    this.adIdType = '',
    this.payment = '',
    this.space = 0,
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
    this.firstImage,
  });
  final RequestState requestState;
  final RequestState requestStateCity;
  final RequestState requestStateType;
  final RequestState requestStateQuestion;
  final RequestState requestStateExtraOptions;
  final List<CityEntity> cities;
  final List<AreaEntity> types;
  final List<InnerQuestionsEntity> questions;
  final List<InnerQuestionsEntity> extraOptions;

  final String adType;
  final String adIdType;
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
  final File? firstImage;
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
        realedType,
        requestState,
        requestStateCity,
        requestStateType,
        requestStateQuestion,
        requestStateExtraOptions,
        cities,
        types,
        questions,
        extraOptions,
        adType,
        adIdType,
        payment,
        space,
        aqarType,
        aqarIdType,
        city,
        cityId,
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
        firstImage,
      ];
}

final class UploadAdInitial extends UploadAqarState {
  const UploadAdInitial({
    super.requestState,
    super.requestStateCity,
    super.requestStateType,
    super.requestStateQuestion,
    super.requestStateExtraOptions,
    super.cities,
    super.types,
    super.questions,
    super.extraOptions,
    super.adType,
    super.adIdType,
    super.payment,
    super.space,
    super.aqarType,
    super.aqarIdType,
    super.city,
    super.cityId,
    super.selectedCity,
    super.realedType,
    super.district,
    super.districtId,
    super.images,
    super.mainImage,
    super.selectedImage,
    super.price,
    super.isCheckBox,
    super.badrooms,
    super.boards,
    super.bathrooms,
    super.age,
    super.title,
    super.description,
    super.value,
    super.values,
    super.selectExtraOption,
    super.selectExtraOptions,
    super.firstImage,
  });
  UploadAdInitial copyWith({
    RequestState? requestState,
    RequestState? requestStateCity,
    RequestState? requestStateType,
    RequestState? requestStateQuestion,
    RequestState? requestStateExtraOptions,
    List<CityEntity>? cities,
    List<AreaEntity>? types,
    List<InnerQuestionsEntity>? questions,
    List<InnerQuestionsEntity>? extraOptions,
    String? adType,
    String? adIdType,
    String? payment,
    int? space,
    String? aqarType,
    String? aqarIdType,
    String? city,
    String? cityId,
    int? selectedCity,
    String? district,
    String? districtId,
    List<File>? images,
    File? mainImage,
    int? selectedImage,
    String? price,
    String? realedType,
    bool? isCheckBox,
    String? badrooms,
    String? boards,
    String? bathrooms,
    String? age,
    String? title,
    String? description,
    Map<String, String>? value,
    List<Map<String, String>>? values,
    String? selectExtraOption,
    List<String>? selectExtraOptions,
    File? firstImage,
  }) {
    return UploadAdInitial(
      requestState: requestState ?? this.requestState,
      requestStateCity: requestStateCity ?? this.requestStateCity,
      requestStateType: requestStateType ?? this.requestStateType,
      requestStateQuestion: requestStateQuestion ?? this.requestStateQuestion,
      requestStateExtraOptions:
          requestStateExtraOptions ?? this.requestStateExtraOptions,
      cities: cities ?? this.cities,
      types: types ?? this.types,
      questions: questions ?? this.questions,
      extraOptions: extraOptions ?? this.extraOptions,
      adType: adType ?? this.adType,
      adIdType: adIdType ?? this.adIdType,
      space: space ?? this.space,
      payment: payment ?? this.payment,
      aqarType: aqarType ?? this.aqarType,
      aqarIdType: aqarIdType ?? this.aqarIdType,
      city: city ?? this.city,
      cityId: cityId ?? this.cityId,
      realedType: realedType ?? this.realedType,
      selectedCity: selectedCity ?? this.selectedCity,
      district: district ?? this.district,
      districtId: districtId ?? this.districtId,
      images: images ?? this.images,
      mainImage: mainImage ?? this.mainImage,
      selectedImage: selectedImage ?? this.selectedImage,
      price: price ?? this.price,
      isCheckBox: isCheckBox ?? this.isCheckBox,
      badrooms: badrooms ?? this.badrooms,
      boards: boards ?? this.boards,
      bathrooms: bathrooms ?? this.bathrooms,
      age: age ?? this.age,
      title: title ?? this.title,
      description: description ?? this.description,
      value: value ?? this.value,
      values: values ?? this.values,
      selectExtraOption: selectExtraOption ?? this.selectExtraOption,
      selectExtraOptions: selectExtraOptions ?? this.selectExtraOptions,
      firstImage: firstImage ?? this.firstImage,
    );
  }
}
