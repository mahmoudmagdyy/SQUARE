import 'package:aqarat/core/widgets/custom_banner_widget.dart';
import 'package:aqarat/core/widgets/custom_error_widget.dart';
import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/presentation/bloc/my_favorites/my_favorites_cubit.dart';

import '/index.dart';
import '../../bloc/profile/profile_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "المفضلة"),
      body: BlocConsumer<MyFavoritesCubit, MyFavoritesState>(
        listener: (context, state) {
          if (state.getMyFavoritesState == RequestState.error ||
              state.statusCode == 401) {
            sl<AppPreferences>().logout().then(
                  (value) => sl<NavigationService>().toNamedAndRemoveUntil(
                    Routes.login,
                  ),
                );
          }
        },
        builder: (context, state) {
          return BlocBuilder<MyFavoritesCubit, MyFavoritesState>(
            builder: (context, state) {
              switch (state.getMyFavoritesState) {
                case RequestState.none:
                case RequestState.loading:
                  return const LoadingWidget(color: AppColors.primary);
                case RequestState.loaded:
                  return SafeArea(
                    child: state.myFavorites.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: () async {
                              context.read<MyFavoritesCubit>().getAllFav();
                            },
                            child: ListView.builder(
                              itemCount: state.myFavorites.length,
                              itemBuilder: (context, index) {
                                return FavoriteItemWidget(
                                    item: state.myFavorites[index]);
                              },
                            ),
                          )
                        : Center(
                            child: TextWidget(
                              "لا يوجد اعلانات في المفضله",
                              style: getTextStyleNormal(
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                  );
                case RequestState.error:
                  return CustomErrorWidget(
                    onRetry: context.read<MyFavoritesCubit>().getAllFav,
                    errorMessage: state.getAllFavErrorMessage.toString(),
                  );
              }
            },
          );
        },
      ),
    );
  }
}

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({super.key, required this.item});
  final Property item;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: gPadding(left: 20, right: 20, top: 16),
      padding: gPaddingSymmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: 10.radius,
          color: AppColors.containerBackground2,
          border: Border.all(color: AppColors.grey)),
      child: InkWell(
        onTap: () {
          sl<NavigationService>().toNamed(
            Routes.adsDetails,
            arguments: {
              'item': AdsEntity(
                typeStatus: 'item.typeStatus',
                category: item.category,
                payment: item.payment,
                space: item.space,
                id: item.id,
                city: item.city,
                area: item.area,
                title: item.title,
                type: item.type,
                price: item.price,
                age: item.age,
                lat: item.lat,
                lng: item.lng,
                description: item.description,
                firstImage: item.firstImage!,
                user: UserEntity(
                    id: item.user.id,
                    name: item.user.name,
                    phone: item.user.phone,
                    email: item.user.email,
                    image: item.user.image),
                property: PropertyEntity(
                  questions: item.property.questions!
                      .map(
                        (e) => QuestionsEntity(
                          id: e.id,
                          title: e.title,
                          value: e.value,
                        ),
                      )
                      .toList(),
                  tools: item.property.tools!
                      .map((e) => TypesAndToolsEntity(id: e.id, title: e.title))
                      .toList(),
                ),
                images: item.images
                    .map((e) => ImagesEntity(id: e.id, image: e.image))
                    .toList(),
                status: item.status,
                views: item.views,
                createdAt: item.createdAt,
                code: 'item.code',
              ),
              'fromMyAds': false,
            },
            // arguments: AdsEntity(
            //   id: item.id,
            //   city: item.city,
            //   area: item.area,
            //   title: item.title,
            //   type: item.type,
            //   price: item.price,
            //   age: item.age,
            //   lat: item.lat,
            //   lng: item.lng,
            //   description: item.description,
            //   firstImage: item.firstImage,
            //   user: UserEntity(
            //       id: item.user.id,
            //       name: item.user.name,
            //       phone: item.user.phone,
            //       email: item.user.email,
            //       image: item.user.image),
            //   property: PropertyEntity(
            //     questions: item.property.questions!
            //         .map(
            //           (e) => QuestionsEntity(
            //             id: e.id,
            //             title: e.title,
            //             value: e.value,
            //           ),
            //         )
            //         .toList(),
            //     tools: item.property.tools!
            //         .map((e) => TypesAndToolsEntity(id: e.id, title: e.title))
            //         .toList(),
            //   ),
            //   images: item.images
            //       .map((e) => ImagesEntity(id: e.id, image: e.image))
            //       .toList(),
            //   status: item.status,
            //   views: item.views,
            //   createdAt: item.createdAt,
            //   code: 'item.code',
            // ),
          );
        },
        child: Column(
          children: [
            CustomBannerWidget(
                image: item.images.isNotEmpty
                    ? item.images.first.image
                    : AppImages.errorImage),
            Padding(
              padding: gPadding(top: 12, right: 13, left: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    item.title,
                    style: getTextStyleSimSmall(
                      color: AppColors.textColor2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.date,
                        height: 17.h,
                        width: 17.h,
                      ),
                      6.width,
                      TextWidget(
                        item.createdAt,
                        style: getTextStyleSimSmall(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textGray3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButtonWidget(
                  onTap: () {},
                  color: AppColors.orange,
                  image: AppImages.pinlocation,
                  backgroundColor: AppColors.orange.withOpacity(.25),
                ),
                7.width,
                TextWidget(item.city),
                TextWidget(
                  item.area,
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
                    item.property.questions?.length ?? 0,
                    (index) => buildIconBtn(
                      AppImages.water,
                      "${item.property.questions![index].value} ${item.property.questions![index].title} ",
                      margin: EdgeInsetsDirectional.only(end: 12.w),
                      style: getTextStyleSimSmall().copyWith(),
                      imgHeight: 17,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextWidget(
                      item.price,
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
                            if (item.user.email ==
                                BlocProvider.of<ProfileBloc>(context).email) {
                              // ignore: void_checks
                              return showSnackBar(
                                message: "لا يمكنك اضافة اعلانك الى المفضلة",
                                isError: true,
                              );
                            } else {
                              favCubit.addOrRemoveFav(item.id);
                            }
                          },
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: AppColors.primary.withOpacity(.20),
                            child: favCubit.isInFavList(item.id)
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
                    //   icon: CupertinoIcons.heart,
                    //   height: 36,
                    //   onTap: () {},
                    //   size: 19,
                    // ),
                    IconButtonWidget(
                      icon: Icons.ios_share_outlined,
                      height: 36,
                      size: 17,
                      onTap: () {},
                      padding: gPaddingSymmetric(horizontal: 8),
                    ),
                    IconButtonWidget(
                        image: AppImages.whatsApp, onTap: () {}, height: 36),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
