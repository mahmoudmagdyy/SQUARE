part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent( {
    this.cameraPosition,
    this.latLng,
    this.controller,
    this.marker,
    this.isPopped,
  });
  final CameraPosition? cameraPosition;
  final LatLng? latLng;
  final Completer<GoogleMapController>? controller;
  final Marker? marker;
  final bool? isPopped;
  @override
  List<Object?> get props => [
        cameraPosition,
        latLng,
        controller,
        marker,
        isPopped,
      ];
}

class GetCurrentLocationEvent extends LocationEvent {
  const GetCurrentLocationEvent({super.cameraPosition, super.latLng});
}

class InitGoogleMapControllerEvent extends LocationEvent {
  const InitGoogleMapControllerEvent({super.controller});
}

class GetMarkersEvent extends LocationEvent {
  const GetMarkersEvent({super.latLng});
}

class OnChangedPoppedBeTrueEvent extends LocationEvent {
  const OnChangedPoppedBeTrueEvent();
}
class OnChangedPoppedBeFalseEvent extends LocationEvent {
  const OnChangedPoppedBeFalseEvent();
}