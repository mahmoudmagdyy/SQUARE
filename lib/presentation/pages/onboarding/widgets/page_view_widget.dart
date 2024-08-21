import '/index.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });
  final String image;
  final String title;
  final String subTitle;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 10.w,
            left: 10.w,
            child: _buildImageWelcome(image),
          ),
          Column(
            children: [
              _buildHeaderWelcome(onTap: onTap),
              30.height,
              /// Title && Sub title
              _buildTitleSubTitle(title, subTitle),
            ],
          ),
        ],
      );
}

Container _buildHeaderWelcome({required void Function() onTap}) => Container(
      margin: gPadding(right: 15, top: 10, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50.h,
            width: 55.w,
            child: SvgPicture.asset(AppImages.logo, fit: BoxFit.cover),
          ),
          BtnWidget(
            title: "تخطى",
            height: 35,
            width: 95,
            radius: 100,
            backgroundColor: const Color(0xFFDFDFDF),
            style: getTextStyleSimSmall(fontWeight: FontWeight.w600),
            titleColor: AppColors.textColor,
            onTap: onTap,
          ),
        ],
      ),
    );

Container _buildTitleSubTitle(String title, String subTitle) => Container(
      alignment: Alignment.centerRight,
      padding: gPadding(right: 15  ,left: 15),
      child: TextWidget(
        "$title\n$subTitle",
        style: getTextStyleLarge(),
        textAlign: TextAlign.start,
      ),
    );

Container _buildImageWelcome(String image) => Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: 40.radius,
      ),
      margin: gPadding(bottom: 10.0),
      child: Image.asset(image, fit: BoxFit.fill),
    );
