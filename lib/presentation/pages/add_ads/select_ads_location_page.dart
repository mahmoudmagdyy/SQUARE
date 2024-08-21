import 'dart:async';

import 'package:flutter/cupertino.dart';
import '/index.dart';

class SelectAdsLocationPage extends StatefulWidget {
  const SelectAdsLocationPage({super.key});

  @override
  State<SelectAdsLocationPage> createState() => _SelectAdsLocationPageState();
}

class _SelectAdsLocationPageState extends State<SelectAdsLocationPage> {
  @override
  void initState() {
    sl<LocationBloc>().add(const OnChangedPoppedBeFalseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            sl<LocationBloc>().add(const OnChangedPoppedBeTrueEvent());
            return Future.value(true);
          },
          child: sl<LocationBloc>().state.isPopped!
              ? const SizedBox.shrink()
              : Scaffold(
                  body: sl<LocationBloc>().state.cameraPosition == null
                      ? const LoadingWidget(color: AppColors.primary)
                      : Stack(
                          children: [
                            GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition:
                                  sl<LocationBloc>().state.cameraPosition!,
                              zoomControlsEnabled: false,
                              minMaxZoomPreference:
                                  const MinMaxZoomPreference(0, 16),
                              markers: Set<Marker>.of(
                                  sl<LocationBloc>().state.markers!),
                              onMapCreated: (controller) => sl<LocationBloc>()
                                  .controller
                                  .complete(controller),
                              circles: {
                                Circle(
                                  circleId: const CircleId("1"),
                                  center: sl<LocationBloc>().state.latLng!,
                                  radius: 300.0,
                                  strokeWidth: 1,
                                  strokeColor:
                                      AppColors.primary.withOpacity(0.40),
                                  fillColor:
                                      AppColors.primary.withOpacity(0.15),
                                ),
                              },
                              onTap: (LatLng latLng) => sl<LocationBloc>()
                                  .add(GetMarkersEvent(latLng: latLng)),
                            ),
                            Positioned(
                              top: 20.h,
                              right: 20.w,
                              left: 20.w,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: gPadding(top: 25),
                                    child: IconButton.filled(
                                      style: IconButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: 4.radius),
                                        backgroundColor: AppColors.primary,
                                      ),
                                      onPressed: () {
                                        sl<LocationBloc>().add(
                                            const OnChangedPoppedBeTrueEvent());
                                        i<NavigationService>().pop();
                                      },
                                      icon: Icon(
                                        CupertinoIcons.arrow_right,
                                        color: AppColors.white,
                                        size: 20.h,
                                      ),
                                    ),
                                  ),
                                  10.width,
                                  const Expanded(
                                    child: TextInputWidget(
                                      '',
                                      hintText: 'ابحث عن الاحياء',
                                      prefixIcon: Icons.search,
                                      fillColor: AppColors.white,
                                      prefixColor: AppColors.orange,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 20.w,
                              left: 20.w,
                              child: CardConfirmLocationContent(
                                callback: () => sl<LocationBloc>()
                                    .add(const GetCurrentLocationEvent()),
                              ),
                            ),
                          ],
                        ),
                ),
        );
      },
    );
  }
}
