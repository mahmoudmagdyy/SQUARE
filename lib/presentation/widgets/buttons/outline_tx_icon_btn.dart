import '/index.dart';

class CustomOutLineIcBtn extends StatelessWidget {
  const CustomOutLineIcBtn({
    super.key,
    this.onTap,
    this.foregroundColor = AppColors.orange,
    this.backColor = AppColors.greyLight,
    required this.icon,
    required this.tx,
    this.canel = false,
  });
  final void Function()? onTap;
  final Color? foregroundColor;
  final Color? backColor;
  final IconData icon;
  final String tx;
  final bool canel;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: canel ? AppColors.red : foregroundColor,
        backgroundColor: backColor,
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.4.h),
        shape: const StadiumBorder(side: BorderSide(color: Colors.transparent)),
      ),
      icon: Icon(canel ? Icons.cancel : icon, size: 2.5.h),
      label: TextWidget(canel ? AppStrings.cancel : tx),
    );
  }
}
