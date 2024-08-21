import 'dart:developer';
import 'package:aqarat/presentation/bloc/auth/forget_password/forget_password_bloc.dart';
import '/index.dart';

class VerificationForgetPage extends StatelessWidget {
  VerificationForgetPage({super.key});
  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
      builder: (context, state) {
        ForgetPasswordBloc bloc = context.read<ForgetPasswordBloc>();
        return Scaffold(
          bottomNavigationBar: BtnWidget(
            title: 'ابدأ الآن',
            isLoading: state.requestState == RequestState.loading,
            onTap: () => bloc.add(const OnTapedGoToSetPasswordEvent()),
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
                    TextWidget(
                      "أدخل رمز التحقق الذي أرسلناه إليك للتو على عنوان بريدك الإلكتروني",
                      textAlign: TextAlign.center,
                      style: getTextStyle16(fontWeight: FontWeight.w500),
                    ),
                    45.height,
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 55.h,
                        width: 280.w,
                        child: CustomPinCodeField(
                          onCompleted: (code) {
                            log("onCompleted ------> $code");
                          },
                          onChanged: (value) {
                            bloc.add(ForgetPassOtpEvent(otp: value));
                            log("onChanged ----------------> $value");
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
