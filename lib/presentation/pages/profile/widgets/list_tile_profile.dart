import '/index.dart';

class ListTileProfile extends StatelessWidget {
  const ListTileProfile({
    super.key,
    required this.title,
    required this.onTap,
    this.image,
    this.myListTile = false,
    this.bgColor,
    this.child,
  });
  final String title;
  final VoidCallback onTap;
  final String? image;
  final bool myListTile;
  final Color? bgColor;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: myListTile ? 65.h : null,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor ?? (myListTile ? AppColors.primary : AppColors.white),
          border: !myListTile ? Border.all(color: AppColors.grey) : null,
          borderRadius: BorderRadius.circular(10).r,
        ),
        child: ListTile(
          leading: Container(
            height: myListTile ? 42.0.h : 32.0.h,
            width: myListTile ? 42.0.h : 32.0.h,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: myListTile
                  ? Border.all(color: AppColors.primaryBackground)
                  : null,
            ),
            child:
                myListTile ? NetworkImageWidget(image!, height: 42.0.h) : child,
          ),
          title: TextWidget(
            title,
            overflow: TextOverflow.ellipsis,
            style: getTextStyle16(
              fontWeight: FontWeight.w600,
              color: title == 'تسجيل الخروج'
                  ? AppColors.textOrang
                  : (myListTile ? AppColors.white : AppColors.black),
            ),
          ),
          trailing: SvgPicture.asset(
            AppImages.arrowLeft,

            height: 16.5.h,
            // ignore: deprecated_member_use
            color: myListTile ? AppColors.white : AppColors.grey2,
          ),
        ),
      ),
    );
  }
}
