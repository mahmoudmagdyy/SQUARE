import 'package:aqarat/index.dart';
import 'package:flutter/cupertino.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget(
    this.image, {
    Key? key,
    required this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.iconSize,
  }) : super(key: key);
  final String? image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? ScreenUtil().screenWidth,
      child: CachedNetworkImage(
        imageUrl: image ?? AppImages.errorImage,
        placeholder: (context, url) =>
             Center(
              child: SpinKitFadingCircle(
                color: AppColors.grey2,
                size: 35.h,
              ),
            ),
        /*  progressIndicatorBuilder: (context, url, progress) => Center(
          child: SizedBox(
            height: 20.h,
            width: 20.h,
            child: CircularProgressIndicator(
              value: progress.progress,
              strokeWidth: 3.0,
            ),
          ),
        ), */
        imageBuilder: (context, imageProvider) => Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              filterQuality: FilterQuality.high,
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          CupertinoIcons.exclamationmark_circle,
          color: AppColors.redAccount,
          size: 25.h,
        ),
      ),
    );
  }
}
