import 'package:aqarat/index.dart';
import 'package:get/get_utils/get_utils.dart';

class TextFormFieldWithTitleWidget extends StatelessWidget {
  const TextFormFieldWithTitleWidget({
    super.key,
    required this.title,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.textCapitalization,
    this.autofocus,
    this.obscureText,
    this.suffix,
    this.prefix,
    this.enabled,
    this.hint,
    this.validator,
    this.filled,
    this.fillColor,
    this.onFieldSubmitted,
    this.errorWidget,
    this.inputFormatters,
    this.textColor,
    this.maxLines = 1,
  });
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final bool? obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enabled;
  final String? hint;
  final String? Function(String?)? validator;
  final bool? filled;
  final Color? fillColor;
  final Color? textColor;
  final void Function(String)? onFieldSubmitted;
  final Widget? errorWidget;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getTextStyle18(
            color: AppColors.black,
          ),
        ),
        10.verticalSpace,
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          autofocus: autofocus ?? false,
          enabled: enabled ?? true,
          onFieldSubmitted: onFieldSubmitted,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          focusNode: focusNode,
          validator: validator,
          inputFormatters: inputFormatters,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            filled: filled,

            fillColor: AppColors.baseColor.withOpacity(0.5),
            iconColor: context.theme.colorScheme.shadow,
            prefixIconColor: context.theme.colorScheme.shadow,
            suffixIconColor: context.theme.hintColor,

            prefixIcon: prefix,

            suffixIcon: suffix,
            // suffix: suffix,
            hintText: hint,
            hintStyle: getTextStyle18(
              color: AppColors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: AppColors.grey,
              ),
            ),
          ),
        ),
        errorWidget ?? const SizedBox.shrink(),
      ],
    );
  }
}

String getStatus(int status) {
  if (status == 1) {
    return 'مقبولة';
  } else if (status == 2) {
    return 'مرفوضة';
  } else {
    return 'قيد المراجعة';
  }
}

Color getColor(int status) {
  if (status == 1) {
    return AppColors.primary;
  } else if (status == 2) {
    return AppColors.red;
  } else {
    return AppColors.primary;
  }
}
