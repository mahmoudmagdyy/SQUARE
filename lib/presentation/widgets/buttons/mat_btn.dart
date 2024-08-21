import '/index.dart';

class MatBtn extends StatelessWidget {
  const MatBtn(
    this.tx, {
    super.key,
    required this.onTap,
    this.backColor = AppColors.primaryBackground,
    this.icon = Icons.more_horiz,
    this.elv = 6,
    this.padding,
    this.isLoading = false,
    this.height,
    this.margin,
    this.width,
    this.titleColor = AppColors.white,
    this.radius,
  });
  final Color titleColor;
  final VoidCallback onTap;
  final Color? backColor;
  final IconData? icon;
  final bool? isLoading;
  final String? tx;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final double? radius;
  final double elv;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding ?? gPaddingSymmetric(),
      child: MaterialButton(
        onPressed: onTap,
        elevation: elv,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1.4).r,
        color: backColor,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular((radius ?? 15).w),
        ),
        child: isLoading!
            ? SizedBox(height: 3.h, child: const LoadingWidget())
            : tx == null
                ? _icon()
                : _text(),
      ),
    );
  }

  Icon _icon() => Icon(icon, size: 20);

  TextWidget _text() => TextWidget(
        tx ?? '',
        style: getTextStyleNormal(
          color: titleColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      );
}
