import 'dart:developer';

import '/index.dart';

//Todo : copy this

class AqarDetailsPage extends StatefulWidget {
  const AqarDetailsPage({super.key});

  @override
  State<AqarDetailsPage> createState() => _AqarDetailsPageState();
}

class _AqarDetailsPageState extends State<AqarDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadAqarBloc, UploadAqarState>(
      listener: (BuildContext context, UploadAqarState state) {
        // if (state.requestState == RequestState.loaded) {
        //   context.read<HomeBloc>().add(const GetAdsEvent());
        // }
      },
      builder: (context, state) {
        UploadAqarBloc bloc = context.read<UploadAqarBloc>();
        return Scaffold(
          appBar: const AppBarWidget(title: AppStrings.addAd),
          body: Container(
            padding: gPadding(right: 15, left: 15, bottom: 15),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    25.height,
                    TextWidget(
                      AppStrings.detailAqar,
                      style: getTextStyle16(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    25.height,
                    const SmoothIndicatorAds(length: 3, index: 3),
                    25.height,
                    _body(context: context, bloc: bloc),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BtnWidget(
            title: 'رفع الطلب',
            isLoading: bloc.state.requestState == RequestState.loading,
            onTap: () => (bloc.priceController.text.isEmpty ||
                    bloc.state.values.length != bloc.state.questions.length ||
                    bloc.state.age.isEmpty ||
                    bloc.titleController.text.isEmpty ||
                    bloc.descriptionController.text.isEmpty ||
                    bloc.state.extraOptions.isEmpty)
                ? showSnackBar(
                    message: "برجاء استكمال البيانات المطلوبة", isError: true)
                : bloc.add(UploadNewAqarEvent()),
            margin: gPadding(left: 15, right: 15, bottom: 15),
          ),
        );
      },
    );
  }

  _body({
    required BuildContext context,
    required UploadAqarBloc bloc,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BtnWidget(
              title: "الميزانية",
              width: 140,
              height: 45,
              style: getTextStyle16(
                  fontWeight: FontWeight.w600, color: AppColors.white),
              radius: 8,
              onTap: null,
            ),
            Row(
              children: [
                TextWidget(
                  bloc.state.price.isEmpty
                      ? "0.00"
                      : OtherMethods.format(int.parse(bloc.state.price)),
                  style: getTextStyle18(
                    color: AppColors.textGray22,
                  ),
                ),
                5.width,
                TextWidget(
                  'ريال',
                  style: getTextStyle18(
                    color: AppColors.textGray22,
                  ),
                ),
              ],
            ),
          ],
        ),
        TextInputWidget(
          '',
          hintText: "من فضلك ادخل السعر",
          textInputAction: TextInputAction.done,
          controller: bloc.priceController,
          keyboardType: TextInputType.number,
          fillColor: AppColors.white,
          // onChanged: (value) => bloc.add(GetPriceAqarEvent(price: value!)),
        ),
        Row(
          children: [
            Checkbox(
              value: bloc.state.isCheckBox,
              onChanged: (value) =>
                  bloc.add(GetCheckBoxAqarEvent(isCheckBox: value!)),
            ),
            TextWidget(
              "السعر قابل للتفاوض",
              style: getTextStyle16(
                  decoration: TextDecoration.underline,
                  color: AppColors.greyDark2.withOpacity(.30)),
            ),
          ],
        ),
        30.height,
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: bloc.state.questions.length,
          itemBuilder: (context, index) {
            String value = '';
            late int existingIndex;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  bloc.state.questions[index].title.toString(),
                  style: getTextStyle16(),
                ),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    bloc.state.questions[index].values.length,
                    (i) {
                      (() {
                        bloc.state.values.map((element) {
                          if (bloc.state.questions[index].id.toString() ==
                              element['id']) {
                            value = bloc.state.questions[index].values[i]
                                .toString();
                          }
                        }).toList();
                        existingIndex = bloc.state.values.indexWhere(
                            (element) =>
                                bloc.state.questions[index].id.toString() ==
                                element['id']);
                        log("Existing Index ======> $existingIndex");
                        log("value ======> $value");
                      }());
                      return GestureDetector(
                        onTap: () => bloc.add(
                          GetValueAqarEvent(value: {
                            "id": bloc.state.questions[index].id.toString(),
                            "value": bloc.state.questions[index].values[i],
                          }),
                        ),
                        child: Container(
                          height: 38.h,
                          width: 38.h,
                          margin: gPadding(right: 5.0, bottom: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: value.isEmpty
                                ? AppColors.greyLight
                                : bloc.state.values[existingIndex]['value'] ==
                                        value
                                    ? AppColors.primary
                                    : AppColors.greyLight,
                            borderRadius: 8.radius,
                          ),
                          child: TextWidget(
                            bloc.state.questions[index].values[i].toString(),
                            style: getTextStyle16(
                              fontWeight: FontWeight.w600,
                              color: value.isEmpty
                                  ? AppColors.textColor
                                  : bloc.state.values[existingIndex]['value'] ==
                                          value
                                      ? AppColors.white
                                      : AppColors.textColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        25.height,
        TextWidget(
          'عمر العقار',
          style: getTextStyleNormal(
              color: AppColors.black, fontWeight: FontWeight.w500),
        ),
        10.height,
        ExpandableWidget(
          title: bloc.state.age.isEmpty ? "عمر العقار" : bloc.state.age,
          color: bloc.state.age.isEmpty ? null : AppColors.black,
          array: age,
          onSelectedValue: (value) =>
              bloc.add(GetAgeAqarEvent(age: age[value].name)),
        ),
        25.height,
        TextInputWidget(
          'مساحه العقار',
          keyboardType: TextInputType.number,
          textStyle: getTextStyleNormal(fontWeight: FontWeight.w500),
          hintStyle: getTextStyleSmall(color: AppColors.textHent),
          fillColor: AppColors.white,
          controller: bloc.spaceController,
          // onChanged: (value) => bloc.add(
          //   GetSpaceEvent(
          //     space: int.parse(value!),
          //   ),
          // ),
        ),
        25.height,
        TextWidget(
          'طريقة الدفع',
          style: getTextStyleNormal(
              color: AppColors.black, fontWeight: FontWeight.w500),
        ),
        10.height,
        ExpandableWidget(
          title:
              bloc.state.payment.isEmpty ? 'طريقة الدفع' : bloc.state.payment,
          color: bloc.state.payment.isEmpty ? null : AppColors.black,
          array: payment,
          onSelectedValue: (value) =>
              bloc.add(GetPaymentEvent(payment: payment[value].name)),
        ),
        25.height,
        TextInputWidget(
          "عنوان الإعلان",
          controller: bloc.titleController,
          textStyle: getTextStyleNormal(fontWeight: FontWeight.w500),
          hintStyle: getTextStyleSmall(color: AppColors.textHent),
          fillColor: AppColors.white,

          // onChanged: (value) => bloc.add(GetTitleAqarEvent(title: value!)),
        ),
        15.height,
        TextInputWidget(
          "التفاصيل",
          textStyle: getTextStyleNormal(fontWeight: FontWeight.w500),
          hintText: 'أضف تفاصيل إضافية عن العقار ليكون جاذبا\nللعملاء',
          hintStyle: getTextStyleSmall(color: AppColors.textHent),
          fillColor: AppColors.white,
          maxLines: 4,
          controller: bloc.descriptionController,
          // onChanged: (value) =>
          //     bloc.add(GetDescriptionAqarEvent(description: value!)),
        ),
        15.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              'خيارات اضافية',
              style: getTextStyleNormal(
                  color: AppColors.black, fontWeight: FontWeight.w500),
            ),
            SvgPicture.asset(
              AppImages.arrowdown,
              height: 8.5.h,
              width: 15.w,
            ),
          ],
        ),
        Padding(
          padding: gPadding(top: 15, bottom: 5),
          child: Wrap(
            spacing: 15.w,
            runSpacing: 10.h,
            alignment: WrapAlignment.spaceBetween,
            children: List.generate(
              bloc.state.extraOptions.length,
              (index) => BoxWidget(
                // bloc: bloc,
                title: bloc.state.extraOptions[index].title.toString(),
                backgroundColor: bloc.state.selectExtraOptions
                        .contains(bloc.state.extraOptions[index].id.toString())
                    ? AppColors.primary
                    : null,
                titleColor: bloc.state.selectExtraOptions
                        .contains(bloc.state.extraOptions[index].id.toString())
                    ? AppColors.white
                    : null,
                callback: () => bloc.add(
                  GetExtraOptionAqarEvent(
                    selectExtraOption:
                        bloc.state.extraOptions[index].id.toString(),
                  ),
                ),
              ),
            ),
          ),
        ),
        TextWidget(
          "*ليس هناك ما يمنع من التصرف أو الانتفاع من العقار",
          style: getTextStyleNormal(
            fontWeight: FontWeight.w500,
            color: AppColors.black.withOpacity(.39),
          ),
        ),
        26.height,
      ],
    );
  }
}

List<AgeModel> age = [
  const AgeModel(id: 1, name: "10"),
  const AgeModel(id: 2, name: "20"),
  const AgeModel(id: 3, name: "30"),
  const AgeModel(id: 4, name: "40"),
  const AgeModel(id: 5, name: "50"),
  const AgeModel(id: 6, name: "60"),
  const AgeModel(id: 7, name: "70"),
  const AgeModel(id: 8, name: "80"),
  const AgeModel(id: 9, name: "90"),
  const AgeModel(id: 10, name: "100+"),
];
List<AgeModel> payment = [
  const AgeModel(id: 1, name: 'الدفع كاش'),
  const AgeModel(id: 2, name: 'الدفع بالفيزا '),
  const AgeModel(id: 3, name: 'التمويل العقاري'),
];

class AgeModel extends Equatable {
  final int id;
  final String name;

  const AgeModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
