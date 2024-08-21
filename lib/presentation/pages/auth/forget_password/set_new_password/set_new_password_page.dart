import 'package:aqarat/presentation/bloc/auth/forget_password/forget_password_bloc.dart';
import 'package:aqarat/presentation/pages/auth/forget_password/set_new_password/widget/set_new_password_form.dart';
import '/index.dart';

class SetNewPasswordPage extends StatelessWidget {
  const SetNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
      builder: (context, state) {
        ForgetPasswordBloc bloc = context.read<ForgetPasswordBloc>();
        return Scaffold(
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
          bottomNavigationBar: BtnWidget(
            title: 'ارسال',
            isLoading: state.requestState == RequestState.loading,
            onTap: () => bloc.add(const OnTapedResetPasswordEvent()),
            margin: gPadding(left: 15, right: 15, bottom: 15),
          ),
        );
      },
    );
  }
}
