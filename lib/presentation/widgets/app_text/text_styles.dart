import '/index.dart';

TextStyle getTextStyleLarge({
  double? letterSpacing,
  double? hei,
  TextDecoration? decoration,
  Color color = AppColors.black,
  String? fontFamily,
  double? wordSpacing,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      fontSize: 24.sp,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: hei,
      letterSpacing: letterSpacing,
      decoration: decoration,
      color: color,
      wordSpacing: wordSpacing,
      fontFamily: fontFamily,
    );

TextStyle getTextStyle20({
  double? letterSpacing,
  double? hei,
  TextDecoration? decoration,
  Color color = AppColors.black,
  String? fontFamily,
  double? wordSpacing,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      fontSize: 20.sp,
      fontWeight: fontWeight ?? FontWeight.normal,
      height: hei,
      letterSpacing: letterSpacing,
      decoration: decoration,
      color: color,
      wordSpacing: wordSpacing,
      fontFamily: fontFamily,
    );

TextStyle getTextStyle18({
  double? letterSpacing,
  double? height,
  TextDecoration? decoration,
  Color color = AppColors.black,
  String? fontFamily,
  double? wordSpacing,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      fontSize: 18.sp,
      fontWeight: fontWeight ?? FontWeight.normal,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      color: color,
      wordSpacing: wordSpacing,
      fontFamily: fontFamily,
    );

TextStyle getTextStyle16({
  double? letterSpacing,
  double? height,
  TextDecoration? decoration,
  Color color = AppColors.black,
  String? fontFamily,
  double? wordSpacing,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      fontSize: 16.sp,
      fontWeight: fontWeight ?? FontWeight.normal,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      color: color,
      wordSpacing: wordSpacing,
      fontFamily: fontFamily,
      decorationColor: color,
    );

TextStyle getTextStyleNormal({
  double? letterSpacing,
  double? height,
  String? fontFamily,
  TextDecoration? decoration,
  Color color = AppColors.black,
  double? wordSpacing,
  double? fontSize,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: height,
      color: color,
      wordSpacing: wordSpacing,
      fontFamily: fontFamily,
    );

TextStyle getTextStyleSmall({
  double? letterSpacing,
  double? hei,
  String? fontFamily,
  TextDecoration? decoration,
  Color? color,
  double? wordSpacing,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontSize: 14.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: hei,
      color: color ?? AppColors.textColor.withOpacity(.5),
      wordSpacing: wordSpacing,
      fontFamily: fontFamily,
    );

TextStyle getTextStyleSimSmall({
  double? letterSpacing,
  double? height,
  String? fontFamily,
  TextDecoration? decoration,
  Color color = AppColors.black,
  double? wordSpacing,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontSize: 12.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: height,
      color: color,
      wordSpacing: wordSpacing,
      fontFamily: fontFamily,
    );
TextStyle getTextStyleTin({
  double? letterSpacing,
  double? height,
  String? fontFamily,
  TextDecoration? decoration,
  Color color = AppColors.textGray1,
  double? wordSpacing,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontSize: 10.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: height,
      color: color,
      wordSpacing: wordSpacing,
      fontFamily: fontFamily,
    );
