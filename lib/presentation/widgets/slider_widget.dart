import 'package:aqarat/index.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.images,
    required this.onPageChanged,
    required this.currentIndex,
    this.height,
  });
  final List<dynamic> images;
  final Function(int, CarouselPageChangedReason) onPageChanged;
  final int currentIndex;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: height ?? 145.h,
            viewportFraction: 1,
            initialPage: 0,
            reverse: false,
            autoPlay: true,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.ease,
            onPageChanged: onPageChanged,
          ),
          items: List.generate(images.length, (index) {
            return Padding(
              padding: gPadding(right: 15, left: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: 6.radius,
                ),
                child: NetworkImageWidget(
                  images[index].image,
                  height: height,
                  borderRadius: 6.radius,
                  width: ScreenUtil().screenWidth,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
        10.height,
        SmoothIndicator(
          count: images.length,
          index: currentIndex,
          defaultColor: AppColors.primary,
          color: AppColors.primary,
        ),
      ],
    );
  }
}
