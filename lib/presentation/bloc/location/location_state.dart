part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState({
    this.requestState = RequestState.none,
    this.cameraPosition,
    this.latLng,
    this.marker,
    this.markers = const [],
    this.isPopped = false,
  });
  final RequestState requestState;
  final CameraPosition? cameraPosition;
  final LatLng? latLng;
  final Marker? marker;
  final List<Marker>? markers;
  final bool? isPopped;

  @override
  List<Object?> get props => [
        requestState,
        cameraPosition,
        latLng,
        marker,
        markers,
        isPopped,
      ];
}

class LocationInitial extends LocationState {
  const LocationInitial({
    super.requestState,
    super.cameraPosition,
    super.latLng,
    super.marker,
    super.markers,
    super.isPopped,
  });
  LocationInitial copyWith({
    RequestState? requestState,
    CameraPosition? cameraPosition,
    LatLng? latLng,
    final Marker? marker,
    List<Marker>? markers,
    final bool? isPopped,
  }) {
    return LocationInitial(
      requestState: requestState ?? this.requestState,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      latLng: latLng ?? this.latLng,
      marker: marker ?? this.marker,
      markers: markers ?? this.markers,
      isPopped: isPopped ?? this.isPopped,
    );
  }
}
