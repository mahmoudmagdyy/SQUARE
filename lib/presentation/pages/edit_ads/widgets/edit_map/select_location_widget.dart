import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';

class SelectLocationWidget extends StatelessWidget {
  const SelectLocationWidget({
    super.key,
    required this.latLng,
    // required this.widget,
  });
  final LatLng latLng;

  // final EditAdMapScreen widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyAdCubit, EditMyAdState>(
      builder: (context, state) {
        return Positioned(
          bottom: 0,
          right: 20.w,
          left: 20.w,
          child: Container(
            padding: gPadding(right: 20, top: 15, left: 20, bottom: 15),
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
                Row(
                  children: [
                    Expanded(
                      child: CardOptionWidget(
                        mainAxisAlignment: MainAxisAlignment.center,
                        image: AppImages.locationDuotone,
                        title: "موقعك الحالي",
                        callback: () {
                          state.mapController!.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: state.currentLocation!,
                                zoom: 16.0,
                              ),
                            ),
                          );
                        },
                        isSelected: false,
                      ),
                    ),
                    10.width,
                    Expanded(
                      child: CardOptionWidget(
                        mainAxisAlignment: MainAxisAlignment.center,
                        image: AppImages.locationDuotone,
                        title: "موقع العقار",
                        callback: () {
                          state.mapController!.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: latLng,
                                zoom: 16.0,
                              ),
                            ),
                          );
                        },
                        isSelected: false,
                      ),
                    ),
                  ],
                ),
                30.height,
                BtnWidget(
                  title: 'تأكيد',
                  backgroundColor: AppColors.primary,
                  onTap: () {
                    // log(state.property!.lat.toString());
                    // log(state.property!.lng.toString());
                    i<NavigationService>().toNamed(
                      Routes.editMyAdsImage,
                      // arguments: {
                      //   'item': '',
                      //   'index': '',
                      // },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
