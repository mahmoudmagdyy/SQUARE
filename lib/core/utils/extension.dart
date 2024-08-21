import '/index.dart';

gPadding({
  double left = 0,
  double top = 0,
  double right = 0,
  double bottom = 0,
}) =>
    EdgeInsetsDirectional.only(
      end: left.w,
      top: top.h,
      start: right.w,
      bottom: bottom.h,
    );

gPaddingSymmetric({
  double horizontal = 0,
  double vertical = 0,
}) =>
    EdgeInsets.symmetric(
      vertical: vertical.h,
      horizontal: horizontal.w,
    );

extension SizedBoxExtension on num {
  SizedBox get height => SizedBox(height: toDouble().h);
  SizedBox get width => SizedBox(width: toDouble().w);
}

extension BorderRadiusExtension on num {
  BorderRadius get radius => BorderRadius.circular(toDouble().r);
}
