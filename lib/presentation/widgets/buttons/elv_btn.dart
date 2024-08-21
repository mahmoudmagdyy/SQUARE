import '/index.dart';

class ElvBtn extends StatelessWidget {
  const ElvBtn({
    super.key,
    this.tx,
    required this.onTap,
    this.backColor = AppColors.grey,
    this.icon = Icons.more_horiz,
    this.elv = 0,
    this.padding,
    this.isLoading = false,
    this.height,
    this.margin,
    this.width,
    this.titleColor = AppColors.white,
    this.raduis = 10,
    this.icColor = AppColors.black,
    this.txStyle,
  });
  final Color titleColor;
  final Color icColor;
  final VoidCallback onTap;
  final Color? backColor;
  final IconData? icon;
  final bool? isLoading;
  final String? tx;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final TextStyle? txStyle;
  final double elv;
  final double? raduis;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height ?? 54).h,
      width: width != null ? (width!).w : width,
      margin: margin,
      padding: padding ?? gPaddingSymmetric(),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10).r),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elv),
          /* padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 1.4).r,
          ), */
          backgroundColor: MaterialStateProperty.all<Color?>(backColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(raduis!).r),
          ),
        ),
        child: isLoading!
            ? SizedBox(height: 3.h, child: const LoadingWidget())
            : tx == null
                ? Icon(icon, size: 24.h, color: icColor)
                : TextWidget(
                    tx!,
                    style: txStyle ??
                        getTextStyle16(
                          color: titleColor,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                  ),
      ),
    );
  }
}
