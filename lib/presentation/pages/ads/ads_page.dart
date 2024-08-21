import 'package:flutter/cupertino.dart';

import '/index.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "الإعلانات",
        child: Container(
          height: 35.h,
          width: 35.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(.2),
          ),
          child: const Icon(CupertinoIcons.heart, color: AppColors.primary),
        ),
      ),
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            10.height,
            _buildAdsTypeContent(),
            10.height,
            _buildSelectedPlaceContent(),
            AdsContainer(
              onTap: () => i<NavigationService>().toNamed(Routes.adsDetails),
            ),
            AdsContainer(
              onTap: () => i<NavigationService>().toNamed(Routes.adsDetails),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSelectedPlaceContent() {
    return Padding(
      padding: gPaddingSymmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(AppImages.trash, height: 20.h),
          10.width,
          buildIconBtn(AppImages.cancel, "النزهة"),
        ],
      ),
    );
  }

  Container _buildAdsTypeContent() {
    return Container(
      height: 35.h,
      alignment: Alignment.center,
      child: ListView.builder(
        padding: gPadding(right: 15, left: 15),
        itemBuilder: (context, index) => _buildTapBarContent(
          "كل الطلبات",
          onTap: () {},
        ),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  GestureDetector _buildTapBarContent(String title,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.center,
        margin: gPadding(left: 5, right: 5),
        padding: gPadding(left: 5, right: 5),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.primary,
          borderRadius: 8.radius,
        ),
        child: TextWidget(
          title,
          style: getTextStyleNormal(
              fontWeight: FontWeight.w500, color: AppColors.white),
        ),
      ),
    );
  }
}

Container buildIconBtn(
  String img,
  String tit, {
  double? width,
  double? imgHeight,
  TextStyle? style,
  EdgeInsetsGeometry? margin,
}) =>
    Container(
      alignment: Alignment.centerRight,
      width: width,
      margin: margin,
      padding: gPadding(/* lf: 14, ri: 8,  */ top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: AppColors.containerBackground,
        borderRadius: BorderRadius.circular(16).r,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              8.width,
              SvgPicture.asset(img, height: (imgHeight ?? 8).h),
            ],
          ),
          8.width,
          Row(
            children: [
              TextWidget(
                tit,
                style: style ?? getTextStyleNormal(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              8.width,
            ],
          ),
        ],
      ),
    );

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    this.backgroundColor,
    this.color,
    this.image,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
    this.size,
    this.icon = CupertinoIcons.location_solid,
  });
  final Color? backgroundColor;
  final String? image;
  final double? height;
  final Color? color;
  final double? size;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: (height)?.h,
        width: (height)?.w,
        alignment: Alignment.center,
        margin: padding,
        padding: image != null
            ? margin ?? gPaddingSymmetric(horizontal: 10, vertical: 10)
            : margin ?? gPaddingSymmetric(horizontal: 7.5, vertical: 7.5),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary.withOpacity(.2),
          shape: BoxShape.circle,
        ),
        child: image == null
            ? Icon(icon, color: color ?? AppColors.primary, size: (size)?.h)
            : SvgPicture.asset(
                image!,
                color: color ?? AppColors.primary,
                height: size?.h,
                width: size?.h,
              ),
      ),
    );
  }
}
