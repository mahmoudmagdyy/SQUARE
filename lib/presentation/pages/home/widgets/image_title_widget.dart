import 'package:aqarat/index.dart';

class ImageTitleWidget extends StatelessWidget {
  const ImageTitleWidget({super.key, required this.image, required this.title});
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NetworkImageWidget(
          image,
          height: 130.h,
          width: 85.w,
          fit: BoxFit.contain,
        ),
        5.height,
        TextWidget(
          title,
          style: getTextStyleNormal(
            color: AppColors.textGray1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
