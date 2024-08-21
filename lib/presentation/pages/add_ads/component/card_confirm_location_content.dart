import '/index.dart';

class CardConfirmLocationContent extends StatelessWidget {
  const CardConfirmLocationContent({super.key, required this.callback});
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: gPadding(right: 20, top: 15, left: 20, bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: 10.radius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextWidget(
            "اختيار الموقع",
            style: getTextStyle18(fontWeight: FontWeight.w600),
          ),
          5.height,
          const TextWidget("يمكنك اختيار موقع محدد أو تقريبي للعقار"),
          25.height,
          Row(
            children: [
              Expanded(
                child: CardOptionWidget(
                  image: AppImages.pinLocation,
                  title: "موقع محدد",
                  callback: callback,
                  isSelected: false,
                ),
              ),
              20.width,
              Expanded(
                child: CardOptionWidget(
                  image: AppImages.locationDuotone,
                  title: "موقع تقريبي",
                  callback: () {},
                  isSelected: false,
                ),
              ),
            ],
          ),
          30.height,
          BtnWidget(
            title: 'تأكيد',
            backgroundColor: AppColors.primary,
            onTap: () => i<NavigationService>().toNamed(Routes.addAdsImgPage),
          )
        ],
      ),
    );
  }

  bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.scaffoldBackground,
      builder: (context) {
        List<String> tit = [
          'الرائد',
          'الرحاب',
          'الرسالة',
          'الرمال',
          'الرائد',
          'الرحاب',
          'الرسالة',
          'الرمال',
        ];
        debugPrint("<<<<<<<<BottomSheet>>>>>>>>");
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: BorderRadius.circular(50).r,
              ),
              padding: gPadding(top: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextWidget(
                      "الأحياء",
                      style: getTextStyle16(fontWeight: FontWeight.w800),
                    ),
                    _searchbar(),
                    10.height,
                    Column(
                      children: [
                        ...List.generate(
                          tit.length,
                          (index) => MyCheckboxListTile(tit[index]),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: AppColors.scaffoldBackground,
                child: BtnWidget(
                  title: 'تم',
                  onTap: () {},
                  margin: gPadding(left: 20, right: 20, bottom: 32, top: 22),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

TextInputWidget _searchbar() {
  return const TextInputWidget(
    '',
    hintText: "البحث",
    prefixIcon: Icons.search,
    prefixColor: AppColors.textColor,
  );
}
