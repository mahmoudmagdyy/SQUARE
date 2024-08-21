import '../../index.dart';

class SmoothIndicator extends StatelessWidget {
  const SmoothIndicator({
    super.key,
    required this.count,
    required this.index,
    this.defaultColor = AppColors.white,
    this.color,
    this.ads = false,
  });

  final int count;
  final Color defaultColor;
  final Color? color;
  final int index;
  final bool ads;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            count,
            (i) => AnimatedContainer(
              margin: gPaddingSymmetric(horizontal: color == null ? 0 : 4),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOutCubicEmphasized,
              width:
                  color == null ? (index == i ? 25.w : 15.w) : (ads ? 8 : 25).h,
              height: (ads ? 8 : 3.5).h,
              decoration: BoxDecoration(
                color: color == null
                    ? (index >= i
                        ? defaultColor
                        : AppColors.white.withOpacity(.5))
                    : (index == i
                        ? defaultColor
                        : (color ?? AppColors.white).withOpacity(.5)),
                borderRadius: BorderRadius.circular(
                  color == null ? 0 : (ads ? 100 : 10),
                ).r,
              ),
            ),
          )
        ],
      );
}
