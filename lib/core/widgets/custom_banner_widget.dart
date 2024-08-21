import '/index.dart';

class CustomBannerWidget extends StatelessWidget {
  const CustomBannerWidget({
    super.key,
    this.image,
    this.showDots = false,
  });

  final String? image;
  final bool showDots;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120.h,
          width: 300.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
            image: image != null
                ? null
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImages.onboarding1),
                  ),
          ),
          child: Image.network(image ?? '', fit: BoxFit.cover),
        ),
        if (showDots) ...[
          Positioned(
            bottom: 10.h,
            child: Container(
              padding: gPaddingSymmetric(horizontal: 130),
              child: const SmoothIndicator(
                count: 3,
                index: 0,
                color: AppColors.white,
                defaultColor: AppColors.primary,
                ads: true,
              ),
            ),
          ),
          Positioned(
            bottom: 8.h,
            left: 11.h,
            child: TextWidget(
              "1/11",
              style: getTextStyleSimSmall(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
