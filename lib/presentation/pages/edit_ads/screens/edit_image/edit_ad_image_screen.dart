import 'dart:developer';

import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_images/additional_image_widget.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_images/main_image_widget.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_images/select_addition_image_widget.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_images/select_main_image_widget.dart';
import 'package:aqarat/presentation/widgets/ads_details/edit_ads_button_widget.dart';

class EditMyAdImageScreen extends StatefulWidget {
  const EditMyAdImageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditMyAdImageScreen> createState() => _EditMyAdImageScreenState();
}

class _EditMyAdImageScreenState extends State<EditMyAdImageScreen> {
  @override
  void dispose() {
    log('', error: 'Edit My AD Close');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<EditMyAdCubit>().deleteAllImage();
        return true;
      },
      child: Scaffold(
        appBar: AppBarWidget(
          title: "تعديل اعلان",
          onPressed: context.read<EditMyAdCubit>().deleteAllImage,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: TextWidget(
                    "إضافة الصور",
                    textAlign: TextAlign.center,
                    style: getTextStyle20(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                32.verticalSpace,
                const SelectMainImageWidget(),
                10.height,
                const SelectAdditionImageWidget(),
                24.verticalSpace,
                TextWidget(
                  'الصورة الاساسية',
                  style: getTextStyle18(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                24.verticalSpace,
                const MainImageWidget(),
                24.verticalSpace,
                TextWidget(
                  'الصور الاضافية',
                  style: getTextStyle18(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                24.verticalSpace,
                const AdditionalImageWidget(),
                25.height,
                BlocBuilder<EditMyAdCubit, EditMyAdState>(
                  builder: (context, state) {
                    return EditAdsButtonWidget(
                      title: "التالي",
                      onTap: () {
                        if (state.property?.firstImage == null) {
                          showSnackBar(
                            message: 'يجب أضافة صورة رئيسيه',
                            isError: true,
                          );
                        } else if (state.property?.images == null ||
                            state.property!.images.isEmpty) {
                          showSnackBar(
                            message: 'يجب اختيار علي الاقل صورة واحده اضافية',
                            isError: true,
                          );
                        } else {
                          sl<NavigationService>()
                              .toNamed(Routes.editAqarDetails);
                        }
                      },
                    );
                  },
                ),
                16.verticalSpace,
                EditAdsButtonWidget(
                  title: "رجوع",
                  bgColor: Colors.white,
                  textColor: AppColors.primary,
                  onTap: () {
                    sl<NavigationService>().pop();
                  },
                ),
                25.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
