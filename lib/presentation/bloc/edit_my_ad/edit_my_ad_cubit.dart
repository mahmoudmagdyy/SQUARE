import 'dart:developer';
import 'dart:io';

import 'package:aqarat/data/model/property.dart' as model;
import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/data/repository/my_ads/my_ads_repository.dart';
import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/pages/add_ads/widgets/type_aqar_content.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'edit_my_ad_state.dart';

class EditMyAdCubit extends Cubit<EditMyAdState> {
  final MyAdsRepository _adsRepository;
  EditMyAdCubit(this._adsRepository) : super(const EditMyAdState());

  late Property currentProperty;
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _aqarAreaController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  TextEditingController get detailsController => _detailsController;
  TextEditingController get addressController => _addressController;
  TextEditingController get priceController => _priceController;
  TextEditingController get aqarAreaController => _aqarAreaController;
  TextEditingController get titleController => _titleController;


  void assignDataToControllers() {
    _detailsController.text = state.property!.description.toString();
    _addressController.text =
        '${state.property!.city} - ${state.property!.area}';
    _priceController.text = state.property!.price.toString();
    _aqarAreaController.text = state.property!.space.toString();
    _titleController.text = state.property!.title.toString();
  }

  void assignProperty(model.Property property) {
    emit(
      state.copyWith(
        property: property,
        firstImage: property.firstImage,
      ),
    );
  }

  void getCurrentAds({required int index}) async {
    sl<UploadAqarBloc>().add(GetCitiesEvent());
    emit(state.copyWith(getCurrentAdByIdRequestState: RequestState.loading));

    final response = await _adsRepository.getAdById(index);

    response.fold(
      (l) {
        log('Error in Get My Ads $l');
        emit(
          state.copyWith(
            getCurrentAdByIdRequestState: RequestState.error,
            getCurrentAdByIdErrorMessage: l.message,
          ),
        );
      },
      (r) {
        currentProperty = r;

        var currentCityId = sl<UploadAqarBloc>()
            .state
            .cities
            .firstWhere((element) => element.name == r.city)
            .id;

        var districts = sl<UploadAqarBloc>()
            .state
            .cities
            .firstWhere(
              (element) => element.id == currentCityId,
            )
            .area!;
        AreaEntity? currentAqarTypeId;
        if (sl<UploadAqarBloc>().state.types.isNotEmpty) {
          currentAqarTypeId = sl<UploadAqarBloc>().state.types.firstWhere(
                (element) =>
                    element.name.toString().trim().toLowerCase() ==
                    r.category.trim().toLowerCase(),
              );
        }
        var isForSale = r.type == AppStrings.sale;

        log('Get Current Districts $districts');
        log('Get Current  Ads Success ${r.type}');
        log('Get Current  Ads currentCityId  $currentCityId');
        log('Get Current  Aqar Type  $currentAqarTypeId');

        emit(
          state.copyWith(
            getCurrentAdByIdRequestState: RequestState.loaded,
            property: r,
            aqarCityID: currentCityId,
            districts: districts,
            isForSale: isForSale,
            categoryId: currentAqarTypeId?.id ?? 0,
          ),
        );
      },
    );
  }

  void toggleIsForSale(int index) {
    if (adTypeList[index] != AppStrings.sale) {
      emit(state.copyWith(isForSale: false));
    } else {
      emit(state.copyWith(isForSale: true));
    }
  }

  void deleteImageFromList(model.Image image) {
    final property = state.property;
    property!.images.remove(image);
    emit(state.copyWith(property: property));
  }

  void pickNewAdditionalImage(bool isFromCamera) async {
    var allImages = [...state.pickedImage];
    // var allImages = state.pickedImage;
    ImagePicker picker = ImagePicker();
    if (isFromCamera) {
      XFile? res = await picker.pickImage(source: ImageSource.camera);
      if (res != null) {
        allImages.add(File(res.path));
        state.property!.images.add(
          model.Image(
            id: res.hashCode,
            image: res.path,
            isFileImage: true,
          ),
        );
        emit(state.copyWith(pickedImage: allImages));
      }
    } else {
      List<XFile>? result = await picker.pickMultiImage();
      allImages = [];
      allImages.addAll(
        result.map<File>(
          (e) => File(e.path),
        ),
      );
      state.property!.images.addAll(
        allImages.map(
          (e) => model.Image(
            id: e.hashCode,
            image: e.path,
            isFileImage: true,
          ),
        ),
      );
      emit(state.copyWith(pickedImage: allImages, property: state.property));
    }
  }
 static List<int> deletedImage = [];
  void deleteNewAdditionalPickedImage(int index) {
    final pickedImage = [...state.property!.images];
    final deleteImage = [...state.property!.images];
    final property = state.property;
    log('ImagesDelete  $deletedImage');
    log('Images  $state.deletedImages');
    // log('ProImages  ${property!.images[index].id}');
    emit(state.copyWith(property: property, ));
    log('ProImages Length ${property!.images.length}');
    pickedImage.removeAt(index);
    log('ProImages Length ${property!.images.length}');
    property.images = pickedImage;
    log('ProImages Length ${property.images.length}');
    emit(state.copyWith(property: property,));
    deletedImage.add(deleteImage[index].id);

  }

  void selectNewFirstImage(bool isFromCamera) async {
    var property = state.property;
    ImagePicker picker = ImagePicker();
    XFile? res = await picker.pickImage(
      source: isFromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    log('Path ${res?.path.toString()}');
    if (res != null) {
      property!.firstImage = res.path;

      emit(state.copyWith(property: property, firstImage: res.path),);
    }
  }

  void deleteFirstImage() {
    var firstImage = state.firstImage;

    var property = state.property;
    emit(
      state.copyWith(
        firstImage: currentProperty.firstImage,
        property: property,

      ),
    );
    currentProperty.firstImage = null;
    firstImage = null;
    property?.firstImage = null;


    log('currentProperty.firstImage ${currentProperty.firstImage}');
    log('firstImage $firstImage');
    log('property?.firstImage ${property?.firstImage}');

    emit(state.copyWith(firstImage: firstImage, property: property));
  }

  void updatePrice(String price) {
    final property = state.property;
    property!.price = price.toString();
    _priceController.text = price.toString();
    emit(state.copyWith(property: property, price: price));
  }

  void changeAdType(String type, int index) {
    final property = state.property;
    emit(state.copyWith(property: property));
    property!.type = type;
    emit(state.copyWith(property: property, aqarIdType: index));
  }

  void deleteAllImage() {
    final pickedImage = [...state.pickedImage];
    pickedImage.clear();

    emit(state.copyWith(pickedImage: pickedImage));
  }

  void onAqarCategoryChange(int index) {
    final currentProperty = state.property;
    var currentCategory = sl<UploadAqarBloc>().state.types[index].name;
    var currentCategoryId = sl<UploadAqarBloc>().state.types[index].id;
    currentProperty?.category = currentCategory.toString();

    log('currentCategory $currentCategory');
    log('currentCategoryId $currentCategoryId');

    emit(state.copyWith(
        property: currentProperty, categoryId: currentCategoryId));
  }

  void onAqarCityChange(int index) {
    final currentProperty = state.property;
    var currentCityName = sl<UploadAqarBloc>().state.cities[index].name;
    var currentCityId = sl<UploadAqarBloc>().state.cities[index].id;
    currentProperty?.city = currentCityName.toString();
    currentProperty!.area = '';
    var districts = [...sl<UploadAqarBloc>().state.cities[index].area ?? []];

    emit(
      state.copyWith(
        property: currentProperty,
        aqarCityID: currentCityId,
        districts: districts,
      ),
    );
  }

  void onAqarDistrictChange(int index) {
    final currentProperty = state.property;
    var currentDistrict =
        sl<UploadAqarBloc>().state.cities[state.aqarCityID!].area![index].name;
    currentProperty?.area = currentDistrict.toString();
    emit(state.copyWith(property: currentProperty));
  }

  Future<Position?> _getCurrentPosition() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    var isDenied = await Permission.location.isDenied;
    if (isLocationEnabled && !isDenied) {
      return _getCurrentLocation();
    } else {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _handlePermissionDenied();
      } else {
        return _getCurrentLocation();
      }
    }
    return null;
    // return position;
  }

  Future<Position> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    log(position.toString(), name: 'Current Location');
    return position;
  }

  void _handlePermissionDenied() async {
    showSnackBar(
      message: 'من فضلك تفعيل خدمة الموقع',
      isError: true,
    );

    await Future.delayed(
      const Duration(seconds: 3),
      () async {
        await Geolocator.openAppSettings().then(
          (value) {
            log('Open App Settings');
            if (value) {
              _getCurrentPosition();
            }
          },
        );
      },
    );
  }

  void changePaymentMethod(String method) {
    final property = state.property;
    property!.payment = method;
    log("Property Payment ${property.payment}");
    emit(state.copyWith(property: property, paymentMethod: method));
  }

  void changeAdLocation(LatLng latLng) {
    log('New Aqar Location $latLng');

    state.markers.removeWhere(
      (element) => element.markerId.value == 'Current Ad Location',
    );
    log('All Marker Length ${state.markers.length}');
    emit(state.copyWith(markers: state.markers));
    var marker = Marker(
      markerId: const MarkerId('Current Ad Location'),
      infoWindow: const InfoWindow(title: "Current Ad Location"),
      position: latLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
    );
    state.markers.add(marker);
    state.property!.lat = latLng.latitude.toString();
    state.property!.lng = latLng.longitude.toString();

    log('All Marker Length ${state.markers.length}');
    emit(
      state.copyWith(
        markers: state.markers,
        property: state.property,
      ),
    );
  }

  void getCurrentLocation(LatLng latLng) async {
    emit(state.copyWith(isMapLoading: true));
    var allMarker = {...state.markers};

    await _getCurrentPosition().then(
      (position) {
        emit(
          state.copyWith(
            cameraPosition: CameraPosition(
              target: LatLng(
                position!.latitude,
                position.longitude,
              ),
              zoom: 16.0,
            ),
          ),
        );

        log('Current Location ${position.latitude} ${position.longitude}');
        allMarker.clear();
        emit(state.copyWith(markers: allMarker));
        allMarker.add(
          Marker(
            markerId: const MarkerId('Current Location'),
            infoWindow: const InfoWindow(title: "Current Location"),
            position: LatLng(position.latitude, position.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            ),
          ),
        );
        allMarker.add(
          Marker(
            markerId: const MarkerId('Current Ad Location'),
            infoWindow: const InfoWindow(title: "Current Ad Location"),
            position: latLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          ),
        );
        emit(
          state.copyWith(
            isMapLoading: false,
            markers: allMarker,
            currentLocation: LatLng(position.latitude, position.longitude),
          ),
        );
      },
    );
  }

  void onMapCreated(GoogleMapController controller) {
    emit(state.copyWith(mapController: controller));
  }

  @override
  Future<void> close() {
    debugPrint('Close Edit My Ad Cubit');
    state.mapController?.dispose();
    return super.close();
  }
}
