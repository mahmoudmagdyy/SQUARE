import 'package:aqarat/presentation/bloc/profile/profile_bloc.dart';
import 'package:aqarat/presentation/pages/profile_edit/component/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '/index.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.requestState == RequestState.loaded) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        ProfileBloc bloc = context.read<ProfileBloc>();
        return Scaffold(
          bottomNavigationBar: BtnWidget(
            title: 'حفظ',
            isLoading: state.requestState == RequestState.loading,
            onTap: ()async {
             await {bloc.add(const UpdateProfileEvent())};
              Get.offAll(const LoginPage(), );
             isLoading: state.requestState == RequestState.loaded;
            },
            margin: gPadding(right: 15, left: 15, bottom: 15),
          ),
          appBar: const AppBarWidget(title: 'تعديل الملف الشخصي'),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: gPaddingSymmetric(horizontal: 15),
                child: Column(
                  children: [
                    30.height,
                    _buildImageProfile(
                      image: sl<AppPreferences>().getImgUrl,
                      onTap: () {
                        context.read<ProfileBloc>().pickImage();
                      },
                    ),
                    35.height,
                    EditProfileForm(bloc: bloc),
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

  Stack _buildImageProfile({String? image, VoidCallback? onTap}) {
    return Stack(
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Container(
              height: 105.h,
              width: 105.h,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 4.w),
                shape: BoxShape.circle,
              ),
              child: state.image == null
                  ? NetworkImageWidget(
                      image!,
                      height: 105.h,
                    )
                  : Container(
                      height: 105.h,
                      width: 105.h,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.file(
                        state.image!,
                        height: 105.h,
                        fit: BoxFit.fill,
                      ),
                    ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: gPaddingSymmetric(horizontal: 8, vertical: 8),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.textGray4,
              ),
              child: const Icon(CupertinoIcons.camera),
            ),
          ),
        )
      ],
    );
  }
}
