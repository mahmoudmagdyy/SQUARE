import '/index.dart';

class ElvBtnIc extends StatelessWidget {
  const ElvBtnIc({
    super.key,
    this.onTap,
    this.backColor = AppColors.primary,
    this.foregroundColor = AppColors.grey,
    this.titleColor = AppColors.white,
    required this.icon,
    required this.tx,
  });
  final void Function()? onTap;
  final Color? backColor;
  final Color titleColor;
  final Color? foregroundColor;
  final IconData icon;
  final String tx;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ButtonStyle(
        // padding: MaterialStateProperty.all<EdgeInsets>(
        //   EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.3.h),
        // ),
        backgroundColor: MaterialStateProperty.all<Color?>(backColor),
        foregroundColor: MaterialStateProperty.all<Color?>(foregroundColor),
        shape: MaterialStateProperty.all<BeveledRectangleBorder>(
          BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10).r,
          ),
        ),
      ),
      icon: Icon(icon, size: 16.h),
      label: TextWidget(
        tx,
        style: getTextStyle16(
          color: titleColor,
          fontWeight: FontWeight.w700,
          // letterSpacing: 1,
        ),
      ),
    );
  }
}
