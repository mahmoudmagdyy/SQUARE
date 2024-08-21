import 'dart:developer';

import '/index.dart';

class VerificationRegisterPage extends StatelessWidget {
  const VerificationRegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        RegisterBloc bloc = context.read<RegisterBloc>();
        return Scaffold(
          bottomNavigationBar: BtnWidget(
            title: 'ابدأ الآن',
            onTap: () => bloc.add(const OnTapedSetOtpRegisterEvent()),
            margin: gPadding(left: 15, right: 15, bottom: 15),
          ),
          appBar: const AppBarWidget(title: 'رمز التحقق'),
          body: Container(
            width: 375.w,
            padding: gPaddingSymmetric(horizontal: 15),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AuthenticationImageWidget(
                        image: AppImages.verificationCode),
                    10.height,
                    TextWidget(
                      "أدخل رمز التحقق الذي أرسلناه إليك للتو على عنوان بريدك الإلكتروني",
                      textAlign: TextAlign.center,
                      style: getTextStyle16(fontWeight: FontWeight.w500),
                    ),
                    45.height,
                    // pain code
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 55.h,
                        width: 280.w,
                        child: CustomPinCodeField(
                          onCompleted: (code) {
                            log("OnCompleted ------> $code");
                            // controller.onTappedVerifyCode(email, code);
                          },
                          onChanged: (value) {
                            bloc.add(OtpRegisterEvent(otp: value));
                            log("OnChanged -------> $value");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
