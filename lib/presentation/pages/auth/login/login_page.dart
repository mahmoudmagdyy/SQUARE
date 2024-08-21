import '/index.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: sl<LoginBloc>(),
      builder: (context, state) {
        final LoginBloc bloc = sl<LoginBloc>();
        return Scaffold(
          appBar:  AppBarWidget(
            title: "تسجيل الدخول",
            isShowBackButton: false,
             child: GestureDetector(
              onTap: () async{
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isAnonymous', true);
                i<NavigationService>().toNamedAndRemoveUntil(Routes.main);
              },
              child: TextWidget(
                'الدخول كزائر',
                style: getTextStyleSmall(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: gPadding(right: 15, left: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthenticationImageWidget(image: AppImages.login),
                20.height,
                LoginForm(bloc: bloc),
                15.height,
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    child: TextWidget(
                      'هل نسيت كلمة المرور؟',
                      style: getTextStyleNormal(
                        color: AppColors.textGray2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () =>
                        i<NavigationService>().toNamed(Routes.forgetPassword),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    'اليس لديك حساب ؟ ',
                    style: getTextStyleNormal(
                      color: AppColors.textGray2,
                    ),
                  ),
                  GestureDetector(
                    child: TextWidget(
                      'إنشاء حساب',
                      style: getTextStyleNormal(
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () =>
                        i<NavigationService>().toNamed(Routes.register),
                  ),
                ],
              ),
              15.height,
              BtnWidget(
                title: 'تسجيل دخول',
                isLoading: bloc.state.requestState == RequestState.loading,
                onTap: () => bloc.add(const OnTapedLoginEvent()),
                margin: gPadding(left: 15, right: 15, bottom: 15),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BlurryModalProgressWidget extends StatelessWidget {
  const BlurryModalProgressWidget({
    super.key,
    required this.child,
    required this.isLoading,
  });
  final Widget child;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 1.5,
      progressIndicator: const SpinKitFadingCircle(
        color: Color(0xff262E3E),
        size: 40.0,
      ),
      dismissible: false,
      opacity: 0.5,
      color: const Color(0xff262E3E),
      child: child,
    );
  }
}
