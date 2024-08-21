import 'dart:developer';

import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';

class EditGoogleMapWidget extends StatefulWidget {
  const EditGoogleMapWidget({super.key, required this.latLng});
  final LatLng latLng;

  @override
  State<EditGoogleMapWidget> createState() => _EditGoogleMapWidgetState();
}

class _EditGoogleMapWidgetState extends State<EditGoogleMapWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyAdCubit, EditMyAdState>(
      builder: (context, state) {
        return GoogleMap(
          myLocationEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: widget.latLng,
            zoom: 16,
          ),
          zoomControlsEnabled: false,
          minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
          markers: state.markers,
          onMapCreated: (controller) {
            // mapController = controller;
            context.read<EditMyAdCubit>().onMapCreated(controller);
          },
          circles: {
            Circle(
              circleId: const CircleId("1"),
              // center: state.currentLocation!,
              center: widget.latLng,
              radius: 300.0,
              strokeWidth: 1,
              strokeColor: AppColors.primary.withOpacity(0.40),
              fillColor: AppColors.primary.withOpacity(0.15),
            ),
          },
          onTap: (LatLng latLng) {
            log('${latLng.latitude} ${latLng.longitude}');
            context.read<EditMyAdCubit>().changeAdLocation(latLng);
            setState(() {});
          },
        );
      },
    );
  }
}
