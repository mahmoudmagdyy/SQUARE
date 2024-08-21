import 'package:aqarat/index.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
    required this.image,
    required this.subTitle,
    this.title,
  });
  final String image;
  final String? title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: gPadding(
          right: 30,
          top: ScreenUtil().screenHeight / 4,
          left: 30,
          bottom: ScreenUtil().screenHeight / 4,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              image,
              height: 50.h,
              width: 50.h,
              color: AppColors.textGray22,
            ),
            10.height,
            TextWidget(
              title ?? AppStrings.title,
              style: getTextStyle18(fontWeight: FontWeight.w600),
            ),
            10.height,
            TextWidget(
              subTitle,
              textAlign: TextAlign.center,
              style: getTextStyleNormal(
                height: 1.25,
                color: AppColors.textGray22.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
