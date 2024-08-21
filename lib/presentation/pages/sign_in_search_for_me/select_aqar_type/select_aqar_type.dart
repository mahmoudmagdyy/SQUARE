import 'package:aqarat/core/routes/routes.dart';
import 'package:aqarat/core/services/navigation_service.dart';
import 'package:aqarat/core/services/services_locator.dart';
import 'package:aqarat/core/utils/app_strings.dart';
import 'package:aqarat/core/utils/enums.dart';
import 'package:aqarat/core/utils/extension.dart';
import 'package:aqarat/presentation/bloc/search_for_me_cubit/search_for_me_cubit.dart';
import 'package:aqarat/presentation/widgets/app_bar_widget.dart';
import 'package:aqarat/presentation/widgets/app_text/text_styles.dart';
import 'package:aqarat/presentation/widgets/app_text/text_widget.dart';
import 'package:aqarat/presentation/widgets/buttons/btn_widget.dart';
import 'package:aqarat/presentation/widgets/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/search_for_me_bloc/search_for_me_bloc.dart';
import 'component/select_aqar_type_form.dart';

class SelectAqarTypePage extends StatelessWidget {
  const SelectAqarTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchForMeBloc, SearchForMeInitial>(
      listener: (context, state) {},
      bloc: context.read<SearchForMeBloc>(),
      /* buildWhen: (previous, current) => !current.requestState.isLoading, */
      builder: (context, state) {
        final SearchForMeBloc bloc = context.read<SearchForMeBloc>();
        return Scaffold(
          appBar: const AppBarWidget(title: 'اختيار نوع العقار'),
          body: SingleChildScrollView(
            child: Container(
              padding: gPaddingSymmetric(horizontal: 15),
              child: Column(
                children: [
                  10.height,
                  TextWidget(
                    "الان حدد أنواع العقارات التي تهمك",
                    style: getTextStyle16(fontWeight: FontWeight.w600),
                  ),
                  25.height,
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      children: [
                        TextWidget(
                          "نوع العقار",
                          style: getTextStyle18(fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            TextWidget(
                              "بيع",
                              style:
                                  getTextStyle16(fontWeight: FontWeight.w500),
                            ),
                            30.width,
                            TextWidget(
                              "إيجار",
                              style:
                                  getTextStyle16(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  25.height,
                  SelectAqarTypeForm(bloc: bloc),
                ],
              ),
            ),
          ),
          bottomNavigationBar:
              BlocConsumer<SearchForMeCubit, SearchForMeCubitState>(
            listener: (context, state) {
              if (state.requestState == RequestState.loaded) {
                i<NavigationService>().toNamedAndRemoveUntil(Routes.main);
                showSnackBar(
                  message: 'تمت العملية بنجاح',
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              if (state.requestState == RequestState.loading) {
                return BtnWidget(
                  title: 'جاري التحميل ..',
                  onTap: () async {
                    SearchForMeCubit searchForMeCubit =
                        BlocProvider.of<SearchForMeCubit>(context);
                    if (searchForMeCubit.checkIfUserSelectedAqarTypeData()) {
                      await searchForMeCubit.searchForMe();
                    } else {
                      showSnackBar(
                          message: "برجاء استكمال البيانات المطلوبة",
                          isError: true);
                    }
                  },
                  margin: gPadding(left: 15, right: 15, bottom: 15),
                );
              }
              return BtnWidget(
                title: AppStrings.done,
                onTap: () async {
                  SearchForMeCubit searchForMeCubit =
                      BlocProvider.of<SearchForMeCubit>(context);
                  if (searchForMeCubit.checkIfUserSelectedAqarTypeData()) {
                    await searchForMeCubit.searchForMe();
                  } else {
                    showSnackBar(
                        message: "برجاء استكمال البيانات المطلوبة",
                        isError: true);
                  }
                },
                margin: gPadding(left: 15, right: 15, bottom: 15),
              );
            },
          ),
        );
      },
    );
  }
}
