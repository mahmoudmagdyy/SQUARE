import 'package:aqarat/presentation/bloc/auth/forget_password/forget_password_bloc.dart';
import 'package:aqarat/presentation/pages/auth/forget_password/set_new_password/widget/set_new_password_form.dart';
import '/index.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
      builder: (context, state) {
        ForgetPasswordBloc bloc = context.read<ForgetPasswordBloc>();
        return Scaffold(
          bottomNavigationBar: BtnWidget(
            title: 'ارسال',
            isLoading: bloc.state.requestState == RequestState.loading,
            onTap: () => bloc.add(const OnTapedGoToSetOtpEvent()),
            margin: gPadding(left: 15, right: 15, bottom: 15),
          ),
          appBar: const AppBarWidget(title: 'نسيت كلمة المرور'),
          body: Container(
            padding: gPaddingSymmetric(horizontal: 15),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthenticationImageWidget(image: AppImages.login),
                    10.height,
                    ForgetPasswordForm(bloc: bloc),
                    25.height,
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
