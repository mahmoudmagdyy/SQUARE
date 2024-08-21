import 'package:aqarat/core/widgets/custom_error_widget.dart';
import 'package:aqarat/data/model/property.dart';
import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_ad_type/edit_ad_typ_loaded_widget.dart';

class EditAdTypeScreen extends StatefulWidget {
  const EditAdTypeScreen(
      {Key? key, required this.property, required this.index})
      : super(key: key);
  final Property property;
  final int index;
  @override
  State<EditAdTypeScreen> createState() => _EditAdTypeScreenState();
}

class _EditAdTypeScreenState extends State<EditAdTypeScreen> {
  @override
  initState() {
    super.initState();
    context.read<EditMyAdCubit>().getCurrentAds(index: widget.property.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyAdCubit, EditMyAdState>(
      builder: (context, state) {
        switch (state.getCurrentAdByIdRequestState) {
          case RequestState.none:
          case RequestState.loading:
            return const Material(
              child: LoadingWidget(
                color: AppColors.primary,
              ),
            );
          case RequestState.loaded:
            return EditAdTypLoadedWidget(state: state);

          case RequestState.error:
            return Material(
              child: CustomErrorWidget(
                onRetry: () {
                  context.read<EditMyAdCubit>().getCurrentAds(
                        index: widget.property.id,
                      );
                },
                errorMessage: state.getCurrentAdByIdErrorMessage.toString(),
              ),
            );
        }
      },
    );
  }
}


/**
 * 
 * Column(
                          children: [
                            (() {
                              if (uploadState.requestStateCity ==
                                  RequestState.loaded) {
                                return Column(
                                  children: [
                                    isSale
                                        ? const SizedBox.shrink()
                                        : TypeReldContent(
                                            title: state.property?.typeStatus ??
                                                'نوع الايجار',
                                            color: state.property!.typeStatus ==
                                                    null
                                                ? null
                                                : AppColors.black,
                                            array: reldContent,
                                            onSelectedValue: (value) =>
                                                bloc.add(
                                              GetRealedTypeEvent(
                                                realedType:
                                                    reldContent[value].name,
                                              ),
                                            ),
                                          ),
                                    15.verticalSpace,
                                    TypeAqarContent(
                                      title: uploadState.aqarType.isEmpty
                                          ? AppStrings.aqarType
                                          : uploadState.aqarType,
                                      color: uploadState.aqarType.isEmpty
                                          ? null
                                          : AppColors.black,
                                      array: uploadState.types,
                                      onSelectedValue: (value) => bloc.add(
                                        GetTypeAqarEvent(
                                          aqarIdType: bloc.state.types[value].id
                                              .toString(),
                                          aqarType: bloc.state.types[value].name
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                    15.height,
                                    CityAqarContent(
                                      title: uploadState.city.isEmpty
                                          ? AppStrings.cityAqar
                                          : uploadState.city,
                                      color: uploadState.city.isEmpty
                                          ? null
                                          : AppColors.black,
                                      array: uploadState.cities,
                                      onSelectedValue: (value) => bloc.add(
                                        GetCityAqarEvent(
                                          city: bloc.state.cities[value].name
                                              .toString(),
                                          cityId: bloc.state.cities[value].id
                                              .toString(),
                                          selectedCity: value,
                                        ),
                                      ),
                                    ),
                                    15.height,
                                    DistrictAqarContent(
                                      absorbing: uploadState.city.isEmpty
                                          ? true
                                          : false,
                                      title: uploadState.district.isEmpty
                                          ? AppStrings.districtAqar
                                          : uploadState.district,
                                      color: uploadState.district.isEmpty
                                          ? null
                                          : AppColors.black,
                                      array: bloc
                                          .state
                                          .cities[uploadState.selectedCity]
                                          .area!,
                                      onSelectedValue: (value) => bloc.add(
                                        GetDistrictAqarEvent(
                                          district: bloc
                                              .state
                                              .cities[uploadState.selectedCity]
                                              .area![value]
                                              .name
                                              .toString(),
                                          districtId: bloc
                                              .state
                                              .cities[uploadState.selectedCity]
                                              .area![value]
                                              .id
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (uploadState.requestStateCity ==
                                  RequestState.loading) {
                                return Column(
                                  children: [
                                    const TitleCardShimmer(),
                                    15.height,
                                    const TitleCardShimmer(),
                                    15.height,
                                    const TitleCardShimmer(),
                                  ],
                                );
                              } else if (uploadState.requestStateCity ==
                                  RequestState.error) {
                                return Center(
                                  child: TextWidget(
                                    "Error",
                                    style: getTextStyleNormal(
                                        fontWeight: FontWeight.w600),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: TextWidget(
                                    "None",
                                    style: getTextStyleNormal(
                                        fontWeight: FontWeight.w600),
                                  ),
                                );
                              }
                            }())
                          ],
                        )
 */
