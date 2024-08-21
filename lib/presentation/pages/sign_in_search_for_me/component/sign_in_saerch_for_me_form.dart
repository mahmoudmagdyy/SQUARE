import '/index.dart';
import '../../../bloc/search_for_me_cubit/search_for_me_cubit.dart';

class SignInSaerchForMeForm extends StatelessWidget {
  const SignInSaerchForMeForm({super.key, required this.bloc});
  final UploadAqarBloc bloc;
  @override
  Widget build(BuildContext context) {
    SearchForMeCubit searchForMeCubit =
        BlocProvider.of<SearchForMeCubit>(context);
    return Column(
      children: [
        bloc.state.requestStateType == RequestState.loaded
            ? Row(
                children: [
                  Expanded(child: _CityAqarContent(uploadAqarBloc: bloc)),
                  15.width,
                  Expanded(child: _DistrictAqarContent(uploadAqarBloc: bloc)),
                ],
              )
            : Row(
                children: [
                  const Expanded(child: TitleCardShimmer()),
                  15.width,
                  const Expanded(child: TitleCardShimmer()),
                ],
              ),
        20.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'الميزانيه',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget('من'),
                  9.width,
                  Expanded(
                    child: SizedBox(
                      height: 87.h,
                      width: 124.w,
                      child: TextInputWidget(
                        '',
                        hintText: '',
                        controller: searchForMeCubit.fromPriceController,
                        textInputAction: TextInputAction.next,
                        fillColor: AppColors.white,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget('الى'),
                  9.width,
                  SizedBox(
                    height: 87.h,
                    width: 124.w,
                    child: TextInputWidget(
                      '',
                      controller: searchForMeCubit.toPriceController,
                      textInputAction: TextInputAction.next,
                      fillColor: AppColors.white,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        16.height,
        TextInputWidget(
          "حدد المساحة",
          hintText: '',
          controller: searchForMeCubit.spaceController,
          fillColor: AppColors.white,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          onChanged: (value) {},
        ),
        16.height,
        TextInputWidget(
          'الوصف',
          maxLines: 4,
          hintText: '',
          controller: searchForMeCubit.descController,
          fillColor: AppColors.white,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          onChanged: (value) {},
        ),
      ],
    );
  }
}

class _CityAqarContent extends StatelessWidget {
  const _CityAqarContent({required this.uploadAqarBloc});
  final UploadAqarBloc uploadAqarBloc;
  @override
  Widget build(BuildContext context) {
    SearchForMeCubit searchForMeCubit =
        BlocProvider.of<SearchForMeCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          AppStrings.cityAqar,
          style: getTextStyle16(fontWeight: FontWeight.w600),
        ),
        5.height,
        ExpandableWidget(
          title: uploadAqarBloc.state.city.isEmpty
              ? AppStrings.cityAqar
              : uploadAqarBloc.state.city,
          color: uploadAqarBloc.state.city.isEmpty ? null : AppColors.black,
          array: uploadAqarBloc.state.cities,
          onSelectedValue: (value) {
            BlocProvider.of<SearchForMeCubit>(context).cityId =
                uploadAqarBloc.state.cities[value].id!;
            print(
                '0000000000000${BlocProvider.of<SearchForMeCubit>(context).cityId}');
            uploadAqarBloc.add(
              GetCityAqarEvent(
                city: uploadAqarBloc.state.cities[value].name.toString(),
                cityId: uploadAqarBloc.state.cities[value].id.toString(),
                selectedCity: value,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _DistrictAqarContent extends StatelessWidget {
  const _DistrictAqarContent({required this.uploadAqarBloc});
  final UploadAqarBloc uploadAqarBloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          AppStrings.districtAqar,
          style: getTextStyle16(fontWeight: FontWeight.w600),
        ),
        5.height,
        AbsorbPointer(
          absorbing: uploadAqarBloc.state.city.isEmpty ? true : false,
          child: ExpandableWidget(
            title: uploadAqarBloc.state.district.isEmpty
                ? AppStrings.districtAqar
                : uploadAqarBloc.state.district,
            color:
                uploadAqarBloc.state.district.isEmpty ? null : AppColors.black,
            array: uploadAqarBloc
                    .state.cities[uploadAqarBloc.state.selectedCity].area ??
                [],
            onSelectedValue: (value) {
              BlocProvider.of<SearchForMeCubit>(context).areaId = uploadAqarBloc
                  .state
                  .cities[uploadAqarBloc.state.selectedCity]
                  .area![value]
                  .id!;
              uploadAqarBloc.add(
                GetDistrictAqarEvent(
                    district: uploadAqarBloc
                        .state
                        .cities[uploadAqarBloc.state.selectedCity]
                        .area![value]
                        .name
                        .toString(),
                    districtId: uploadAqarBloc
                        .state
                        .cities[uploadAqarBloc.state.selectedCity]
                        .area![value]
                        .id
                        .toString()),
              );
            },
          ),
        ),
      ],
    );
  }
}
