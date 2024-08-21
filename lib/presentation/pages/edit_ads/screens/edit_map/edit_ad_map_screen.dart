import 'dart:developer';

import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_map/back_button_widget.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_map/edit_google_map_widget.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_map/select_location_widget.dart';

class EditAdMapScreen extends StatefulWidget {
  const EditAdMapScreen({Key? key, required this.latLng}) : super(key: key);
  final LatLng latLng;
  @override
  State<EditAdMapScreen> createState() => _EditAdMapScreenState();
}

class _EditAdMapScreenState extends State<EditAdMapScreen> {
  late GoogleMapController mapController;
  @override
  void initState() {
    // sl<LocationBloc>().add(const OnChangedPoppedBeFalseEvent());
    // context.read<EditMyAdCubit>().assignAdMarker(widget.latLng);
    context.read<EditMyAdCubit>().getCurrentLocation(widget.latLng);
    super.initState();
  }

  @override
  dispose() {
    log('', error: 'Edit My AD Map Close');
    // mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EditMyAdCubit, EditMyAdState>(
        builder: (context, state) {
          return Stack(
            children: [
              EditGoogleMapWidget(latLng: widget.latLng),
              const BackButtonWidget(),
              SelectLocationWidget(latLng: widget.latLng),
            ],
          );
        },
      ),
    );
  }
}

/**
 * Material(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        // initialCameraPosition: state.cameraPosition!,
                        initialCameraPosition: CameraPosition(
                          target: widget.latLng,
                        ),
                        zoomControlsEnabled: false,

                        minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                        markers: state.markers,
                        onMapCreated: (controller) {
                          mapController = controller;

                          context
                              .read<EditMyAdCubit>()
                              .onMapCreated(controller);

                          setState(() {});

                          // Future.delayed(
                          //   const Duration(seconds: 3),
                          //   () {
                          //     controller.animateCamera(
                          //       CameraUpdate.newCameraPosition(
                          //         CameraPosition(
                          //           target: widget.latLng,
                          //           zoom: 16.0,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                        circles: {
                          Circle(
                            circleId: const CircleId("1"),
                            center: state.currentLocation!,
                            radius: 300.0,
                            strokeWidth: 1,
                            strokeColor: AppColors.primary.withOpacity(0.40),
                            fillColor: AppColors.primary.withOpacity(0.15),
                          ),
                        },
                        // onTap: (LatLng latLng) => sl<LocationBloc>().add(
                        //   GetMarkersEvent(
                        //     latLng: latLng,
                        //   ),
                        // ),
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
                        child: Container(
                          padding: gPadding(
                              right: 20, top: 15, left: 20, bottom: 15),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: 10.radius,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextWidget(
                                "اختيار الموقع",
                                style: getTextStyle18(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              5.height,
                              const TextWidget(
                                "يمكنك اختيار موقع محدد أو تقريبي للعقار",
                              ),
                              25.height,
                              SizedBox(
                                height: 120.h,
                                width: .8.sw,
                                child: CardOptionWidget(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  image: AppImages.locationDuotone,
                                  title: "موقع تقريبي",
                                  callback: () {
                                    //Todo: Get Current Location and move camera;
                                  },
                                  isSelected: false,
                                ),
                              ),
                              30.height,
                              BtnWidget(
                                title: 'تأكيد',
                                backgroundColor: AppColors.primary,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
 */
