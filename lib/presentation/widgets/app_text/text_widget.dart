import '/index.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    Key? key,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.overflow,
    this.softWrap,
    this.style,
    /* this.fontSize,
    this.color = AppColors.black,
    this.letterSpacing,
    this.fontWeight,
    this.fontFamily,
    this.decoration,
    this.wordSpacing,
    this.hei, */
  }) : super(key: key);
  final String text;
  final bool? softWrap;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? style;
  final TextAlign? textAlign;

  /* final double? letterSpacing;
  final double? hei;
  final double? fontSize;
  final TextDecoration? decoration;
  final String? fontFamily;
  final Color? color;
  final FontWeight? fontWeight;
  final double? wordSpacing; */
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: style ?? getTextStyleNormal(),
    );
  }
}
