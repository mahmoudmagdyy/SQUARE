import '/index.dart';

class EditAdsButtonWidget extends StatelessWidget {
  const EditAdsButtonWidget(
      {super.key,
      this.bgColor,
      this.borderColor,
      this.textColor,
      required this.title,
      required this.onTap});
  final Color? bgColor;
  final Color? borderColor;
  final Color? textColor;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BtnWidget(
        onTap: null,
        height: 40.h,
        radius: 16.r,
        border: Border.all(color: borderColor ?? AppColors.primary, width: 1.5),
        backgroundColor: bgColor ?? AppColors.primary,
        child: Center(
          child: TextWidget(
            title,
            style: getTextStyle18(
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
