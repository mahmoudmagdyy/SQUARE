import '/index.dart';

class DisplayAdsInputsPage extends StatelessWidget {
  const DisplayAdsInputsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 282.h,
                      width: 375.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.adsDetailsSimilar),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20.h,
                      right: 20.w,
                      left: 20.w,
                      child: _appBar(),
                    ),
                  ],
                ),
                14.height,
                _details(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile _appBar() => appbar(
        style: getTextStyle18(),
        leading: arrowBackIcon(),
      );

  _details() => Padding(
        padding: gPaddingSymmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: gPadding(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextWidget(
                        "منذ 12 ساعة",
                        style: getTextStyleSimSmall(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textGray3,
                        ),
                      ),
                      6.width,
                      SvgPicture.asset(
                        AppImages.date,
                        height: 17.h,
                        width: 17.h,
                      ),
                    ],
                  ),
                  TextWidget(
                    "مطلوب شقة للايجار",
                    style: getTextStyleNormal(
                      color: AppColors.textColor2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            19.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButtonWidget(
                  onTap: () {},
                  color: AppColors.orange,
                  backgroundColor: AppColors.orange.withOpacity(.2),
                ),
                const TextWidget("  الرياض"),
                7.width,
                TextWidget(
                  "النزهة , التعاون, الازدهار ",
                  style: getTextStyleNormal(
                    color: AppColors.textGray1,
                  ),
                ),
              ],
            ),
            Padding(
              padding: gPaddingSymmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(
                    "سعر السوق",
                    style: getTextStyleNormal(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBackground,
                    ),
                  ),
                  32.width,
                  Container(
                    alignment: Alignment.center,
                    padding: gPaddingSymmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: AppColors.blue,
                    ),
                    child: TextWidget(
                      "شراء",
                      style: getTextStyleNormal(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            ListTileWidget(
              title: 'صفة مقدم الطلب',
              trailingWidget: FittedBox(
                fit: BoxFit.none,
                child: Container(
                  height: 25.h,
                  width: 59.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    color: AppColors.redLight,
                  ),
                  child: TextWidget(
                    "مالك",
                    style: getTextStyleNormal(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Divider(color: AppColors.textGrayLight, height: .5.h),
            const ListTileWidget(title: 'المساحة', trailing: "300-400 م2"),
            Divider(color: AppColors.textGrayLight, height: .5.h),
            const ListTileWidget(title: 'عمر العقار', trailing: "جديد"),
            Divider(color: AppColors.textGrayLight, height: .5.h),
            const ListTileWidget(title: 'رقم الطلب', trailing: "3265987"),
            Divider(color: AppColors.textGrayLight, height: .5.h),
            const ListTileWidget(title: 'التفضيلات'),
            Container(
              height: 25.h,
              width: 89.w,
              alignment: Alignment.centerRight,
              padding: gPadding(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8).r,
                color: AppColors.containerBackground,
                border: Border.all(color: AppColors.grey2.withOpacity(.66)),
              ),
              child: TextWidget(
                "مودرن",
                style: getTextStyleNormal(fontWeight: FontWeight.w500),
              ),
            ),
            15.height,
            Divider(color: AppColors.textGrayLight, height: .5.h),
            Row(
              children: [
                TextWidget(
                  '2569875',
                  style: getTextStyleNormal(color: AppColors.textGrayLight4),
                ),
                TextWidget(
                  ' : رقم الاعلان ',
                  style: getTextStyleNormal(color: AppColors.textGrayLight2),
                ),
              ],
            ),
          ],
        ),
      );
}
