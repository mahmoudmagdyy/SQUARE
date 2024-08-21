import '/index.dart';

class IconBt extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final double? iconSiz;
  final Color iconColor;
  final Color bgColor;
  final BorderSide side;
  final double? radius;
  final Widget? child;
  final String? tooltip;

  const IconBt({
    super.key,
    this.onPressed,
    this.icon,
    this.padding,
    this.iconSiz,
    this.iconColor = AppColors.white,
    this.bgColor = AppColors.transparent,
    this.side = const BorderSide(width: 0, color: AppColors.transparent),
    this.radius,
    this.child,
    this.tooltip,
    this.margin,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: IconButton.filled(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(bgColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((radius ?? 10).r),
              side: side,
            ),
          ),
          iconColor: MaterialStatePropertyAll(iconColor),
          iconSize: MaterialStatePropertyAll((iconSiz ?? 17).h),
          padding: MaterialStatePropertyAll(padding ?? gPadding()),
        ),
        tooltip: tooltip,
        onPressed: onPressed ?? () {},
        icon: child ?? Icon(icon),
      ),
    );
  }
}
