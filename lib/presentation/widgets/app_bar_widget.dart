import 'package:aqarat/index.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.isShowBackButton = true,
    this.child,
    this.onPressed,
  });
  final String title;
  final bool isShowBackButton;
  final Widget? child;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: !isShowBackButton,
      actions: [
        Padding(
          padding: gPadding(left: 15),
          child: child ?? 0.height,
        ),
      ],
      title: isShowBackButton
          ? Row(
              children: [
                IconButton.filled(
                  style: IconButton.styleFrom(
                    fixedSize: Size(38.0.h, 38.0.h),
                    shape: RoundedRectangleBorder(borderRadius: 4.radius),
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {
                    onPressed?.call();
                    i<NavigationService>().pop();
                  },
                  icon: SvgPicture.asset(
                    AppImages.arrowRightLine,
                    color: AppColors.white,
                  ),
                ),
                Spacer(flex: (ScreenUtil().screenWidth ~/ 2).toInt()),
                TextWidget(
                  title,
                  style: getTextStyle18(
                      color: AppColors.black, fontWeight: FontWeight.w600),
                ),
                Spacer(flex: (ScreenUtil().screenWidth ~/ 2).toInt()),
              ],
            )
          : TextWidget(
              title,
              style: getTextStyle18(
                  color: AppColors.black, fontWeight: FontWeight.w600),
            ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
