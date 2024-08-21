import 'package:aqarat/core/widgets/custom_alert_dialog_with_top_icon_widget.dart';
import 'package:aqarat/core/widgets/custom_banner_widget.dart';
import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/my_ads/my_ads_cubit.dart';
import 'package:aqarat/presentation/bloc/my_favorites/my_favorites_cubit.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';

class MyAdsItemWidget extends StatefulWidget {
  const MyAdsItemWidget({super.key, required this.item, required this.index});
  final Property item;
  final int index;

  @override
  State<MyAdsItemWidget> createState() => _MyAdsItemWidgetState();
}

class _MyAdsItemWidgetState extends State<MyAdsItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: gPadding(left: 20, right: 20, top: 16),
      padding: gPaddingSymmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: 10.radius,
        color: AppColors.containerBackground2,
        border: Border.all(color: AppColors.grey),
      ),
      child: InkWell(
        onTap: () {
          sl<NavigationService>().toNamed(
            Routes.adsDetails,
            arguments: {
              'item': AdsEntity(
                typeStatus: 'widget.item.typeStatus',
                id: widget.item.id,
                city: widget.item.city,
                area: widget.item.area,
                category: widget.item.category,
                payment: widget.item.payment,
                space: widget.item.space,
                title: widget.item.title,
                type: widget.item.type,
                price: widget.item.price,
                age: widget.item.age,
                lat: widget.item.lat,
                lng: widget.item.lng,
                description: widget.item.description,
                firstImage: widget.item.firstImage!,
                user: UserEntity(
                    id: widget.item.user.id,
                    name: widget.item.user.name,
                    phone: widget.item.user.phone,
                    email: widget.item.user.email,
                    image: widget.item.user.image),
                property: PropertyEntity(
                  questions: widget.item.property.questions!
                      .map(
                        (e) => QuestionsEntity(
                          id: e.id,
                          title: e.title,
                          value: e.value,
                        ),
                      )
                      .toList(),
                  tools: widget.item.property.tools!
                      .map((e) => TypesAndToolsEntity(id: e.id, title: e.title))
                      .toList(),
                ),
                images: widget.item.images
                    .map((e) => ImagesEntity(id: e.id, image: e.image))
                    .toList(),
                status: widget.item.status,
                views: widget.item.views,
                createdAt: widget.item.createdAt,
                code: 'item.code',
              ),
              'fromMyAds': true,
            },
          );
        },
        child: Stack(
          children: [
            Column(
              children: [
                CustomBannerWidget(
                  image: widget.item.images.isNotEmpty
                      ? widget.item.images.first.image
                      : 'https://img.freepik.com/free-vector/abstract-grunge-style-coming-soon-with-black-splatter_1017-26690.jpg?w=996&t=st=1699866637~exp=1699867237~hmac=7c50e4c1165690e3c448cf7d33ee5e8788ef0aa0e3d7e2e66188650ca26b4eec',
                ),
                Padding(
                  padding: gPadding(top: 12, right: 13, left: 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        widget.item.title.toString(),
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
                            widget.item.createdAt.toString(),
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
                    TextWidget(widget.item.city.toString()),
                    TextWidget(
                      widget.item.area.toString(),
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
                        widget.item.property.questions?.length ?? 0,
                        (index) => buildIconBtn(
                          AppImages.water,
                          "${widget.item.property.questions![index].value} ${widget.item.property.questions![index].title} ",
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
                          widget.item.price,
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
                                if (widget.item.user.email ==
                                    BlocProvider.of<ProfileBloc>(context)
                                        .email) {
                                  // ignore: void_checks
                                  return showSnackBar(
                                    message:
                                        "لا يمكنك اضافة اعلانك الى المفضلة",
                                    isError: true,
                                  );
                                } else {
                                  favCubit.addOrRemoveFav(widget.item.id);
                                }
                              },
                              child: CircleAvatar(
                                radius: 18.r,
                                backgroundColor:
                                    AppColors.primary.withOpacity(.20),
                                child: favCubit.isInFavList(widget.item.id)
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : SvgPicture.asset(AppImages.heart),
                              ),
                            );
                          },
                        ),
                        if (widget.item.share == 1)
                          IconButtonWidget(
                            icon: Icons.ios_share_outlined,
                            height: 36,
                            size: 17,
                            onTap: () {},
                            padding: gPaddingSymmetric(horizontal: 8),
                          ),
                        IconButtonWidget(
                          image: AppImages.whatsApp,
                          onTap: () {},
                          height: 36,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: IconButton(
                onPressed: () async {
                  await sl<NavigationService>().toNamed(
                    Routes.editAdType,
                    arguments: {
                      'item': widget.item,
                      'index': widget.index,
                    },
                  );
                  // await sl<NavigationService>().toNamed(
                  //   Routes.editMyAdsImage,
                  // arguments: {
                  //   'item': widget.item,
                  //   'index': widget.index,
                  // },
                  // ).then((value) => setState(() {}));
                },
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.primary,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return BlocListener<MyAdsCubit, MyAdsState>(
                        listener: (context, state) {
                          if (state.deleteAds == RequestState.loaded) {
                            Navigator.pop(context);
                          }
                        },
                        child: CustomAlertDialogWithTopIconWidget(
                          button1OnTap: () async {
                            await context
                                .read<MyAdsCubit>()
                                .deleteAds(
                                  widget.item.id.toString(),
                                )
                                .then((value) {
                              BlocProvider.of<HomeBloc>(context)
                                ..add(const GetSliderEvent())
                                ..add(const GetCityEvent())
                                ..add(const GetAdsEvent());
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 42.sp,
                            color: Colors.white,
                          ),
                          title: 'هل تريد بالتأكيد حذف الاعلان ؟',
                          child: Text(
                            'حذف الاعلان',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.red.shade100,
                  child: Icon(
                    Icons.clear,
                    color: Colors.red.shade900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
