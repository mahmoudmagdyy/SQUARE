import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/my_favorites/my_favorites_cubit.dart';
import 'package:get/get.dart';

import '../../../../core/functions/share_ads_with_image.dart';
import '../../../bloc/profile/profile_bloc.dart';

class CardAdWidget extends StatelessWidget {
  const CardAdWidget({
    super.key,
    required this.adsModel,
    this.isFromShared = false,
  });
  final AdsEntity adsModel;
  final bool isFromShared;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => i<NavigationService>().toNamed(
        Routes.adsDetails,
        arguments: {
          'item': adsModel,
          'fromMyAds': false,
        },
      ),
      child: Container(
        padding: gPaddingSymmetric(horizontal: 12.5, vertical: 12.5),
        decoration: BoxDecoration(
            color: AppColors.containerBackground.withOpacity(.25),
            borderRadius: 10.radius,
            border: Border.all(color: AppColors.grey.withOpacity(0.4))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppImages.date, height: 18.h, width: 18.h),
                    5.width,
                    TextWidget(
                      adsModel.createdAt,
                      style: getTextStyleSimSmall(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textGray3,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 6.r,
                      backgroundColor: AppColors.primary,
                    ),
                    10.width,
                    TextWidget(
                      "غير مقروء",
                      style: getTextStyleSimSmall(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textGray3,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<MyFavoritesCubit, MyFavoritesState>(
                  builder: (context, state) {
                    var favCubit = context.read<MyFavoritesCubit>();
                    return InkWell(
                      onTap: () {
                        sl<SharedPreferences>().getBool("isAnonymous")==false?{
                        print(
                        '999999999999999 ${BlocProvider.of<ProfileBloc>(context).email}'),
                        if (adsModel.user.email ==
                            BlocProvider.of<ProfileBloc>(context).email) {
                          // ignore: void_checks
                           showSnackBar(
                            message: "لا يمكنك اضافة اعلانك الى المفضلة",
                            isError: true,
                          ),
                        } else {
                          favCubit.addOrRemoveFav(adsModel.id),
                        }
                        }:(){};

                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 50.w),
                        child: CircleAvatar(
                          radius: 18.r,
                          backgroundColor: AppColors.primary.withOpacity(.20),
                          child: favCubit.isInFavList(adsModel.id)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : SvgPicture.asset(AppImages.heart),
                        ),
                      ),
                    );
                  },
                ),
                isFromShared
                    ? InkWell(
                        onTap: () async {
                          shareAdsWithImage(adsModel.firstImage, adsModel.code);
                        },
                        child: CircleAvatar(
                          radius: 18.r,
                          backgroundColor: AppColors.primary.withOpacity(.15),
                          child: SvgPicture.asset(AppImages.share),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            Divider(color: AppColors.grey.withOpacity(0.5)),
            TextWidget(
              adsModel.title,
              style: getTextStyleSimSmall(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: gPaddingSymmetric(horizontal: 7.5, vertical: 7.5),
                  decoration: BoxDecoration(
                    color: AppColors.orange.withOpacity(.25),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppImages.pinlocation,
                    height: 12.5.h,
                    width: 12.5.h,
                  ),
                ),
                7.5.width,
                TextWidget(adsModel.city),
                2.5.width,
                TextWidget(
                  adsModel.area,
                  style: getTextStyleNormal(
                    color: AppColors.textGray1,
                  ),
                ),
              ],
            ),
            Divider(color: AppColors.grey.withOpacity(0.5)),
            2.5.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NetworkImageWidget(
                  adsModel.user.image,
                  height: 18.5.h,
                  width: 18.5.h,
                  borderRadius: 18.5.radius,
                ),
                10.width,
                TextWidget(
                  adsModel.user.name,
                  style: getTextStyleNormal(
                      fontSize: 13.0.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
