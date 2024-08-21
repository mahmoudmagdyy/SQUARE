import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/presentation/bloc/my_favorites/my_favorites_cubit.dart';

import '../bloc/profile/profile_bloc.dart';
import '/index.dart';

class BigCardAdsWidget extends StatelessWidget {
  const BigCardAdsWidget(
      {super.key, required this.adsEntity, this.showShare = false});
  final AdsEntity adsEntity;
  final bool showShare;
  @override
  Widget build(BuildContext context) {
    List<String> images = [];
    images.add(adsEntity.firstImage);
    for (var element in adsEntity.images) {
      images.add(element.image);
    }
    return Container(
      alignment: Alignment.center,
      padding: gPadding(left: 10, top: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: 10.radius,
          color: AppColors.containerBackground2,
          border: Border.all(color: AppColors.grey)),
      child: InkWell(
        onTap: () => i<NavigationService>().toNamed(
          Routes.adsDetails,
          // arguments: adsEntity,
          arguments: {
            'item': adsEntity,
            'fromMyAds': false,
          },
        ),
        child: Column(
          children: [
            _buildBunnerContent(images: images),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  adsEntity.title,
                  style: getTextStyleSimSmall(
                    color: AppColors.textColor2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppImages.date,
                        height: 16.5.h, width: 16.5.h),
                    7.5.width,
                    TextWidget(
                      adsEntity.createdAt,
                      style: getTextStyleSimSmall(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textGray3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            7.5.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButtonWidget(
                  onTap: () {},
                  color: AppColors.orange,
                  image: AppImages.pinlocation,
                  backgroundColor: AppColors.orange.withOpacity(.25),
                ),
                7.5.width,
                TextWidget(adsEntity.city),
                2.5.width,
                TextWidget(
                  adsEntity.area,
                  style: getTextStyleNormal(color: AppColors.textGray1),
                ),
              ],
            ),
            Container(
              padding: gPadding(top: 12, bottom: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    adsEntity.property.questions.length,
                    (index) => buildIconBtn(
                      AppImages.water,
                      "${adsEntity.property.questions[index].value} ${adsEntity.property.questions[index].title} ",
                      margin: EdgeInsetsDirectional.only(end: 12.w),
                      style: getTextStyleSimSmall().copyWith(),
                      imgHeight: 17,
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   padding: gPadding(top: 12.5, bottom: 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: IconTitleWidget(
            //           image: AppImages.water,
            //           title: "2 غرفة النوم",
            //           style: getTextStyleSimSmall(),
            //           imageHeight: 16.5,
            //         ),
            //       ),
            //       5.width,
            //       Expanded(
            //         child: IconTitleWidget(
            //           image: AppImages.union,
            //           title: "1 دورة المياة",
            //           style: getTextStyleSimSmall(),
            //           imageHeight: 16.5,
            //         ),
            //       ),
            //       5.width,
            //       Expanded(
            //         child: IconTitleWidget(
            //           image: AppImages.bedEmpty,
            //           title: "2 غرفة النوم",
            //           style: getTextStyleSimSmall(),
            //           imageHeight: 16.5,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextWidget(
                      adsEntity.price,
                      style: getTextStyle16(fontWeight: FontWeight.w600),
                    ),
                    TextWidget(
                      "ريال",
                      style: getTextStyle16(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    BlocBuilder<MyFavoritesCubit, MyFavoritesState>(
                      builder: (context, state) {
                        var favCubit = context.read<MyFavoritesCubit>();
                        return InkWell(
                          onTap: () {
                            print(
                                '999999999999999 ${BlocProvider.of<ProfileBloc>(context).email}');
                            if (adsEntity.user.email ==
                                BlocProvider.of<ProfileBloc>(context).email) {
                              // ignore: void_checks
                              return showSnackBar(
                                message: "لا يمكنك اضافة اعلانك الى المفضلة",
                                isError: true,
                              );
                            } else {
                              favCubit.addOrRemoveFav(adsEntity.id);
                            }
                          },
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: AppColors.primary.withOpacity(.20),
                            child: favCubit.isInFavList(adsEntity.id)
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : SvgPicture.asset(AppImages.heart),
                          ),
                        );
                      },
                    ),
                    // IconButtonWidget(
                    //   image: AppImages.heart,
                    //   height: 37.5,
                    //   size: 20.0,
                    //   onTap: () {},
                    // ),
                    if (showShare) ...[
                      5.width,
                      IconButtonWidget(
                        image: AppImages.share,
                        height: 37.5,
                        size: 20.0,
                        onTap: () {},
                      ),
                    ],
                    5.width,
                    IconButtonWidget(
                      image: AppImages.whatsApp,
                      height: 37.5,
                      size: 20.0,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Stack _buildBunnerContent({required List<String> images}) {
    return Stack(
      children: [
        Container(
          height: 120.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: 10.radius),
          child: PageView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) => Container(
              height: 120.h,
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                borderRadius: 10.radius,
              ),
              child: NetworkImageWidget(images[index], height: 120.h),
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          right: 0,
          left: 0,
          child: SmoothIndicator(
            count: images.length,
            index: 0,
            color: AppColors.primary,
            defaultColor: AppColors.primary,
            ads: true,
          ),
        ),
        Positioned(
          bottom: 10.h,
          left: 10.w,
          child: TextWidget(
            "1/${images.length.toString()}",
            style: getTextStyleSimSmall(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
