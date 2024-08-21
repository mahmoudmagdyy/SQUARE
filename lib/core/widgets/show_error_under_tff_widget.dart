import 'package:aqarat/presentation/widgets/app_text/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

class ShowErrorUnderTFFWidget extends StatelessWidget {
  const ShowErrorUnderTFFWidget(
      {super.key, required this.title, required this.condition});
  final bool condition;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: condition,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: 8.h,
          start: 8.h,
        ),
        child: Text(
          title,
          style: getTextStyle16(color: context.theme.colorScheme.error),
        ),
      ),
    );
  }
}
