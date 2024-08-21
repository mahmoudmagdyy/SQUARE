import '/index.dart';

class BtnWidget extends StatelessWidget {
  const BtnWidget({
    Key? key,
    this.title,
    required this.onTap,
    this.backgroundColor = AppColors.primary,
    this.titleColor = AppColors.white,
    this.style,
    this.child,
    this.height,
    this.width = double.infinity,
    this.radius,
    this.isLoading = false,
    this.border,
    this.margin,
  }) : super(key: key);
  final String? title;

  final VoidCallback? onTap;
  final BoxBorder? border;
  final Color? backgroundColor;
  final Color titleColor;
  final TextStyle? style;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final double? radius;
  final Widget? child;
  final bool isLoading;
  @override
  Widget build(BuildContext context) => Container(
        height: (height ?? 55).h,
        width: (width ?? 335).w,
        margin: margin ?? gPadding(),
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular((radius ?? 10).r),
          color: backgroundColor,
        ),
        child: title != null
            ? FittedBox(
                fit: BoxFit.none,
                child: TextButton(
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0),
                    overlayColor:
                        const MaterialStatePropertyAll(AppColors.transparent),
                    padding: MaterialStatePropertyAll(
                      gPaddingSymmetric(horizontal: 100),
                    ),
                  ),
                  onPressed: isLoading ? () {} : onTap,
                  child: isLoading
                      ? const Center(child: LoadingWidget())
                      : TextWidget(
                          title!,
                          textAlign: TextAlign.center,
                          style: style ??
                              getTextStyle16(
                                color: titleColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                ),
              )
            : child,
      );
}
