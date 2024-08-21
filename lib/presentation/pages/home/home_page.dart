import 'package:aqarat/presentation/bloc/home/home_bloc.dart';
import 'package:aqarat/presentation/bloc/profile/profile_bloc.dart';
import 'package:aqarat/presentation/pages/home/widgets/card_ad_widget.dart';
import 'package:aqarat/presentation/pages/home/widgets/image_title_widget.dart';
import 'package:aqarat/presentation/widgets/slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data_source/remote/profile/base_profile_remote_data_source.dart';
import '../../../domain/usecases/profile/get_profile_id_usecase.dart';
import '../../../domain/usecases/profile/get_profile_usecase.dart';
import '../../../domain/usecases/profile/update_profile_usecase.dart';
import '../../bloc/my_ads/my_ads_cubit.dart';
import '/index.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  initState(){
      Get.put(HomeBloc);
      Get.put(ProfileBloc);
      sl.registerFactory<ProfileBloc>(
            () => ProfileBloc(
          sl<GetProfileIdUseCase>(),
          sl<GetProfileUseCase>(),
          sl<UpdateProfileUseCase>(),
        ),
      );
      sl.registerLazySingleton<BaseProfileRemoteDataSource>(
            () => ProfileRemoteDataSourceImp(),
      );
      sl.registerLazySingleton<MyAdsCubit>(() => MyAdsCubit(sl()));

  }
}


class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs ;

  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      /* bloc: sl<HomeBloc>(),
      buildWhen: (previous, current) =>
          previous.requestState != current.requestState, */
      builder: (context, state) {
        final HomeBloc bloc = sl<HomeBloc>();

        return Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () {
                navigator!.pushNamed(Routes.openTicketRoute);
              },
              child: Icon(
                CupertinoIcons.question_circle,
                size: 30.sp,
                color: AppColors.white,
              )),
          appBar: _buildHeaderContent(),
          
          body: Stack(
            children: [
              (state.requestStateSlider == RequestState.loaded ||
                  state.requestStateCity == RequestState.loaded ||
                  state.requestStateAds == RequestState.loaded)
                  ? SingleChildScrollView(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildSearchBarContent(bloc: bloc),
                    15.height,
                    SliderWidget(
                      images: bloc.state.slider,
                      onPageChanged: (value, _) {},
                      currentIndex: 1,
                    ),
                    30.height,
                    Padding(
                      padding: gPadding(right: 15, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CardOptionWidget(
                              image: AppImages.house,
                              title: "ابحث لي",
                              callback: () => i<NavigationService>()
                                  .toNamed(Routes.signInSearchForMe),
                              isSelected: false,
                            ),
                          ),
                          20.width,
                          Expanded(
                            child: CardOptionWidget(
                              image: AppImages.town,
                              title: "انشر الإعلان",
                              callback: () {
                                i<NavigationService>().toNamed(Routes.publishAdd);
                              },
                              isSelected: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.height,
                    Padding(
                      padding: gPadding(right: 15, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            'عقارات السعودية',
                            style: getTextStyle18(
                              color: AppColors.greyDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    15.height,
                    Wrap(
                      // spacing: ScreenUtil().screenWidth / 9,
                      spacing: 1.sw / 9,

                      runSpacing: 10.h,
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: List.generate(
                        bloc.state.cities.length,
                            (index) {
                          // kLogger.w(
                          //     'This is City Args ${bloc.state.cities[index]}');
                          return GestureDetector(
                            onTap: () {
                              i<NavigationService>().toNamed(
                                Routes.filter,
                                arguments: {
                                  'cityId': bloc.state.cityWithAreaModel!
                                      .cities[index].id,
                                  'listOfAreas': bloc.state.cityWithAreaModel!
                                      .cities[index].areas,
                                },
                              );
                            },
                            child: ImageTitleWidget(
                              image: bloc.state.cities[index].image
                                  ?.toString() ??
                                  AppImages.errorImage,
                              title: bloc.state.cities[index].name.toString(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding:
                      gPadding(right: 15, top: 30, left: 15, bottom: 15),
                      child: TextWidget(
                        'أحدث الاعلانات',
                        style: getTextStyle18(
                          color: AppColors.greyDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: gPadding(right: 15, left: 15, bottom: 35),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bloc.state.ads.length,
                      separatorBuilder: (context, index) => 15.height,
                      itemBuilder: (context, index) {
                        return CardAdWidget(
                          adsModel: bloc.state.ads[index],
                        );
                      },
                    ),
                  ],
                ),
              )
                  : const LoadingWidget(color: AppColors.loadingColor),
              Positioned(
                bottom: 0.h,
                left:160.w,
                child: MediaQuery.of(context).viewInsets.bottom == 0
                    ? const FloatingButtonWidget()
                    : const SizedBox.shrink(),)
            ],
          )
         
        );
      },
    );
  }

  AppBar _buildHeaderContent() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async{
              await SharedPreferences.getInstance();
              sl<SharedPreferences>().getBool("isAnonymous")==false?i<NavigationService>().toNamed(Routes.notification):{
                i<NavigationService>().toNamed(Routes.login),
                prefs.setBool("isAnonymous",false),
                showSnackBar(message: "يجب تسجيل الدخول")
              };



            },
            child: Container(
              padding: gPaddingSymmetric(horizontal: 12.5, vertical: 12.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary),
              ),
              child: Icon(
                CupertinoIcons.bell,
                size: 15.h,
                color: AppColors.greyDark,
              ),
            ),
          ),
          SvgPicture.asset(
            AppImages.logoSmall,
            height: 30.h,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) =>
                previous.requestState != current.requestState,
            builder: (context, state) {
              return GestureDetector(
                onTap: () async{
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.getBool("isAnonymous")==false? {
                    (state.model == null)
                      ? null
                      : i<NavigationService>().toNamed(Routes.settings)}:
                  {
                    i<NavigationService>().toNamed(Routes.login),
                   prefs.setBool("isAnonymous",false),
                   print(prefs.getBool("isAnonymous")),
                  showSnackBar(message: "يجب تسجيل الدخول"),

                };
                },
                child: Container(
                  height: 40.h,
                  width: 40.h,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: AppColors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: NetworkImageWidget(
                    sl<AppPreferences>().getImgUrl?? AppImages.errorImage,
                    height: 40.h,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBarContent({required HomeBloc bloc}) {
    return Padding(
      padding: gPadding(right: 15, top: 20, left: 15),
      child: GestureDetector(
        onTap: () => i<NavigationService>().toNamed(Routes.search),
        child: Container(
          height: 45.h,
          padding: gPadding(right: 15, left: 15),
          decoration: BoxDecoration(
            color: AppColors.greyLight,
            borderRadius: 6.radius,
            border: Border.all(
              color: AppColors.grey.withOpacity(0.6),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.search,
                color: AppColors.orangeIcon,
              ),
              10.width,
              TextWidget(
                ' ابحث او ادخل رقم الاعلان التفصيلي',
                style: getTextStyleNormal(
                    fontSize: 15, color: AppColors.textGray2),
              )
            ],
          ),

          /*  '',
          hintText: 'ابحث عن منزل ، شقة ، إلخ',
          prefixIcon: Icons.search,
          prefixColor: AppColors.orange,
          controller: bloc.controller,
          onChanged: (value) => bloc.add(const GetSearchProductsEvent()), */
        ),
      ),
    );
  }
}
