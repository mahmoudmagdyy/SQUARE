import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertDialogWithTopIconWidget extends StatelessWidget {
  const CustomAlertDialogWithTopIconWidget({
    super.key,
    required this.title,
    required this.button1OnTap,
    required this.icon,
    this.style,
    required this.child,
  });
  final String title;

  final VoidCallback button1OnTap;
  final Widget icon;
  final TextStyle? style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (1.sh / 15).verticalSpace,
              Text(
                title,
                style: style ??
                    TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF9BA9B9),
                    ),
              ),
              32.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        onPressed: button1OnTap,
                        child: child,
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          backgroundColor: const Color(0xFFD0DEEB),
                        ),
                        onPressed: () {
                          
                          Navigator.of(context).maybePop();
                        },
                        child: Text(
                          'إلغاء',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF9BA9B9),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              16.verticalSpace
            ],
          ),
          Align(
            alignment: AlignmentDirectional.topCenter,
            heightFactor: 1,
            child: Container(
              padding: EdgeInsets.all(8.sp),
              alignment: AlignmentDirectional.center,
              width: 80.w,
              height: 80.h,
              transform: Matrix4.translationValues(0, -40.h, 0),
              decoration: const ShapeDecoration(
                color: Color(0xFFFF0000),
                shape: OvalBorder(
                  side: BorderSide(
                    width: 3,
                    color: Color(0xFFFCACAC),
                  ),
                ),
              ),
              child: icon,
            ),
          ),
        ],
      ),
    );
  }
}
