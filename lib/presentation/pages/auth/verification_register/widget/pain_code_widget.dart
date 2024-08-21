import '/index.dart';

class CustomPinCodeField extends StatelessWidget {
  const CustomPinCodeField({
    Key? key,
    this.onCompleted,
    required this.onChanged,
  }) : super(key: key);
  final void Function(String)? onCompleted;
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PinCodeTextField(
        // autoFocus: true,
        //enableActiveFill: true,
        appContext: context,
        onCompleted: onCompleted,
        onChanged: onChanged,
        cursorColor: AppColors.primary,
        keyboardType: TextInputType.number,
        length: 4,
        obscureText: !true,
        animationType: AnimationType.fade,
        textStyle: TextStyle(color: AppColors.primary, fontSize: 25.sp),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8).r,
          fieldHeight: 50.h,
          fieldWidth: 50.h,
          borderWidth: 1,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.grey,
          inactiveFillColor: AppColors.grey,
          activeFillColor: AppColors.grey,
          selectedColor: AppColors.primary,
          selectedFillColor: AppColors.white,
        ),
        // animationDuration: const Duration(milliseconds: 200),
        //  backgroundColor: kTransparentColor,
      ),
    );
  }
}
