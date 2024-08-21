import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/publish_add/publish_add_cubit.dart';

import '../../../data/model/cities_with_area_model.dart';
import '../../bloc/home/home_bloc.dart';
import '../../widgets/slider_widget.dart';
import '../home/widgets/card_ad_widget.dart';

class PublishAddScreen extends StatefulWidget {
  const PublishAddScreen({super.key});

  @override
  State<PublishAddScreen> createState() => _PublishAddScreenState();
}

class _PublishAddScreenState extends State<PublishAddScreen> {
  late List<CityAndArea>? cities;
  late List<Area>? areas;
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context, listen: false);
    areas = homeBloc.state.cityWithAreaModel?.cities[0].areas;
    cities = homeBloc.state.cityWithAreaModel?.cities;
  }

  @override
  Widget build(BuildContext context) {
    PublishAddCubit publishAddCubit = BlocProvider.of<PublishAddCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('انشر الاعلان'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<PublishAddCubit, PublishAddState>(
              builder: (context, state) {
                switch (state.sliderState) {
                  case RequestState.loading:
                  case RequestState.none:
                    return const SizedBox.shrink();

                  case RequestState.loaded:
                    return SliderWidget(
                      images: publishAddCubit.state.sliderModel ?? [],
                      onPageChanged: (value, _) {},
                      currentIndex: 1,
                    );

                  case RequestState.error:
                    return const Center(child: Text('خطاء في تحميل الصور'));
                }
              },
            ),
            16.height,
            BlocBuilder<PublishAddCubit, PublishAddState>(
              builder: (context, state) {
                switch (state.adsState) {
                  case RequestState.loading:
                  case RequestState.none:
                    return Center(
                        child: Column(
                      children: [
                        200.verticalSpace,
                        const CircularProgressIndicator(),
                      ],
                    ));

                  case RequestState.loaded:
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.only(
                            start: 15.w,
                          ),
                          height: 35.h,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  publishAddCubit.listofAreaIds.clear();
                                  publishAddCubit.cityId = null;
                                  selectedIndex = -1;
                                  publishAddCubit.getpublishAdd(false);
                                },
                                child: SvgPicture.asset(
                                  AppImages.trash,
                                  height: 20.h,
                                  width: 20.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              10.width,
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cities?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            areas = cities?[index].areas;
                                            publishAddCubit.cityId =
                                                cities?[index].id.toString();
                                            publishAddCubit
                                                .getpublishAdd(false);
                                            publishAddCubit.listofAreaIds
                                                .clear();
                                            selectedIndex = index;
                                          });
                                        },
                                        child: Wrap(
                                          children: [
                                            Container(
                                              margin: gPadding(left: 10),
                                              padding: gPadding(
                                                  left: 12.w,
                                                  top: 5.h,
                                                  right: 12.w,
                                                  bottom: 5.h),
                                              decoration: BoxDecoration(
                                                color: selectedIndex == index
                                                    ? AppColors.primary
                                                    : AppColors.grey,
                                                borderRadius: 16.radius,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextWidget(
                                                    cities?[index].name ?? '',
                                                    style: getTextStyleNormal(
                                                      color:
                                                          selectedIndex == index
                                                              ? AppColors.white
                                                              : AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        8.height,
                        Container(
                          padding: EdgeInsetsDirectional.only(
                            start: 15.w,
                          ),
                          height: 35.h,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  publishAddCubit.listofAreaIds.clear();
                                  setState(() {});
                                  publishAddCubit.getpublishAdd(false);
                                },
                                child: SvgPicture.asset(
                                  AppImages.trash,
                                  height: 20.h,
                                  width: 20.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              10.width,
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: areas?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          publishAddCubit.addAndRemoveAreaId(
                                              areas?[index].id.toString() ??
                                                  '0');
                                          setState(() {});
                                          publishAddCubit.getpublishAdd(false);
                                        },
                                        child: Wrap(
                                          children: [
                                            Container(
                                              margin: gPadding(left: 10),
                                              padding: gPadding(
                                                  left: 12.w,
                                                  top: 5.h,
                                                  right: 12.w,
                                                  bottom: 5.h),
                                              decoration: BoxDecoration(
                                                color: publishAddCubit
                                                        .checkIfAreaIdIsSelected(
                                                            areas?[index]
                                                                    .id
                                                                    .toString() ??
                                                                '0')
                                                    ? AppColors.primary
                                                    : AppColors.grey,
                                                borderRadius: 16.radius,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextWidget(
                                                    areas?[index].name ?? '',
                                                    style: getTextStyleNormal(
                                                      color: publishAddCubit
                                                              .checkIfAreaIdIsSelected(
                                                                  areas?[index]
                                                                          .id
                                                                          .toString() ??
                                                                      '0')
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        16.height,
                        ListView.separated(
                          shrinkWrap: true,
                          padding: gPadding(right: 15, left: 15, bottom: 35),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.adsEntityList?.length ?? 0,
                          separatorBuilder: (context, index) => 15.height,
                          itemBuilder: (context, index) {
                            return CardAdWidget(
                              isFromShared: true,
                              adsModel: state.adsEntityList![index],
                            );
                          },
                        ),
                      ],
                    );
                  case RequestState.error:
                    return const Center(child: Text('error'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
