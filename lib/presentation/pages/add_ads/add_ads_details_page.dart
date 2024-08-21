import 'package:aqarat/presentation/pages/add_ads/widgets/city_aqar_content.dart';
import 'package:aqarat/presentation/pages/add_ads/widgets/district_aqar_content.dart';
import 'package:aqarat/presentation/pages/add_ads/widgets/type_aqar_content.dart';
import 'package:aqarat/presentation/pages/add_ads/widgets/type_reld_content.dart';

import '/index.dart';

class AddAdsDetailesPage extends StatefulWidget {
  const AddAdsDetailesPage({super.key});

  @override
  State<AddAdsDetailesPage> createState() => _AddAdsDetailesPageState();
}

class _AddAdsDetailesPageState extends State<AddAdsDetailesPage> {
  bool isSale = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAqarBloc, UploadAqarState>(
      /* buildWhen: (previous, current) =>
            previous.requestStateGetCities != current.requestStateGetCities, */
      builder: (context, state) {
        debugPrint("Bloc Builder");
        final UploadAqarBloc bloc = BlocProvider.of<UploadAqarBloc>(context);
        return WillPopScope(
          onWillPop: () async {
            i<UploadAqarBloc>().clearAllData();
            return true;
          },
          child: Scaffold(
            appBar: AppBarWidget(
              title: AppStrings.addAd,
              onPressed: () {
                i<UploadAqarBloc>().clearAllData();
              },
            ),
            body: Container(
              padding: gPadding(right: 15, left: 15, bottom: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.height,
                    TextWidget(
                      AppStrings.detailAd,
                      style: getTextStyle16(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    25.height,
                    const SmoothIndicatorAds(length: 3, index: 1),
                    25.height,
                    TextWidget(
                      AppStrings.typeAd,
                      style: getTextStyle16(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    20.height,
                    Row(
                      children: List.generate(
                        adTypeList.length,
                        (index) => Expanded(
                          child: BtnWidget(
                            height: 50,
                            margin: gPadding(right: 10),
                            titleColor: bloc.state.adType == adTypeList[index]
                                ? AppColors.white
                                : AppColors.black,
                            backgroundColor:
                                bloc.state.adType == adTypeList[index]
                                    ? AppColors.primary
                                    : AppColors.white,
                            border: Border.all(
                              color: AppColors.primary,
                            ),
                            title: adTypeList[index],
                            onTap: () {
                              bloc.add(GetTypeAdEvent(
                                adIdType: adTypeList[index] == AppStrings.sale
                                    ? "0"
                                    : "1",
                                adType: adTypeList[index],
                              ));
                              if (adTypeList[index] != AppStrings.sale) {
                                setState(() {
                                  isSale = false;
                                  print(
                                      'isSalevvvvvvvvvvvvvvvvvvvvvvvv $isSale');
                                });
                              } else {
                                setState(() {
                                  isSale = true;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    25.height,
                    Column(
                      children: [
                        (() {
                          if (state.requestStateCity == RequestState.loaded) {
                            return Column(
                              children: [
                                // isSale
                                //     ? const SizedBox.shrink()
                                //     : TypeReldContent(bloc: bloc),
                                isSale
                                    ? const SizedBox.shrink()
                                    : TypeReldContent(
                                        title: bloc.state.realedType.isEmpty
                                            ? 'نوع الايجار'
                                            : bloc.state.realedType,
                                        color: bloc.state.realedType.isEmpty
                                            ? null
                                            : AppColors.black,
                                        array: reldContent,
                                        onSelectedValue: (value) => bloc.add(
                                          GetRealedTypeEvent(
                                            realedType: reldContent[value].name,
                                          ),
                                        ),
                                      ),
                                15.verticalSpace,
                                // TypeAqarContent(bloc: bloc),
                                TypeAqarContent(
                                  title: bloc.state.aqarType.isEmpty
                                      ? AppStrings.aqarType
                                      : bloc.state.aqarType,
                                  color: bloc.state.aqarType.isEmpty
                                      ? null
                                      : AppColors.black,
                                  array: bloc.state.types,
                                  onSelectedValue: (value) => bloc.add(
                                    GetTypeAqarEvent(
                                      aqarIdType:
                                          bloc.state.types[value].id.toString(),
                                      aqarType: bloc.state.types[value].name
                                          .toString(),
                                    ),
                                  ),
                                ),
                                15.height,
                                // _CityAqarContent(uploadAqarBloc: bloc),
                                CityAqarContent(
                                  title: bloc.state.city.isEmpty
                                      ? AppStrings.cityAqar
                                      : bloc.state.city,
                                  color: bloc.state.city.isEmpty
                                      ? null
                                      : AppColors.black,
                                  array: bloc.state.cities,
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
                                // DistrictAqarContent(uploadAqarBloc: bloc,),
                                DistrictAqarContent(
                                  absorbing:
                                      bloc.state.city.isEmpty ? true : false,
                                  // uploadAqarBloc: bloc,
                                  title: bloc.state.district.isEmpty
                                      ? AppStrings.districtAqar
                                      : bloc.state.district,
                                  color: bloc.state.district.isEmpty
                                      ? null
                                      : AppColors.black,
                                  array: bloc.state
                                      .cities[bloc.state.selectedCity].area!,
                                  onSelectedValue: (value) => bloc.add(
                                    GetDistrictAqarEvent(
                                      district: bloc
                                          .state
                                          .cities[bloc.state.selectedCity]
                                          .area![value]
                                          .name
                                          .toString(),
                                      districtId: bloc
                                          .state
                                          .cities[bloc.state.selectedCity]
                                          .area![value]
                                          .id
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (state.requestStateCity ==
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
                          } else if (state.requestStateCity ==
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
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BtnWidget(
              title: AppStrings.next,
              onTap: () {
                (bloc.state.adType.isEmpty ||
                        bloc.state.aqarType.isEmpty ||
                        bloc.state.city.isEmpty ||
                        bloc.state.district.isEmpty)
                    ? showSnackBar(
                        message: "برجاء استكمال البيانات المطلوبة",
                        isError: true)
                    : i<NavigationService>().toNamed(Routes.selectAdsLocation);
              },
              margin: gPadding(left: 15, right: 15, bottom: 15),
            ),
          ),
        );
      },
    );
  }
}
