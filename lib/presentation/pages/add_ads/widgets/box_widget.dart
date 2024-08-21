import 'package:aqarat/index.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    super.key,
    required this.title,
    // required this.bloc,
    required this.callback,
    this.backgroundColor,
    this.titleColor,
  });
  final String title;
  // final UploadAqarBloc bloc;
  final VoidCallback callback;
  final Color? backgroundColor;
  final Color? titleColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: 45.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: backgroundColor == null
              ? Border.all(color: AppColors.containerBackground)
              : null,
          borderRadius: 8.radius,
        ),
        alignment: Alignment.center,
        child: TextWidget(
          title,
          style: getTextStyleSmall(
            fontWeight: FontWeight.w500,
            color: titleColor ?? AppColors.textColor3.withOpacity(.75),
          ),
        ),
      ),
    );
  }
}
