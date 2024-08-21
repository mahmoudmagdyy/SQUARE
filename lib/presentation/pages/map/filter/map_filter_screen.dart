import 'dart:developer';

import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/filter/filter_bloc.dart';
import 'package:aqarat/presentation/widgets/bid_card_ads_widget.dart';
import 'package:aqarat/presentation/widgets/empty_list_widget.dart';

class MapFilterPage extends StatefulWidget {
  const MapFilterPage({super.key});

  @override
  State<MapFilterPage> createState() => _MapFilterPageState();
}

class _MapFilterPageState extends State<MapFilterPage> {
  @override
  void dispose() {
    sl<FilterBloc>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CityEntity;

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
                        bloc
                          ..add(const GetAreaIdEvent(areaId: []))
                          ..add(GetCityIdEvent(cityId: args.id.toString()))
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
                              // args.area?.length ?? 0,
                              (index) => TapBarWidget(
                                // title: args.area![index].name.toString(),
                                title: state.types[index].name.toString(),
                                callback: () {
                                  bloc
                                    ..changeCategoryId(
                                      state.types[index].id.toString(),
                                    )
                                    ..add(
                                      GetCityIdEvent(
                                        cityId: args.id.toString(),
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
              15.height,
              Expanded(
                child: (filterState.requestState == RequestState.loaded)
                    ? (filterState.adsEntity.isEmpty)
                        ? EmptyListWidget(
                            image: AppImages.store,
                            subTitle: AppStrings.subTitleNotFound,
                          )
                        : ListView.separated(
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
