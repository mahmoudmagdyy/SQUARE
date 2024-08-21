import 'dart:developer';

import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/filter/filter_bloc.dart';
import 'package:aqarat/presentation/widgets/bid_card_ads_widget.dart';
import 'package:aqarat/presentation/widgets/empty_list_widget.dart';

import '../../../../data/model/cities_with_area_model.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({
    super.key,
    required this.listOfAreas,
    required this.cityId,
  });

  final List<Area> listOfAreas;
  final int cityId;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late final ScrollController _scrollController;
  var nextPage = 1;
  var isLoading = false;

  @override
  void initState() {
    sl<FilterBloc>()
      ..add(GetCityIdEvent(cityId: widget.cityId.toString()))
      ..add(const GetAdsByFilterEvent());
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    sl<FilterBloc>().listofAreaIds.clear();
    sl<FilterBloc>().dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    var currentPositions = _scrollController.position.pixels;
    var maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPositions >= 0.7 * maxScrollLength) {
      if (!isLoading) {
        isLoading = true;
        sl<FilterBloc>().pageNumber++;
        sl<FilterBloc>()
          ..add(GetCityIdEvent(cityId: widget.cityId.toString()))
          ..add(const GetAdsByFilterEvent());
        print('***************************************************');
        Future.delayed(const Duration(seconds: 5), () {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "الإعلانات",
        child: IconButtonWidget(
          image: AppImages.heart,
          height: 40.0,
          size: 20.0,
          onTap: () => i<NavigationService>().toNamed(Routes.favorite),
        ),
      ),
      body: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, filterState) {
          final FilterBloc bloc = sl<FilterBloc>();
          return Column(
            children: [
              15.height,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    15.width,
                    TapBarWidget(
                      title: "الكــل",
                      // isSelected: bloc.state.areaId.isEmpty ? true : false,
                      isSelected: filterState.categoryId.isEmpty ? true : false,
                      callback: () {
                        bloc.pageNumber = 1;
                        bloc
                          ..add(const GetAreaIdEvent(areaId: []))
                          ..add(
                              GetCityIdEvent(cityId: widget.cityId.toString()))
                          ..add(const GetAdsByFilterEvent());
                        bloc.changeCategoryId('');
                      },
                    ),
                    BlocBuilder<UploadAqarBloc, UploadAqarState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            ...List.generate(
                              state.types.length,
                              // widget.cityEntity?.area?.length ??'0'?? 0,
                              (index) => TapBarWidget(
                                // title: widget.cityEntity?.area![index].??'0'.toString(),
                                title: state.types[index].name.toString(),
                                callback: () {
                                  bloc.pageNumber = 1;
                                  bloc
                                    ..changeCategoryId(
                                      state.types[index].id.toString(),
                                    )
                                    ..add(
                                      GetCityIdEvent(
                                        cityId: widget.cityId.toString(),
                                      ),
                                    )
                                    ..add(
                                      const GetAdsByFilterEvent(),
                                    );
                                  log('Tapped ${state.types[index].id}');
                                  /**
                                   *   ..add(
                                      GetAreaIdEvent(
                                        areaId: args.area![index].id.toString(),
                                      ),
                                    )
                                   */
                                  // bloc
                                  // ..add(
                                  //   GetCityIdEvent(
                                  //     cityId: args.id.toString(),
                                  //   ),
                                  // )
                                  // ..add(
                                  //   const GetAdsByFilterEvent(),
                                  // );
                                },
                                isSelected: state.types[index].id.toString() ==
                                    filterState.categoryId,
                                // isSelected: state.areaId ==
                                //     args.area![index].id.toString(),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              17.verticalSpace,
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: 15.w,
                ),
                height: 35.h,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        bloc.pageNumber = 1;
                        bloc.listofAreaIds.clear();
                        bloc.add(const GetAreaIdEvent(areaId: []));
                        bloc
                          ..add(
                            GetCityIdEvent(
                              cityId: widget.cityId.toString(),
                            ),
                          )
                          ..add(
                            const GetAdsByFilterEvent(),
                          );
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
                          itemCount: widget.listOfAreas.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                bloc.pageNumber = 1;
                                bloc.addAndRemoveAreaId(
                                    widget.listOfAreas[index].id.toString());
                                bloc
                                  ..add(
                                    GetCityIdEvent(
                                      cityId: widget.cityId.toString(),
                                    ),
                                  )
                                  ..add(
                                    const GetAdsByFilterEvent(),
                                  );
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
                                      color: bloc.checkIfAreaIdIsSelected(widget
                                              .listOfAreas[index].id
                                              .toString())
                                          ? AppColors.primary
                                          : AppColors.grey,
                                      borderRadius: 16.radius,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextWidget(
                                          widget.listOfAreas[index].name,
                                          style: getTextStyleNormal(
                                            color: bloc.checkIfAreaIdIsSelected(
                                                    widget.listOfAreas[index].id
                                                        .toString())
                                                ? AppColors.white
                                                : AppColors.black,
                                            fontWeight: FontWeight.w500,
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
              15.height,
              Expanded(
                child: (filterState.requestState == RequestState.loaded)
                    ? (filterState.adsEntity.isEmpty)
                        ? EmptyListWidget(
                            image: AppImages.store,
                            subTitle: AppStrings.subTitleNotFound,
                          )
                        : ListView.separated(
                            controller: _scrollController,
                            padding: gPadding(
                                right: 15, top: 15, left: 15, bottom: 15),
                            itemBuilder: (context, index) {
                              return BigCardAdsWidget(
                                  adsEntity: filterState.adsEntity[index]);
                            },
                            separatorBuilder: (context, index) => 15.height,
                            itemCount: filterState.adsEntity.length,
                          )
                    : const LoadingWidget(color: AppColors.loadingColor),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TapBarWidget extends StatelessWidget {
  const TapBarWidget({
    super.key,
    required this.title,
    required this.callback,
    required this.isSelected,
  });
  final String title;
  final VoidCallback callback;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: gPadding(left: 12.5, top: 7.5, right: 12.5, bottom: 7.5),
        margin: gPadding(left: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.grey,
          borderRadius: 4.radius,
        ),
        child: TextWidget(
          title,
          style: getTextStyleNormal(
            color: isSelected ? AppColors.white : AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
