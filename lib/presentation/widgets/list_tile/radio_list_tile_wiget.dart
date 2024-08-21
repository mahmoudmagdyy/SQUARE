import '/index.dart';

class RadioListTileWiget extends StatelessWidget {
  const RadioListTileWiget({
    super.key,
    this.icon,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.height,
    this.width,
    this.margin,
  });
  final IconData? icon;
  final String title;
  final Object value;
  final Object groupValue;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final void Function(Object?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height?.h,
      width: width?.w,
      alignment: AlignmentDirectional.center,
      child: RadioListTile(
        dense: true,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        
        title: icon != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Icon(icon, color: AppColors.secondary),
                    1.height,
                    TextWidget(
                      title,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            : TextWidget(
                title,
                style: getTextStyleNormal(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}
