import '/index.dart';

class SmoothIndicatorAds extends StatelessWidget {
  const SmoothIndicatorAds({
    super.key,
    required this.length,
    required this.index, 
  });

  final int length;
  final int index; 
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 10.h,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              right: 0,
              left: 0,
              child: Container(
                height: 10.h,
                width: (length * 25).h,
                decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(10).r,
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.topRight,
                child: AnimatedContainer(
                  width: index * 70.h,
                  height: 10.h,
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeInOutCubicEmphasized,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.horizontal(
                      right: const Radius.circular(10).r,
                      left: const Radius.circular(10).r,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
