import '/index.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BtnWidget(
        title: 'ابدأ الآن',
        onTap: () => Navigator.pushNamed(
          context,
          Routes.errorVerificationScreen,
        ),
        margin: gPadding(left: 20, right: 20, bottom: 32),
      ),
      body: Container(
        width: 375.w,
        padding: gPaddingSymmetric(horizontal: 20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                appbar(
                  tit: 'رمز التحقق',
                  style: getTextStyleLarge(),
                  leading: arrowBackIcon(),
                ),
                authImg(AppImages.verificationCode, hi: 355, we: 355),
                TextWidget(
                  "أدخل رمز التحقق الذي أرسلناه إليك للتو على عنوان بريدك الإلكتروني",
                  textAlign: TextAlign.center,
                  style: getTextStyle16(fontWeight: FontWeight.w500),
                ),
                46.height,
                // pain code
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 57.h,
                    width: 280.w,
                    child: CustomPinCodeField(
                      onCompleted: (code) {
                        debugPrint("-------Codddde------> $code");
                        // controller.onTappedVerifyCode(email, code);
                      },
                      onChanged: (value) {
                        // controller.val = value;
                        debugPrint("----------------> $value");
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
  }
}
