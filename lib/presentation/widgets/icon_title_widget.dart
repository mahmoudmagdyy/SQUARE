import 'package:aqarat/index.dart';

class IconTitleWidget extends StatelessWidget {
  const IconTitleWidget({
    super.key,
    this.width,
    required this.image,
    required this.title,
    this.imageHeight,
    this.style,
    this.margin,
  });
  final double? width;
  final String image;
  final String title;
  final double? imageHeight;
  final TextStyle? style;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: width,
      margin: margin,
      padding: gPadding(left: 8, top: 5, right: 8, bottom: 5),
      decoration: BoxDecoration(
        color: AppColors.containerBackground,
        borderRadius: 16.radius,
      ),
      child: Row(
        children: [
          SvgPicture.asset(image, height: (imageHeight ?? 8).h),
          8.width,
          TextWidget(
            title,
            style: style ?? getTextStyleNormal(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
