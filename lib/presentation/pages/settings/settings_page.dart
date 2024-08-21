import 'package:aqarat/core/widgets/custom_alert_dialog_with_top_icon_widget.dart';
import 'package:aqarat/presentation/bloc/profile/profile_bloc.dart';
import 'package:aqarat/presentation/bloc/settings/settings_bloc.dart';
import 'package:flutter/cupertino.dart';

import '/index.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final SettingsBloc bloc = context.read<SettingsBloc>();

        return BlurryModalProgressWidget(
          isLoading: bloc.state.requestState == RequestState.loading,
          child: Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            appBar: const AppBarWidget(title: "حسابي"),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: gPaddingSymmetric(horizontal: 15),
                  child: Column(
                    children: [
                      30.height,
                      BlocConsumer<ProfileBloc, ProfileState>(
                        listener: (context, state) {},
                        bloc: context.read<ProfileBloc>(),
                        buildWhen: (previous, current) =>
                            current.requestState == RequestState.loaded,
                        builder: (context, state) {
                          return ListTileProfile(
                            title:
                                "${sl<AppPreferences>().getFirstName} ${sl<AppPreferences>().getLastName}",
                            onTap: () async {
                             await context.read<ProfileBloc>();
                              i<NavigationService>().toNamed(Routes.profile);
                            },
                            myListTile: true,
                            image:sl<AppPreferences>().getImgUrl,
                          );
                        },
                      ),
                      30.height,
                      ListTileProfile(
                        title: 'المفضلة',
                        onTap: () =>
                            i<NavigationService>().toNamed(Routes.favorite),
                        child: IconButtonWidget(
                          icon: CupertinoIcons.heart,
                          size: 18,
                          color: AppColors.red,
                          backgroundColor: AppColors.redLight.withOpacity(.35),
                          margin: gPadding(),
                        ),
                      ),
                      25.height,
                      ListTileProfile(
                        title: 'اعلاناتي',
                        onTap: () {
                          i<NavigationService>().toNamed(Routes.myAds);
                        },
                        child: IconButtonWidget(
                          backgroundColor:
                              AppColors.greenIconLight1.withOpacity(.10),
                          image: AppImages.ads,
                          margin: gPadding(),
                        ),
                      ),
                      // 25.height,
                      // ListTileProfile(
                      //   title: 'طلباتي',
                      //   onTap: () {},
                      //   child: IconButtonWidget(
                      //     image: AppImages.talabaty,
                      //     backgroundColor: AppColors.blueLight,
                      //     color: AppColors.blue,
                      //     margin: gPadding(),
                      //   ),
                      // ),
                      // 25.height,
                      // ListTileProfile(
                      //   title: 'طرق الدفع',
                      //   onTap: () {},
                      //   child: IconButtonWidget(
                      //     image: AppImages.wallet,
                      //     backgroundColor:
                      //         AppColors.greenIconLight2.withOpacity(.15),
                      //     margin: gPadding(),
                      //   ),
                      // ),
                      25.height,
                      ListTileProfile(
                        title: 'سياسة الخصوصية',
                        onTap: () {
                          i<NavigationService>().toNamed(Routes.privacy);
                        },
                        child: IconButtonWidget(
                          icon: CupertinoIcons.lock,
                          size: 18,
                          color: AppColors.red,
                          backgroundColor: AppColors.redLight.withOpacity(.35),
                          margin: gPadding(),
                        ),
                      ),
                      25.height,
                      ListTileProfile(
                        title: 'حذف حسابي',
                        // onTap: () => bloc.add(const DeleteAccountEvent()),
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return CustomAlertDialogWithTopIconWidget(
                                button1OnTap: () {
                                  bloc.add(const DeleteAccountEvent());
                                },
                                icon: Icon(
                                  Icons.logout,
                                  size: 42.sp,
                                  color: Colors.white,
                                ),
                                title: 'هل تريد بالتأكيد حذف حسابك ؟',
                                child: Text(
                                  'حذف حسابك',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: IconButtonWidget(
                          image: AppImages.trash,
                          color: AppColors.redAccount,
                          backgroundColor:
                              AppColors.redAccountLight.withOpacity(.35),
                          margin: EdgeInsets.zero,
                        ),
                      ),
                      25.height,
                      ListTileProfile(

                        title: 'تسجيل الخروج',
                        // onTap: () => bloc.add(const LogOutEvent()),
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return CustomAlertDialogWithTopIconWidget(
                                button1OnTap: () {
                                  bloc.add(const LogOutEvent());
                                },
                                icon: Icon(
                                  Icons.logout,
                                  size: 42.sp,
                                  color: Colors.white,
                                ),
                                title: 'هل تريد بالتأكيد تسجيل الخروج ؟',
                                child: Text(
                                  'تسجيل الخروج',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        bgColor: AppColors.redLight2,
                        child: IconButtonWidget(
                          image: AppImages.logout,
                          color: AppColors.textOrang,
                          backgroundColor: AppColors.redLight2,
                          margin: EdgeInsets.zero,
                        ),
                      ),

                      /*  ListTileProfile(
                        title: 'حذف حسابي',
                        onTap: () {},
                        child: IconButtonWidget(
                          image: AppImages.trash,
                          color: AppColors.redAccount,
                          backgroundColor: AppColors.redAccountLight.withOpacity(.35),
                          margin: gPadding(),
                        ),
                      ),
                      24.height,
                      ListTileProfile(
                        title: 'تسجيل الخروج',
                        onTap: () {},
                        // myListTile: true,
                        bgColor: AppColors.redLight2,
                        child: IconButtonWidget(
                          image: AppImages.logout,
                          color: AppColors.textOrang,
                          backgroundColor: AppColors.redLight2,
                          margin: gPadding(),
                        ),
                      ),
                      24.height, */
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
