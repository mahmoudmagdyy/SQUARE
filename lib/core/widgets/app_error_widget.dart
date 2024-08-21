import 'package:aqarat/presentation/widgets/app_text/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.message, required this.onTap});
  final String message;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
            size: 120.sp,
          ),
          32.verticalSpace,
          Text(
            message ?? 'Error',
            textAlign: TextAlign.center,
            style: getTextStyle16(
              color: context.theme.shadowColor,
            ),
          ),
          32.verticalSpace,
          Padding(
            padding: EdgeInsets.all(60.sp),
            child: ElevatedButton(
              onPressed: onTap,
              child: const Text('اعادة المحاولة'),
            ),
          ),
        ],
      ),
    );
  }
}
