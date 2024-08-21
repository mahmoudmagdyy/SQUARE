import '/index.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final String? trailing;
  final Widget? trailingWidget;
  final IconData? icon;

  const ListTileWidget({
    super.key,
    required this.title,
    this.trailing,
    this.trailingWidget,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: icon != null ? Icon(icon) : null,
      title: TextWidget(
        title,
        style: getTextStyleNormal(
            color: AppColors.textGray22, fontWeight: FontWeight.w500),
      ),
      trailing: trailingWidget ??
          (trailing != null
              ? TextWidget(
                  trailing!,
                  style: getTextStyleNormal(color: AppColors.textGray1),
                )
              : null),
    );
  }
}
