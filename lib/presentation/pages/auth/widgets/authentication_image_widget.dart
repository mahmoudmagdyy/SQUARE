import '/index.dart';

Center authImg(String img, {double? hi, double? we}) => Center(
      child: SizedBox(
        height: (hi ?? 273).h,
        width: (we ?? 273).h,
        child: SvgPicture.asset(img),
      ),
    );

class AuthenticationImageWidget extends StatelessWidget {
  const AuthenticationImageWidget(
      {super.key, required this.image, this.height, this.width});
  final String image;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: (height ?? 250).h,
        width: (width ?? 250).h,
        child: SvgPicture.asset(image),
      ),
    );
  }
}
