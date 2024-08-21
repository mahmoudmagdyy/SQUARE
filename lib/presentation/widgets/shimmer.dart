import 'package:aqarat/index.dart';
import 'package:shimmer/shimmer.dart';

class TitleCardShimmer extends StatelessWidget {
  const TitleCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          direction: ShimmerDirection.rtl,
          baseColor: AppColors.baseColor,
          highlightColor: AppColors.highlightColor,
          child: Container(
            height: 20.h,
            width: ScreenUtil().screenWidth * 0.25,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.6),
              borderRadius: 1.0.radius,
            ),
          ),
        ),
        7.5.height,
        Shimmer.fromColors(
          direction: ShimmerDirection.rtl,
          baseColor: AppColors.baseColor,
          highlightColor: AppColors.highlightColor,
          child: Container(
            height: 50.h,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.6),
              borderRadius: 4.radius,
            ),
          ),
        )
      ],
    );
  }
}

class SliderShimmer extends StatelessWidget {
  const SliderShimmer({super.key, this.height});
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.rtl,
      baseColor: AppColors.baseColor,
      highlightColor: AppColors.highlightColor,
      child: Container(
        height: height ?? 145.h,
        margin: gPadding(right: 15, left: 15, bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.6),
          borderRadius: 8.radius,
        ),
      ),
    );
  }
}

class ImageTitleShimmer extends StatelessWidget {
  const ImageTitleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.rtl,
      baseColor: AppColors.baseColor,
      highlightColor: AppColors.highlightColor,
      child: Container(
        height: 130.h,
        width: 85.w,
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.6),
          borderRadius: 8.radius,
        ),
      ),
    );
  }
}

class ListProductsShimmer extends StatelessWidget {
  const ListProductsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: gPadding(right: 15, left: 15, bottom: 35),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          direction: ShimmerDirection.rtl,
          baseColor: AppColors.baseColor,
          highlightColor: AppColors.highlightColor,
          child: Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.6),
              borderRadius: 8.radius,
            ),
          ),
        );
      },
      itemCount: 5,
      separatorBuilder: (context, index) => 15.height,
    );
  }
}
