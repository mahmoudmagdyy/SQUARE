import '/index.dart';

Widget bottomSheetListTile(
  String title, {
  IconData? icon,
  String? image,
  required VoidCallback callback,
}) =>
    ListTile(
      leading: icon != null
          ? Icon(icon, size: 24.h, color: AppColors.primary)
          : SvgPicture.asset(image!, height: 24.h, width: 24.h),
      title: TextWidget(
        title,
        overflow: TextOverflow.ellipsis,
        style: getTextStyle16(color: AppColors.black),
      ),
      dense: true,
      onTap: callback,
      trailing: Icon(Icons.keyboard_arrow_right_rounded, size: 2.5.h),
    );
