import 'package:aqarat/index.dart';

class CardOptionWidget extends StatelessWidget {
  const CardOptionWidget({
    super.key,
    required this.image,
    required this.title,
    required this.isSelected,
    required this.callback,
    this.mainAxisAlignment,
  });
  final String image;
  final String title;
  final bool isSelected;
  final VoidCallback callback;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: gPadding(top: 10, bottom: 15),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.primary : AppColors.containerBackground2,
          borderRadius: BorderRadius.circular(10).r,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, isSelected ? 0 : 4),
              color: AppColors.grey.withOpacity(.6),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          children: [
            image.contains("svg")
                ? SvgPicture.asset(
                    image,
                    height: 35.h,
                    width: 35.h,
                  )
                : Image.asset(
                    image,
                    height: 35.h,
                    width: 35.h,
                  ),
            5.height,
            TextWidget(
              title,
              style: getTextStyleNormal(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
