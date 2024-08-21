// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_my_ad_cubit.dart';

class EditMyAdState extends Equatable {
  const EditMyAdState( {
    // this.deletedImages,
    this.property,
    this.pickedImage = const [],
    this.firstImage,
    this.getCurrentAdByIdErrorMessage,
    this.getCurrentAdByIdRequestState = RequestState.none,
    this.aqarCityID,
    this.districts = const [],
    this.isForSale = true,
    this.paymentMethod,
    this.mapController,
    this.markers = const {},
    this.cameraPosition,
    this.isMapLoading = true,
    this.currentLocation,
    this.selectNewFirstImage,
    this.price,
    this.aqarIdType = 0,
    this.categoryId,
  });
  //! Get Current ad by id
  final RequestState getCurrentAdByIdRequestState;
  final String? getCurrentAdByIdErrorMessage;
  final Property? property;
  final int? aqarCityID;
  final List<dynamic> districts;
  final int? aqarIdType;

  final List<File> pickedImage;
  final String? firstImage;
  // final List<int> ?deletedImages;
  final bool isForSale;
  final String? paymentMethod;

  final File? selectNewFirstImage;
  final String? price;
  final int? categoryId;

  //! Map Data
  final GoogleMapController? mapController;
  final Set<Marker> markers;
  final CameraPosition? cameraPosition;
  final bool isMapLoading;
  final LatLng? currentLocation;

  @override
  List<Object?> get props => [
        property,
        pickedImage,
        firstImage,
        getCurrentAdByIdErrorMessage,
        getCurrentAdByIdRequestState,
        aqarCityID,
        districts,
        isForSale,
        paymentMethod,
        mapController,
        cameraPosition,
        isMapLoading,
        currentLocation,
        selectNewFirstImage,
        price,
        aqarIdType,
        categoryId,
      ];



  EditMyAdState copyWith({
    RequestState? getCurrentAdByIdRequestState,
    String? getCurrentAdByIdErrorMessage,
    Property? property,
    int? aqarCityID,
    List<dynamic>? districts,
    int? aqarIdType,
    List<File>? pickedImage,
    String? firstImage,
    bool? isForSale,
    String? paymentMethod,
    File? selectNewFirstImage,
    String? price,
    int? categoryId,
    GoogleMapController? mapController,
    Set<Marker>? markers,
    CameraPosition? cameraPosition,
    bool? isMapLoading,
    LatLng? currentLocation,
     // List<int>? deletedImages,
  }) {
    return EditMyAdState(
      getCurrentAdByIdRequestState:
          getCurrentAdByIdRequestState ?? this.getCurrentAdByIdRequestState,
      getCurrentAdByIdErrorMessage:
          getCurrentAdByIdErrorMessage ?? this.getCurrentAdByIdErrorMessage,
      property: property ?? this.property,
      aqarCityID: aqarCityID ?? this.aqarCityID,
      districts: districts ?? this.districts,
      aqarIdType: aqarIdType ?? this.aqarIdType,
      pickedImage: pickedImage ?? this.pickedImage,
      firstImage: firstImage ?? this.firstImage,
      isForSale: isForSale ?? this.isForSale,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      selectNewFirstImage: selectNewFirstImage ?? this.selectNewFirstImage,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      mapController: mapController ?? this.mapController,
      markers: markers ?? this.markers,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      isMapLoading: isMapLoading ?? this.isMapLoading,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}
