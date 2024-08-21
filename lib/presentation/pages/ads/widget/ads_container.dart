import 'package:aqarat/core/widgets/custom_banner_widget.dart';
import 'package:flutter/cupertino.dart';

import '/index.dart';

class AdsContainer extends StatelessWidget {
  const AdsContainer({
    super.key,
    required this.onTap,
    // required this.property,
  });
  final VoidCallback onTap;
  // final Property property;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: gPadding(left: 20, right: 20, top: 16),
      padding: gPaddingSymmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: 10.radius,
          color: AppColors.containerBackground2,
          border: Border.all(color: AppColors.grey)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            const CustomBannerWidget(),
            Padding(
              padding: gPadding(top: 12, right: 13, left: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    "مطلوب شقة للايجار",
                    style: getTextStyleSimSmall(
                      color: AppColors.textColor2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.date,
                        height: 17.h,
                        width: 17.h,
                      ),
                      6.width,
                      TextWidget(
                        "منذ 12 ساعة",
                        style: getTextStyleSimSmall(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textGray3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButtonWidget(
                  onTap: () {},
                  color: AppColors.orange,
                  image: AppImages.pinlocation,
                  backgroundColor: AppColors.orange.withOpacity(.25),
                ),
                7.width,
                const TextWidget("الرياض "),
                TextWidget(
                  "النزهة , التعاون, الازدهار ",
                  style: getTextStyleNormal(color: AppColors.textGray1),
                ),
              ],
            ),
            Container(
              padding: gPadding(top: 12, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: buildIconBtn(
                      AppImages.water,
                      "2 غرفة النوم",
                      style: getTextStyleSimSmall(),
                      imgHeight: 17,
                    ),
                  ),
                  2.width,
                  Expanded(
                    child: buildIconBtn(
                      AppImages.union,
                      "1 دورة المياة",
                      style: getTextStyleSimSmall(),
                      imgHeight: 17,
                    ),
                  ),
                  2.width,
                  Expanded(
                    child: buildIconBtn(
                      AppImages.bedEmpty,
                      "2 غرفة النوم",
                      style: getTextStyleSimSmall(),
                      imgHeight: 17,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextWidget(
                      "28.000 ",
                      style: getTextStyle16(fontWeight: FontWeight.w600),
                    ),
                    TextWidget(
                      "ريال",
                      style: getTextStyle16(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButtonWidget(
                      icon: CupertinoIcons.heart,
                      height: 36,
                      onTap: () {},
                      size: 19,
                    ),
                    IconButtonWidget(
                      icon: Icons.ios_share_outlined,
                      height: 36,
                      size: 17,
                      onTap: () {},
                      padding: gPaddingSymmetric(horizontal: 8),
                    ),
                    IconButtonWidget(
                        image: AppImages.whatsApp, onTap: () {}, height: 36),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
