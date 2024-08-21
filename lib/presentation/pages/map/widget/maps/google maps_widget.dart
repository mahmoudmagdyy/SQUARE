import 'package:permission_handler/permission_handler.dart';

import '../../../../../domain/entities/home/ads_entity.dart';
import '../../../../../index.dart';
import '../../../../bloc/filter/filter_bloc.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  BitmapDescriptor? markerIcon;
  late GoogleMapController _controller;
  CameraPosition? _initialCameraPosition;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return _initialCameraPosition == null
        ? const LoadingWidget(color: AppColors.loadingColor)
        : GoogleMap(
            onCameraIdle: _onCameraIdle,
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition!,
            onMapCreated: _onMapCreated,
            markers: markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
          );
  }

  Future<void> _createMarker() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(180.w, 150.w)),
      AppImages.markers,
    );
  }

  void addMarkers(List<AdsEntity> adsEntity) {
    setState(() {
      markers.clear();
      for (var element in adsEntity) {
        markers.add(
          Marker(
            markerId: MarkerId(element.id.toString()),
            position: LatLng(
              double.parse(element.lat),
              double.parse(element.lng),
            ),
            icon: markerIcon ?? BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: element.title,
              snippet: element.description,
            ),
            onTap: () {
              i<NavigationService>().toNamed(
                Routes.adsDetails,
                arguments: {
                  'item': element,
                  'fromMyAds': false,
                },
              );
            },
          ),
        );
      }
      debugPrint('============================$markers');
    });
  }

  Future<void> _getUserLocation() async {
    await _createMarker();
    try {
      final PermissionStatus permissionStatus =
          await Permission.location.status;

      if (permissionStatus.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        _initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.0,
        );

        setDataToLatAndLng(position.latitude, position.longitude);
      } else {
        final PermissionStatus requestStatus =
            await Permission.location.request();

        if (requestStatus.isGranted) {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          _initialCameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14.0,
          );
          setDataToLatAndLng(position.latitude, position.longitude);
        } else {
          _showMyDialog(context);
          debugPrint("Location permission not granted");
        }
      }
    } catch (e) {
      // Handle errors
      debugPrint("Error getting user location: $e");
    }
  }

  void setDataToLatAndLng(
    double lat,
    double lng,
  ) {
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);
    filterBloc.lat = lat.toString();
    filterBloc.lng = lng.toString();
    filterBloc.add(const GetAdsByFilterEvent());
    addMarkers(filterBloc.state.adsEntity);
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onCameraIdle() {
    _controller
        .getLatLng(const ScreenCoordinate(x: 0, y: 0))
        .then((LatLng latLng) {
      debugPrint("Camera stopped at: ${latLng.latitude}, ${latLng.longitude}");
      setDataToLatAndLng(latLng.latitude, latLng.longitude);
    });
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text(
            'صلاحيه الموقع غير مفعله',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.red,
            ),
          ),
          content: const SingleChildScrollView(
            child: Center(
                child: Text(
              'يجب تفعيل صلاحيه الموقع لتتمكن من استخدام الخريطه',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
              ),
            )),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();

                Future.delayed(const Duration(seconds: 20), () {
                  _getUserLocation();
                });
              },
              child: const Text('تفعيل'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('لاحقا', style: TextStyle(color: AppColors.red)),
            ),
          ],
        );
      },
    );
  }
}
