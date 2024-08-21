// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:aqarat/index.dart';

part 'upload_aqar_event.dart';
part 'upload_aqar_state.dart';

class UploadAqarBloc extends Bloc<UploadAqarEvent, UploadAdInitial> {
  final GetCitiesUseCase _getCitiesUseCase;
  final GetTypesAqarUseCase _getTypesAqarUseCase;
  final GetQuestionsUseCase _getQuestionsUseCase;
  final GetExtraOptionsUseCase _getExtraOptionsUseCase;
  final UploadUseCase _uploadUseCase;
  final LocationBloc _locationBloc;
  // final HomeBloc _homeBloc;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController spaceController = TextEditingController();

  UploadAqarBloc(
    this._getCitiesUseCase,
    this._getTypesAqarUseCase,
    this._getQuestionsUseCase,
    this._getExtraOptionsUseCase,
    this._uploadUseCase,
    this._locationBloc,
    /* this._homeBloc, */
  ) : super(const UploadAdInitial()) {
    on<GetCitiesEvent>(_getCitiesEvent);
    on<GetTypesAqarEvent>(_getTypesAqarEvent);
    on<GetQuestionsEvent>(_getQuestionsEvent);
    on<GetExtraOptionsEvent>(_getExtraOptionsEvent);
    on<GetTypeAdEvent>(_getTypeAdEvent);
    on<GetPaymentEvent>(_getPaymentAdEvent);
    on<GetRealedTypeEvent>(_getRealedTypeAdEvent);
    on<GetSpaceEvent>(_getspaceAdEvent);
    on<GetTypeAqarEvent>(_getTypeAqarEvent);
    on<GetCityAqarEvent>(_getCityAqarEvent);
    on<GetDistrictAqarEvent>(_getDistrictAqarEvent);
    on<GetImagesAqarEvent>(_getImagesAqarEvent);
    on<GetMainImagesAqarEvent>(_getMainImageAqarEvent);
    on<RemoveImageAqarEvent>(_removeImageAqarEvent);
    on<GetPriceAqarEvent>(_getPriceAqarEvent);
    on<GetCheckBoxAqarEvent>(_getCheckBoxAqarEvent);
    on<GetValueAqarEvent>(_getValuesAqarEvent);
    /*  on<GetBadRoomsAqarEvent>(_getBadRoomsAqarEvent);
    on<GetBoardsAqarEvent>(_getBoardsAqarEvent);
    on<GetBathRoomsAqarEvent>(_getBathRoomsAqarEvent); */
    on<GetAgeAqarEvent>(_getAgeAqarEvent);
    on<GetTitleAqarEvent>(_getTitleAqarEvent);
    on<GetDescriptionAqarEvent>(_getDescriptionAqarEvent);
    on<GetExtraOptionAqarEvent>(_getExtraOptionsAqarEvent);
    on<UploadNewAqarEvent>(_uploadNewAqarEvent);
  }
  // get cities when upload ad
  Future<void> _getCitiesEvent(
    GetCitiesEvent event,
    Emitter<UploadAdInitial> emit,
  ) async {
    // loading
    emit(state.copyWith(requestStateCity: RequestState.loading));
    final result = await _getCitiesUseCase();
    result.fold(
      (left) =>
          // error
          emit(state.copyWith(requestStateCity: RequestState.error)),
      (right) =>
          // loaded
          emit(
        state.copyWith(
          requestStateCity: RequestState.loaded,
          cities: right,
        ),
      ),
    );
  }

  // get types
  Future<void> _getTypesAqarEvent(
    GetTypesAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) async {
    // loading
    emit(state.copyWith(requestStateType: RequestState.loading));
    final result = await _getTypesAqarUseCase();
    result.fold(
      (left) =>
          // error
          emit(state.copyWith(requestStateType: RequestState.error)),
      (right) =>
          // loaded
          emit(
        state.copyWith(
          requestStateType: RequestState.loaded,
          types: right,
        ),
      ),
    );
  }

  // get extra options
  Future<void> _getQuestionsEvent(
    GetQuestionsEvent event,
    Emitter<UploadAdInitial> emit,
  ) async {
    // loading
    emit(state.copyWith(requestStateQuestion: RequestState.loading));
    final result = await _getQuestionsUseCase();
    result.fold(
      (left) =>
          // error
          emit(state.copyWith(requestStateQuestion: RequestState.error)),
      (right) =>
          // loaded
          emit(
        state.copyWith(
          requestStateQuestion: RequestState.loaded,
          questions: right,
        ),
      ),
    );
  }

  Future<void> _getExtraOptionsEvent(
    GetExtraOptionsEvent event,
    Emitter<UploadAdInitial> emit,
  ) async {
    // loading
    emit(state.copyWith(requestStateExtraOptions: RequestState.loading));
    final result = await _getExtraOptionsUseCase();
    result.fold(
      (left) =>
          // error
          emit(state.copyWith(requestStateExtraOptions: RequestState.error)),
      (right) =>
          // loaded
          emit(
        state.copyWith(
          requestStateExtraOptions: RequestState.loaded,
          extraOptions: right,
        ),
      ),
    );
  }

  void _getTypeAdEvent(
    GetTypeAdEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(adType: event.adType, adIdType: event.adIdType));
    log("Get Type Ad Event ===> ${state.adType}");
    log("Get Type Ad Id Event ===> ${state.adIdType}");
  }

  void _getPaymentAdEvent(
    GetPaymentEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(payment: event.payment));
    print("Get Type Ad Event ===> ${state.payment}");
  }

  void _getRealedTypeAdEvent(
    GetRealedTypeEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(realedType: event.realedType));
    print("Get Type Ad Event ===> ${state.realedType}");
  }

  void _getspaceAdEvent(
    GetSpaceEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(space: event.space));
    print("Get Type Ad Event ===> ${state.payment}");
  }

  void _getTypeAqarEvent(
    GetTypeAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(
        state.copyWith(aqarType: event.aqarType, aqarIdType: event.aqarIdType));
    log("Get Type Aqar Id Event ===> ${state.aqarIdType}");
    log("Get Type Aqar Event ===> ${state.aqarType}");
  }

  void _getCityAqarEvent(
    GetCityAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(
      city: event.city,
      selectedCity: event.selectedCity,
      cityId: event.cityId,
      district: '',
    ));
    log("Get City Aqar Event ===> ${state.city}");
    log("Get Selected City Aqar Event ===> ${state.selectedCity}");
    log("Get City Aqar Id Event ===> ${state.cityId}");
  }

  void _getDistrictAqarEvent(
    GetDistrictAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(
        state.copyWith(district: event.district, districtId: event.districtId));
    log("Get District Aqar Event ===> ${state.district}");
    log("Get District Aqar Id Event ===> ${state.districtId}");
  }

  void _getImagesAqarEvent(
    GetImagesAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    List<File> updatedImages = List<File>.from(state.images)
      ..addAll(event.images);
    emit(state.copyWith(images: updatedImages));
    i<NavigationService>().pop();

    log("Get Images Aqar Event ===> ${state.images}");
  }

  void _getMainImageAqarEvent(
    GetMainImagesAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    print("Main Image ===> ${event.mainImage}");
    File mainImage = state.mainImage!;
    i<NavigationService>().pop();
    emit(state.copyWith(mainImage: mainImage));

    log("Get Images Aqar Event ===> ${state.mainImage}");
  }

  void pickFirstImage(File image) {
    emit(state.copyWith(firstImage: image));
    void getMainImageAqarEvent(
      GetMainImagesAqarEvent event,
      Emitter<UploadAdInitial> emit,
    ) {
      print("Main Image ===> ${event.mainImage}");
      File mainImage = state.mainImage!;
      i<NavigationService>().pop();
      emit(state.copyWith(mainImage: mainImage));

      log("Get Images Aqar Event ===> ${state.mainImage}");
    }
  }

  void _removeImageAqarEvent(
    RemoveImageAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    List<File> updatedImages = List<File>.from(state.images)
      ..removeAt(event.selectedImage);

    emit(state.copyWith(
        selectedImage: event.selectedImage, images: updatedImages));
    /* emit(state.copyWith(images: updatedImages)); */
    log("Index ===> ${state.selectedImage}");
    log("Remove Images Aqar Event ===> ${state.images}");
  }

  removemainImageAqarEvent() {
    mainImage = null;
    emit(state.copyWith(mainImage: null));
  }

  void _getPriceAqarEvent(
    GetPriceAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(price: event.price));

    log("Get Price Aqar Event ===> ${state.price}");
  }

  void _getCheckBoxAqarEvent(
    GetCheckBoxAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(isCheckBox: event.isCheckBox));

    log("Get Check Box Aqar Event ===> ${state.isCheckBox}");
  }

  void _getValuesAqarEvent(
    GetValueAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    final List<Map<String, String>> values = List.from(state.values);
    final existingIndex =
        values.indexWhere((element) => element['id'] == event.value['id']);
    if (existingIndex >= 0) {
      // Update the existing element
      values[existingIndex] = event.value;
    } else {
      values.add(event.value);
    }

    emit(state.copyWith(values: values));
    log("Get Values Aqar Event ===> ${state.values}");
  }

  /*  void _getBadRoomsAqarEvent(
    GetBadRoomsAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(badrooms: event.badrooms));

    log("Get Bad Room Aqar Event ===> ${state.badrooms}");
  }

  void _getBoardsAqarEvent(
    GetBoardsAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(boards: event.boards));

    log("Get Boards Aqar Event ===> ${state.boards}");
  }

  void _getBathRoomsAqarEvent(
    GetBathRoomsAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(bathrooms: event.bathrooms));

    log("Get Bath Rooms Aqar Event ===> ${state.bathrooms}");
  } */

  void _getAgeAqarEvent(
    GetAgeAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(age: event.age));

    log("Get Age Aqar Event ===> ${state.age}");
  }

  void _getTitleAqarEvent(
    GetTitleAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(title: event.title));

    log("Get Title Aqar Event ===> ${state.title}");
  }

  void _getDescriptionAqarEvent(
    GetDescriptionAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    emit(state.copyWith(description: event.description));

    log("Get Description Aqar Event ===> ${state.description}");
  }

  void _getExtraOptionsAqarEvent(
    GetExtraOptionAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) {
    List<String> options = state.selectExtraOptions.toList();
    if (options.contains(event.selectExtraOption)) {
      options.remove(event.selectExtraOption);
    } else {
      options.length >= 4 ? null : options.add(event.selectExtraOption);
    }
    emit(state.copyWith(selectExtraOptions: options));

    log("Get Extra Options Aqar Event ===> ${state.selectExtraOptions}");
  }

  final List<File> _compressedImages = [];
  Future<void> _compressedFile() async {
    _compressedImages.clear();
    for (File element in state.images) {
      File file = await OtherMethods.compressedFile(file: element);
      _compressedImages.add(file);
      log("size after compressed ---> ${file.lengthSync() / 1024} KB");
    }
  }

  File? mainImage;

  Future<void> _uploadNewAqarEvent(
    UploadNewAqarEvent event,
    Emitter<UploadAdInitial> emit,
  ) async {
    emit(state.copyWith(requestState: RequestState.loading));
    await _compressedFile();
    var params = UploadParameter(
      typeStatus: state.realedType,
      payment: state.payment,
      space: int.parse(spaceController.text),
      adIdType: state.adIdType,
      aqarIdType: state.aqarIdType,
      cityId: state.cityId,
      areaId: state.districtId,
      lat: _locationBloc.state.latLng!.latitude.toString(),
      lng: _locationBloc.state.latLng!.longitude.toString(),
      firstImage: mainImage,
      images: _compressedImages.toList(),
      price: priceController.text,
      questions: state.values,
      age: state.age,
      title: titleController.text,
      description: descriptionController.text,
      tools: state.selectExtraOptions,
    );

    log('Params $params');
    final result = await _uploadUseCase(params);
    result.fold((left) {
      showSnackBar(message: left.message, isError: true);
      emit(state.copyWith(requestState: RequestState.error));

      log("error in upload ==> ${left.message}");
    }, (right) {
      // _homeBloc.add(const GetHomeEvent());
      clearAllData();
      showSnackBar(message: "هذا الإعلان تحت المراجعة");
      emit(state.copyWith(requestState: RequestState.loaded));

      i<NavigationService>().toNamedAndRemoveUntil(Routes.main);
      log("success");
    });
  }

  void clearAllData() {
    mainImage = null;
    var images = state.images;
    titleController.clear();
    descriptionController.clear();
    spaceController.clear();
    priceController.clear();
    var values = state.values;
    var select = state.selectExtraOptions;
    var adIdType = state.adIdType;
    var aqarIdType = state.aqarIdType;
    var cityId = state.cityId;
    var districtId = state.districtId;
    var price = state.price;
    var age = state.age;
    var title = state.title;
    var description = state.description;

    adIdType = '';
    aqarIdType = '';
    cityId = '';
    districtId = '';
    price = '';
    age = '';
    title = '';
    description = '';
    if (images.isNotEmpty) images.clear();

    if (values.isNotEmpty) values.clear();
    if (select.isNotEmpty) select.clear();
    if (state.images.isNotEmpty) state.images.clear();
    if (state.values.isNotEmpty) state.values.clear();
    if (state.selectExtraOptions.isNotEmpty) state.selectExtraOptions.clear();

    emit(
      state.copyWith(
        mainImage: mainImage,
        adIdType: adIdType,
        aqarIdType: aqarIdType,
        cityId: cityId,
        districtId: districtId,
        price: price,
        age: age,
        title: title,
        description: description,
        images: images,
        values: values,
        selectExtraOptions: select,
      ),
    );
    emit(state.copyWith(adType: '', adIdType: ''));
    emit(state.copyWith(aqarType: '', aqarIdType: ''));
    emit(state.copyWith(city: '', cityId: ''));
    emit(state.copyWith(district: '', districtId: ''));
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    spaceController.dispose();
    priceController.dispose();
    return super.close();
  }
}
