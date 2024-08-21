import 'package:aqarat/presentation/bloc/profile/profile_bloc.dart';

import '/index.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.requestState == RequestState.error) {}
      },
      bloc: context.read<ProfileBloc>(),
      builder: (context, state) {
        return Scaffold(
          appBar: const AppBarWidget(title: ''),
          body: SingleChildScrollView(
            child: Padding(
              padding: gPadding(right: 15, left: 15),
              child: Column(
                children: [
                  _buildImageProfile(image: sl<AppPreferences>().getImgUrl ?? ""),
                  10.height,
                  TextWidget(
                    sl<AppPreferences>().getUserName.toString(),
                    style: getTextStyle16(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGray5,
                    ),
                  ),
                  22.height,
                  GestureDetector(
                    onTap: () =>
                        i<NavigationService>().toNamed(Routes.profileEdit),
                    child: BtnWidget(
                      width: 220.w,
                      height: 40.h,
                      radius: 6.r,
                      onTap: null,
                      child: Padding(
                        padding: gPadding(right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              'تعديل بيانات المستخدم',
                              textAlign: TextAlign.center,
                              style: getTextStyleNormal(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            5.width,
                            SvgPicture.asset(
                              AppImages.arrowLeftLine,
                              color: AppColors.white,
                              height: 20.h,
                              width: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  35.height,
                  Padding(
                    padding: gPaddingSymmetric(horizontal: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _icons(AppImages.whatsApp),
                        _icons(AppImages.phone),
                        _icons(AppImages.commuinty),
                        _icons(AppImages.location),
                      ],
                    ),
                  ),
                  25.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _buildImageProfile({String image = ""}) {
    return Container(
      height: 105.h,
      width: 105.h,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 4.0.w),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            image,
          ),
          fit: BoxFit.fill,
          alignment: AlignmentDirectional.center,
        ),
      ),
      // child: NetworkImageWidget(
      //   image,
      //   height: 105.h,
      //   borderRadius: BorderRadius.circular(12.r),
      // ),
    );
  }

  Widget _icons(String image) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        fixedSize: Size(40.h, 40.h),
        shape: RoundedRectangleBorder(borderRadius: 40.radius),
        backgroundColor: AppColors.orange.withOpacity(0.10),
      ),
      onPressed: () {},
      icon: SvgPicture.asset(
        image,
        height: 18.h,
        width: 18.h,
        color: AppColors.orange,
      ),
    );
  }
}
