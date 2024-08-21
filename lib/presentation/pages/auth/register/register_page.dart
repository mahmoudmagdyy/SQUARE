import '/index.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        RegisterBloc bloc = BlocProvider.of<RegisterBloc>(context);
        return Scaffold(
          bottomNavigationBar: BtnWidget(
            title: 'تسجيل الدخول',
            isLoading: bloc.state.requestState == RequestState.loading,
            onTap: () => bloc.add(const OnTapedRegisterEvent()),
            margin: gPadding(right: 15, left: 15, bottom: 15),
          ),
          appBar: const AppBarWidget(title: "إنشاء حساب"),
          body: Container(
            padding: gPadding(right: 15, left: 15, bottom: 5),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthenticationImageWidget(image: AppImages.login),
                    10.height,
                    RegisterForm(bloc: bloc),
                    15.height,
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
