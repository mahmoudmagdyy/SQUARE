import 'package:aqarat/presentation/bloc/search_for_me_cubit/search_for_me_cubit.dart';
import 'package:aqarat/presentation/pages/sign_in_search_for_me/component/sign_in_saerch_for_me_form.dart';

import '/index.dart';

class SignInSearchForMePage extends StatelessWidget {
  const SignInSearchForMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadAqarBloc, UploadAqarState>(
      listener: (context, state) {},
      bloc: context.read<UploadAqarBloc>(),
      builder: (context, state) {
        final UploadAqarBloc bloc = context.read<UploadAqarBloc>();
        return WillPopScope(
          onWillPop: () async {
            i<UploadAqarBloc>().clearAllData();

            return true;
          },
          child: Scaffold(
            appBar: AppBarWidget(
              title: '',
              onPressed: () {
                bloc.clearAllData();
              },
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: gPaddingSymmetric(horizontal: 15),
                child: Column(
                  children: [
                    TextWidget(
                      "التسجيل في خدمة ابحث لي",
                      style: getTextStyle20(),
                    ),
                    27.height,
                    SignInSaerchForMeForm(bloc: bloc)
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BtnWidget(
              title: AppStrings.next,
              onTap: () {
                SearchForMeCubit searchForMeCubit =
                    BlocProvider.of<SearchForMeCubit>(context);

                if (searchForMeCubit.checkIfUserSelectedSingnInSearchData()) {
                  i<NavigationService>().toNamed(Routes.selectAqarType);
                } else {
                  showSnackBar(
                    message: "برجاء استكمال البيانات المطلوبة",
                    isError: true,
                  );
                }
              },
              margin: gPadding(left: 15, right: 15, bottom: 15),
            ),
          ),
        );
      },
    );
  }
}
