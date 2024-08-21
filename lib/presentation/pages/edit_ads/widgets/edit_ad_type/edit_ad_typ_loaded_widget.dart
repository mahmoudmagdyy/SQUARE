import 'dart:developer';

import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';
import 'package:aqarat/presentation/pages/add_ads/widgets/city_aqar_content.dart';
import 'package:aqarat/presentation/pages/add_ads/widgets/district_aqar_content.dart';
import 'package:aqarat/presentation/pages/add_ads/widgets/type_aqar_content.dart';
import 'package:aqarat/presentation/pages/add_ads/widgets/type_reld_content.dart';

class EditAdTypLoadedWidget extends StatefulWidget {
  const EditAdTypLoadedWidget({super.key, required this.state});
  final EditMyAdState state;

  @override
  State<EditAdTypLoadedWidget> createState() => _EditAdTypLoadedWidgetState();
}

class _EditAdTypLoadedWidgetState extends State<EditAdTypLoadedWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        i<UploadAqarBloc>().clearAllData();
        return true;
      },
      child: Scaffold(
        appBar: AppBarWidget(
          title: 'تعديل الاعلان',
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
                    (index) {
                      return Expanded(
                        child: BtnWidget(
                          height: 50,
                          margin: gPadding(right: 10),
                          titleColor:
                              widget.state.property!.type == adTypeList[index]
                                  ? AppColors.white
                                  : AppColors.black,
                          backgroundColor:
                              widget.state.property!.type == adTypeList[index]
                                  ? AppColors.primary
                                  : AppColors.white,
                          border: Border.all(
                            color: AppColors.primary,
                          ),
                          title: adTypeList[index],
                          onTap: () {
                            context.read<EditMyAdCubit>().changeAdType(
                                  adTypeList[index],
                                  index,
                                );
                            context
                                .read<EditMyAdCubit>()
                                .toggleIsForSale(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
                25.height,
                BlocBuilder<UploadAqarBloc, UploadAqarState>(
                  builder: (context, uploadState) {
                    final UploadAqarBloc bloc =
                        BlocProvider.of<UploadAqarBloc>(context);

                    switch (uploadState.requestStateCity) {
                      case RequestState.none:
                      case RequestState.loading:
                        return Column(
                          children: [
                            const TitleCardShimmer(),
                            15.height,
                            const TitleCardShimmer(),
                            15.height,
                            const TitleCardShimmer(),
                          ],
                        );
                      case RequestState.loaded:
                        return Column(
                          children: [
                            widget.state.isForSale
                                ? const SizedBox.shrink()
                                : TypeReldContent(
                                    title: widget.state.property?.typeStatus ??
                                        'نوع الايجار',
                                    color: widget.state.property!.typeStatus ==
                                            null
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
                            BlocBuilder<EditMyAdCubit, EditMyAdState>(
                              builder: (context, state) {
                                return TypeAqarContent(
                                  title: state.property!.category.isEmpty
                                      ? AppStrings.aqarType
                                      : state.property!.category,
                                  color: state.property!.category.isEmpty
                                      ? null
                                      : AppColors.black,
                                  array: uploadState.types,
                                  onSelectedValue: (value) {
                                    context
                                        .read<EditMyAdCubit>()
                                        .onAqarCategoryChange(value);
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                            15.height,
                            CityAqarContent(
                              title: widget.state.property!.city.isEmpty
                                  ? AppStrings.cityAqar
                                  : widget.state.property!.city,
                              color: widget.state.property!.city.isEmpty
                                  ? null
                                  : AppColors.black,
                              array: uploadState.cities,
                              onSelectedValue: (value) {
                                context
                                    .read<EditMyAdCubit>()
                                    .onAqarCityChange(value);
                                setState(() {});
                              },
                            ),
                            15.height,
                            DistrictAqarContent(
                              absorbing: widget.state.districts.isEmpty,
                              // absorbing: state.property!.area.isEmpty
                              //     ? true
                              //     : false,
                              title: widget.state.property!.area.isEmpty
                                  ? AppStrings.districtAqar
                                  : widget.state.property!.area,
                              color: widget.state.property!.area.isEmpty
                                  ? null
                                  : AppColors.black,
                              array: widget.state.districts,
                              onSelectedValue: (value) {
                                context
                                    .read<EditMyAdCubit>()
                                    .onAqarDistrictChange(value);
                                setState(() {});
                              },
                            ),
                          ],
                        );
                      case RequestState.error:
                        return Center(
                          child: TextWidget(
                            "Error",
                            style:
                                getTextStyleNormal(fontWeight: FontWeight.w600),
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BtnWidget(
          title: AppStrings.next,
          onTap: () {
            log('Area ${widget.state.property?.area}');
            log('isForSale ${widget.state.isForSale}');
            log('PaymentMethod ${widget.state.paymentMethod}');
            if ((widget.state.property?.area == null ||
                    widget.state.property!.area.isEmpty) ||
                widget.state.isForSale == false &&
                    widget.state.paymentMethod == null) {
              showSnackBar(
                message: "برجاء استكمال البيانات المطلوبة",
                isError: true,
              );
            } else {
              i<NavigationService>().toNamed(
                Routes.editAdMap,
                arguments: LatLng(
                  double.parse(widget.state.property!.lat.toString()),
                  double.parse(
                    widget.state.property!.lng.toString(),
                  ),
                ),
              );
            }
          },
          margin: gPadding(left: 15, right: 15, bottom: 15),
        ),
      ),
    );
  }
}
