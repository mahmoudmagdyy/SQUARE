import 'package:aqarat/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

showSnackBar({
  required String message,
  IconData? icon,
  bool isError = false,
}) =>
    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor:
            isError == false ? AppColors.primary : AppColors.redAccount,
        backgroundColor: const Color(0xBB000000).withOpacity(0.85),
        icon: Padding(
          padding: gPadding(left: 2.5.w),
          child: Icon(
            isError == false
                ? icon ?? CupertinoIcons.check_mark_circled_solid
                : icon ?? CupertinoIcons.exclamationmark_circle_fill,
            color: isError == false ? AppColors.primary : AppColors.redAccount,
            size: 25.h,
          ),
        ),
        messageText: Padding(
          padding: gPadding(left: 2.5.w),
          child: TextWidget(
            message,
            style: getTextStyleNormal(
              color: AppColors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
