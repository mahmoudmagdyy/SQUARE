import 'dart:async';
import 'dart:developer';

import 'package:aqarat/index.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationInitial> {
  LocationBloc() : super(const LocationInitial()) {
    on<GetCurrentLocationEvent>(_getCurrentLocation);
    // on<InitGoogleMapControllerEvent>(_initGoogleMapControllerEvent);
    on<GetMarkersEvent>(_getCurrentMarker);
    on<OnChangedPoppedBeTrueEvent>(_onChangedPoppedBeTrueEvent);
    on<OnChangedPoppedBeFalseEvent>(_onChangedPoppedBeFalseEvent);
  }
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();
  Future<Position> _getCurrentPosition() async {
    Position position;

    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    (isServiceEnabled) ? await Geolocator.requestPermission() : null;
    position = await Geolocator.getCurrentPosition();
    return position;
  }

  // Get Current Location
  Future<void> _getCurrentLocation(
    GetCurrentLocationEvent event,
    Emitter<LocationInitial> emit,
  ) async {
    try {
      emit(state.copyWith(requestState: RequestState.loading));
      await _getCurrentPosition().then(
        (position) {
          // camera position
          emit(
            state.copyWith(
              cameraPosition: CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 16.0,
              ),
            ),
          );
          // lat lng
          emit(state.copyWith(
            requestState: RequestState.loaded,
            latLng: LatLng(position.latitude, position.longitude),
          ));
        },
      );
      add(GetMarkersEvent(latLng: state.latLng));
    } on Exception catch (error) {
      // error
      log("error in get current location ==> $error");
      emit(state.copyWith(requestState: RequestState.error));
    }
  }

  // Get Current Marker
  Future<void> _getCurrentMarker(
    GetMarkersEvent event,
    Emitter<LocationInitial> emit,
  ) async {
    try {
      if (state.markers!.isNotEmpty) {
        state.markers?.clear();
      }
      List<Marker> markers = List<Marker>.from(state.markers!)
        ..add(
          Marker(
            markerId: const MarkerId('Current Location'),
            infoWindow: const InfoWindow(title: "Current Location"),
            position: event.latLng!,
          ),
        );
      emit(state.copyWith(latLng: event.latLng));
      _getNewCameraPosition(latLng: event.latLng!);
      emit(state.copyWith(markers: markers));
      log("LatLng ====> ${state.latLng}");
    } on Exception catch (error) {
      log("error in get current marker ==> $error");
    }
  }

  Future<void> _getNewCameraPosition({required LatLng latLng}) async {
    final GoogleMapController googleMapController = await controller.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: latLng, zoom: 16.0),
    ));
  }

  void _onChangedPoppedBeTrueEvent(
    OnChangedPoppedBeTrueEvent event,
    Emitter<LocationInitial> emit,
  ) {
    emit(state.copyWith(isPopped: true));
  }

  void _onChangedPoppedBeFalseEvent(
    OnChangedPoppedBeFalseEvent event,
    Emitter<LocationInitial> emit,
  ) {
    emit(state.copyWith(isPopped: false));
  }
}
