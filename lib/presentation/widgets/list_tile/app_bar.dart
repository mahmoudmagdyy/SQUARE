import '/index.dart';

ListTile appbar({
  String? tit,
  Widget? leading,
  Widget? titWidget,
  Widget? trailing,
  void Function()? trailingTap,
  TextStyle? style,
  EdgeInsetsGeometry? padding,
}) =>
    ListTile(
      contentPadding: padding ?? gPadding(),
      title: titWidget ??
          TextWidget(
            tit ?? '',
            textAlign: TextAlign.center,
            style: style ?? getTextStyle20(fontWeight: FontWeight.w500),
          ),
      leading: GestureDetector(
        onTap: trailingTap ?? () => i<NavigationService>().pop(),
        child: leading ?? const SizedBox(),
      ),
      trailing: trailing ?? const SizedBox(width: 50),
    );

CircleAvatar arrowBackIcon() {
  return CircleAvatar(
    backgroundColor: AppColors.transparent,
    child: SvgPicture.asset(AppImages.arrowRightLine),
  );
}
