import '/index.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget(
    this.title, {
    Key? key,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.hintStyle,
    this.isPassword = false,
    this.onChanged,
    this.validator,
    this.textStyle,
    this.prefixIcon,
    this.prefixColor,
    this.suffixIcon,
    this.onPressed,
    this.val,
    this.suffixIconColor,
    this.fillColor = AppColors.greyLight,
    this.textInputAction,
    this.maxLines,
    this.readOnly = false,
    this.callback,
    this.suffixIconWidget,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? title;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final Color? prefixColor;
  final Color? fillColor;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final VoidCallback? onPressed;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? val;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool readOnly;
  final VoidCallback? callback;
  final Widget? suffixIconWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            '$title',
            style: textStyle ??
                getTextStyleNormal(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          8.height,
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: val,
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            obscureText: isPassword,
            onChanged: onChanged,
            validator: validator,
            maxLines: maxLines ?? 1,
            textInputAction: textInputAction,
            cursorColor: AppColors.black,
            style: getTextStyle16(color: AppColors.black),
            decoration: InputDecoration(
              contentPadding:
                  gPadding(right: 15, top: 12.5, left: 15, bottom: 12.5),
              hintText: hintText ?? title,
              hintStyle: hintStyle ??
                  getTextStyleNormal(fontSize: 15, color: AppColors.textGray2),
              border: OutlineInputBorder(
                borderRadius: 6.radius,
                borderSide: BorderSide(width: .5.w, color: AppColors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: 6.radius,
                borderSide: BorderSide(width: .5.w, color: AppColors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: 6.radius,
                borderSide: BorderSide(width: 1.5.w, color: AppColors.primary),
              ),
              filled: true,
              fillColor: fillColor,
              prefixIcon: (prefixIcon != null)
                  ? Icon(
                      prefixIcon,
                      size: 20.h,
                      color: prefixColor ?? AppColors.primary,
                    )
                  : null,
              suffixIcon: suffixIconWidget ??
                  ((suffixIcon != null)
                      ? IconButton(
                          onPressed: onPressed,
                          icon: Icon(
                            suffixIcon,
                            color: suffixIconColor ?? AppColors.textGray2,
                          ),
                        )
                      : null),
            ),
            readOnly: readOnly,
            onTap: callback,
          ),
        ],
      ),
    );
  }
}

List<BoxShadow> boxShadow = [
  const BoxShadow(
    color: AppColors.grey,
    blurRadius: 10,
    offset: Offset(-2, 2), // changes position of shadow
  ),
];
