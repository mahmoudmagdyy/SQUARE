import 'dart:developer';

import 'package:aqarat/core/widgets/custom_error_widget.dart';
import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/presentation/bloc/ads_details/ads_details_cubit.dart';
import 'package:aqarat/presentation/bloc/ads_details/ads_details_state.dart';
import 'package:aqarat/presentation/bloc/my_favorites/my_favorites_cubit.dart';
import 'package:aqarat/presentation/bloc/publish_add/publish_add_cubit.dart';
import 'package:aqarat/presentation/pages/chat/prsentation/screen/users_chats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/functions/share_ads_with_image.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../chat/prsentation/screen/chat_screen.dart';
import '/index.dart';

class AdsDetailsPage extends StatefulWidget {
  const AdsDetailsPage(
      {super.key, required this.item, required this.fromMyAds});
  final AdsEntity item;
  final bool fromMyAds;

  @override
  State<AdsDetailsPage> createState() => _AdsDetailsPageState();
}

class _AdsDetailsPageState extends State<AdsDetailsPage> {
  int currentIndex = 0;
  final ScrollController scrollController = ScrollController();

  void onChangedPage(int index) {
    currentIndex = index;
    scrollController.animateTo(
      index * (ScreenUtil().screenWidth / 5),
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as AdsEntity;
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final item = args['item'] as AdsEntity;
    // final isFromMyAds = args['fromMyAds'] as bool;

    final item = widget.item;
    final isFromMyAds = widget.fromMyAds;
    // log(item.toString());
    // List<String>? images = [];

    // log('Item Id ${item.id.toString()}');

    // (() {
    //   images.clear();
    //   images.add(item.firstImage);
    //   item.images.map((element) => images.add(element.image)).toList();
    // }());
    log(item.price.toString());
    return BlocProvider(
      create: (context) =>
          sl<AdsDetailsCubit>()..getAllSimilarAds(widget.item.id),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    SizedBox(
                      height: 280.h,
                      child: PageView.builder(
                        onPageChanged: onChangedPage,
                        itemCount: widget.item.images.length,
                        itemBuilder: (context, index) {
                          return NetworkImageWidget(
                            widget.item.images[index].image.toString(),
                            height: 280.h,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 15.h,
                      right: 15.w,
                      left: 15.w,
                      child: _buildHeaderContent(
                        showFav: !isFromMyAds,
                        id: item.id,
                        item: item,
                      ),
                    ),
                  ],
                ),
                10.height,
                SmallImagesContent(
                  images: widget.item.images.map((e) => e.image).toList(),
                  scrollController: scrollController,
                  currentIndex: currentIndex,
                ),
                _buildDetailsContent(adsEntity: item)
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: gPadding(right: 45, top: 15, left: 45, bottom: 15),
          child: isFromMyAds
              ? const SizedBox.shrink()
              // EditAdsButtonWidget(
              //     title: "تعديل الاعلان",
              //     onTap: () async {
              //       // await sl<NavigationService>().toNamed(
              //       //   Routes.editAdType,
              //       //   arguments: {
              //       //     'item': widget.item,
              //       //     'index': widget.index,
              //       //   },
              //       // );
              //       showSnackBar(message: 'Coming Soon');
              //       // sl<NavigationService>().toNamed(Routes.editMyAd);
              //     },
              //   )
              : Row(
                  children: [

                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () async {
                          // String url = "whatsapp://send?phone=+966552159322";
                          // OtherMethods.launchURL(url);

                          var whatsappUrl =
                              "https://api.whatsapp.com/send?phone=$adminPhoneNumberG"; // Replace with the phone number
                          if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                            await launchUrl(Uri.parse(whatsappUrl),
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $whatsappUrl';
                          }
                        },
                        child: BtnWidget(
                          onTap: null,
                          height: 40.h,
                          radius: 6,
                          border: Border.all(
                              color: AppColors.primaryBackground, width: 1.5),
                          backgroundColor: AppColors.containerBackground2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImages.whatsApp,
                                height: 20.h,
                                width: 20.h,
                                color: AppColors.primaryBackground,
                              ),
                              15.width,
                              TextWidget(
                                "واتساب",
                                style: getTextStyle18(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    20.width,
                    Expanded(
                      flex: 1,
                      child: BtnWidget(
                        onTap: () {},
                        height: 40.h,
                        radius: 6,
                        border: Border.all(
                            color: AppColors.primaryBackground, width: 1.5),
                        backgroundColor: AppColors.containerBackground2,
                        child: BlocBuilder<MyFavoritesCubit, MyFavoritesState>(
                          builder: (context, state) {
                            var favCubit = context.read<MyFavoritesCubit>();
                            return InkWell(
                              onTap: () {
                                print(
                                    '999999999999999 ${BlocProvider.of<ProfileBloc>(context).email}');
                                if (item.user.email ==
                                    BlocProvider.of<ProfileBloc>(context)
                                        .email) {
                                  // ignore: void_checks
                                  return showSnackBar(
                                    message:
                                        "لا يمكنك اضافة اعلانك الى المفضلة",
                                    isError: true,
                                  );
                                } else {
                                  favCubit.addOrRemoveFav(item.id);
                                }
                              },
                              child: favCubit.isInFavList(item.id)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Center(
                                      child: SvgPicture.asset(
                                        AppImages.heart,
                                        height: 25.h,
                                        width: 25.h,
                                        color: AppColors.primaryBackground,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                    20.width,
                    sl<SharedPreferences>().getBool("isAnonymous")==false? Expanded(
                      flex: 1,
                      child: BtnWidget(
                        onTap: () {},
                        height: 40.h,
                        radius: 6,
                        border: Border.all(
                            color: AppColors.primaryBackground, width: 1.5),
                        backgroundColor: AppColors.containerBackground2,
                        child: InkWell(
                          onTap: () {
                             Get.to(ChatScreen(userId: sl<AppPreferences>().getuserId,username: sl<AppPreferences>().getUserName));
                          },
                          child:const Icon(
                          Icons.chat_outlined,color: AppColors.primaryBackground,

                          )
                        ),
                      ),
                    ):SizedBox(width: 0,),

                  ],
                ),
        ),
      ),
    );
  }

  ListTile _buildHeaderContent({
    bool showFav = false,
    required int id,
    required AdsEntity item,
    bool showShare = false,
  }) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: IconButton.filled(
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: 4.radius),
          backgroundColor: AppColors.primary,
        ),
        onPressed: () => i<NavigationService>().pop(),
        icon: SvgPicture.asset(
          AppImages.arrowRightLine,
          color: AppColors.white,
        ),
      ),
      title: showFav
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                          favCubit.addOrRemoveFav(id);
                        }
                      },
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: AppColors.primary.withOpacity(.20),
                        child: favCubit.isInFavList(id)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : SvgPicture.asset(AppImages.heart),
                      ),
                    );
                  },
                ),
                if (showShare) ...[
                  10.width,
                  InkWell(
                    onTap: () {
                      shareAdsWithImage(item.firstImage, item.code);
                    },
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: AppColors.primary.withOpacity(.20),
                      child: SvgPicture.asset(AppImages.share),
                    ),
                  ),
                ],
              ],
            )
          : SizedBox.fromSize(),
    );
  }

  Widget _buildDetailsContent({required AdsEntity adsEntity}) => Column(
        children: [
          Padding(
            padding: gPadding(right: 15, top: 15, left: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      adsEntity.title,
                      style: getTextStyleNormal(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.date,
                          height: 16.5.h,
                          width: 16.5.h,
                        ),
                        5.width,
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
                5.height,
                Row(
                  children: [
                    TextWidget(
                      adsEntity.price.toString(),
                      style: getTextStyle16(fontWeight: FontWeight.w600),
                    ),
                    2.5.width,
                    TextWidget(
                      "ريال",
                      style: getTextStyle16(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                20.height,
                Row(
                  children: [
                    IconButtonWidget(
                      color: AppColors.orange,
                      image: AppImages.pinlocation,
                      backgroundColor: AppColors.orange.withOpacity(.20),
                    ),
                    7.5.width,
                    TextWidget(adsEntity.city.toString()),
                    5.width,
                    TextWidget(
                      adsEntity.area.toString(),
                      style: getTextStyleNormal(
                        color: AppColors.textGray1,
                      ),
                    ),
                  ],
                ),
                ListTileWidget(
                  title: 'المساحة',
                  trailing: adsEntity.space?.toString() ?? 'dasdsa',
                ),
                Divider(color: AppColors.textGrayLight, height: 0.5.h),
                ListTileWidget(
                    title: 'طريقة الدفع', trailing: adsEntity.payment ?? ''),
                Divider(color: AppColors.textGrayLight, height: 0.5.h),
                ListTileWidget(
                  title: 'نوع العقار',
                  trailing: adsEntity.type,
                ),
                adsEntity.typeStatus != null
                    ? Divider(color: AppColors.textGrayLight, height: 0.5.h)
                    : const SizedBox.shrink(),
                adsEntity.typeStatus != null
                    ? ListTileWidget(
                        title: 'نوع الايجار',
                        trailing: adsEntity.typeStatus ?? '',
                      )
                    : const SizedBox.shrink(),
                Divider(color: AppColors.textGrayLight, height: 0.5.h),
                10.height,
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextWidget(
                    'تفاصيل الإعلان',
                    style: getTextStyleNormal(
                      color: AppColors.textGray22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                8.height,
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextWidget(
                    adsEntity.description.toString(),
                    style: getTextStyleNormal(
                      color: AppColors.textGrayLight3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                20.height,
                Divider(color: AppColors.textGrayLight, height: 0.5.h),
                8.height,
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextWidget(
                    'التفضيلات',
                    style: getTextStyleNormal(
                      color: AppColors.textGray22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                8.height,
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: 12.w,
                    children: List.generate(
                      adsEntity.property.questions.length +
                          adsEntity.property.tools.length,
                      (index) {
                        return Chip(
                          label: Text(
                              index < adsEntity.property.questions.length
                                  ? adsEntity.property.questions[index].title
                                  : adsEntity
                                      .property
                                      .tools[index -
                                          adsEntity.property.questions.length]
                                      .title),
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                8.height,
                Divider(color: AppColors.textGrayLight, height: 0.5.h),
                20.height,
                Row(
                  children: [
                    TextWidget(
                      'رقم الإعلان :',
                      style: getTextStyleNormal(color: AppColors.textGray22),
                    ),
                    5.width,
                    TextWidget(
                      adsEntity.code.toString(),
                      style:
                          getTextStyleNormal(color: AppColors.textGrayLight4),
                    ),
                  ],
                ),
                if (!widget.fromMyAds) ...[
                  15.height,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextWidget(
                      "الإعلانات المشابهة",
                      style: getTextStyle16(
                        color: AppColors.textGray5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),
          _buildSimilarProductsContent(widget.item.id),
        ],
      );

  Widget _buildSimilarProductsContent(int id) =>
      BlocBuilder<AdsDetailsCubit, AdsDetailsState>(
        builder: (context, state) {
          if (widget.fromMyAds) {
            return const SizedBox.shrink();
          } else {
            switch (state.getAllSimilarAdsRequestState) {
              case RequestState.none:
              case RequestState.loading:
                return const Center(
                  child: LoadingWidget(
                    color: AppColors.baseColor,
                  ),
                );
              case RequestState.loaded:
                return state.similarAds.isEmpty
                    ? TextWidget(
                        'لا يوجد اعلانات مشابهة',
                        style: getTextStyleLarge(color: AppColors.textGray1),
                        textAlign: TextAlign.center,
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: gPadding(top: 15, bottom: 15),
                        child: Row(
                          children: [
                            20.width,
                            ...List.generate(
                              state.similarAds.length,
                              (index) => _buildSimilarAdContent(
                                state.similarAds[index],
                                widget.fromMyAds,
                              ),
                            ),
                          ],
                        ),
                      );
              case RequestState.error:
                return CustomErrorWidget(
                  onRetry: () {
                    context.read<AdsDetailsCubit>().getAllSimilarAds(id);
                  },
                  errorMessage: state.errorMessage.toString(),
                );
            }
          }
        },
      );

  Widget _buildSimilarAdContent(Property item, bool fromMyAds) {
    return InkWell(
      onTap: () => i<NavigationService>().toNamed(
        Routes.adsDetails,
        // arguments: adsEntity,
        arguments: {
          'item': AdsEntity(
            typeStatus: item.typeStatus,
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
              image: item.user.image,
            ),
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
                  .map(
                    (e) => TypesAndToolsEntity(
                      id: e.id,
                      title: e.title,
                    ),
                  )
                  .toList(),
            ),
            images: item.images
                .map(
                  (e) => ImagesEntity(
                    id: e.id,
                    image: e.image,
                  ),
                )
                .toList(),
            status: item.status,
            views: item.views,
            createdAt: item.createdAt,
            code: item.code,
          ),
          'fromMyAds': fromMyAds,
        },
      ),
      child: Container(
        margin: gPadding(left: 20),
        padding: gPadding(right: 15, top: 12.0, left: 15, bottom: 12.5),
        decoration: BoxDecoration(
          color: AppColors.containerBackground.withOpacity(.25),
          borderRadius: 10.radius,
          border: Border.all(
            color: AppColors.grey.withOpacity(0.4),
          ),
        ),
        // height: 120.h,
        width: 290.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 95.h,
              width: 110.w,
              decoration: BoxDecoration(
                borderRadius: 10.radius,
                image: DecorationImage(
                  // image: AssetImage(AppImages.adsDetailsSimilar),
                  image: NetworkImage(item.firstImage.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            15.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    item.title.toString(),
                    style: getTextStyleNormal(fontWeight: FontWeight.w600),
                  ),
                  5.height,
                  Row(
                    children: [
                      IconButtonWidget(
                        color: AppColors.orange,
                        image: AppImages.pinlocation,
                        backgroundColor: AppColors.orange.withOpacity(.15),
                      ),
                      5.width,
                      Expanded(
                        child: TextWidget(
                          item.area + item.city.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // 5.width,
                      // Expanded(
                      //   child: TextWidget(
                      //     item.city.toString(),
                      //     maxLines: 1,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: getTextStyleNormal(
                      //       color: AppColors.textGray22,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  5.height,
                  Row(
                    children: [
                      TextWidget(
                        item.price,
                        style: getTextStyleNormal(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor2.withOpacity(.65),
                        ),
                      ),
                      5.width,
                      TextWidget(
                        "ريال",
                        style: getTextStyleNormal(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor2.withOpacity(.65),
                        ),
                      ),
                    ],
                  ),
                  5.height,
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: TextWidget(
                      item.createdAt,
                      style: getTextStyleSimSmall(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textGray3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmallImagesContent extends StatelessWidget {
  const SmallImagesContent({
    super.key,
    required this.images,
    required this.scrollController,
    required this.currentIndex,
  });

  final List? images;
  final ScrollController scrollController;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      child: Row(
        children: [
          ...List.generate(images?.length ?? 0, (index) {
            return Container(
              height: currentIndex == index ? 55.h : 60.h,
              width: currentIndex == index ? 55.h : 60.h,
              margin: gPadding(right: 15, bottom: 5),
              child: CachedNetworkImage(
                imageUrl: images?[index] ?? AppImages.errorImage,
                imageBuilder: (context, imageProvider) => DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.greyLight,
                    borderRadius: 10.radius,
                    boxShadow: AppConstants.boxShadow,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const LoadingWidget(color: AppColors.loadingColor),
                errorWidget: (context, url, error) => Icon(
                  CupertinoIcons.exclamationmark_circle,
                  color: AppColors.redAccount,
                  size: 25.h,
                ),
              ),
            );
          }),
          15.width,
        ],
      ),
    );
  }
}
/* 
    if(Platform.isIOS){
    // for iOS phone only
    if( await canLaunch(whatappURL_ios)){
       await launch(whatappURL_ios, forceSafariVC: false);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));

    }

  }else{
    // android , web
    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));

    }


  }
 */
