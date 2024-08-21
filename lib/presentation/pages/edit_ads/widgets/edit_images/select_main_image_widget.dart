import 'package:aqarat/index.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';
import 'package:aqarat/presentation/pages/edit_ads/widgets/edit_images/show_image_gallery.dart';

class SelectMainImageWidget extends StatelessWidget {
  const SelectMainImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: gPadding(right: 15, left: 15),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppImages.addVideo,
                height: 25.h,
                width: 20.h,
              ),
              10.width,
              TextWidget(
                'الصورة الاساسية للعقار',
                style: getTextStyle16(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          22.height,
          Padding(
            padding: gPadding(right: 45, left: 45),
            child: TextWidget(
              "يمكنك إضافة صورة واحده رئيسيه للعقار",
              textAlign: TextAlign.center,
              style: getTextStyleNormal(
                color: AppColors.black.withOpacity(.46),
              ),
            ),
          ),
          12.height,
          BtnWidget(
            title: "أضف صور رئيسيه",
            height: 35,
            width: 305,
            style: getTextStyle16(color: AppColors.white),
            onTap: () {
              if (context.read<EditMyAdCubit>().state.property?.firstImage ==
                  null) {
                showImageGallery(
                  context: context,
                  cameraCallback: () {
                    context.read<EditMyAdCubit>().selectNewFirstImage(true);
                  },
                  galleryCallback: () {
                    context.read<EditMyAdCubit>().selectNewFirstImage(false);
                  },
                );
              } else {
                showSnackBar(
                  message:
                      "يوجد بالفعل صورة رئيسيه , يمكنك حذفها اولا حتي تسطتيع اضافة صورة جديده",
                  isError: true,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
