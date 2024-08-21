import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '/index.dart';

class AddAdsImagesPage extends StatefulWidget {
  const AddAdsImagesPage({super.key});

  @override
  State<AddAdsImagesPage> createState() => _AddAdsImagesPageState();
}

class _AddAdsImagesPageState extends State<AddAdsImagesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAqarBloc, UploadAqarState>(
      builder: (context, state) {
        final UploadAqarBloc bloc = context.read<UploadAqarBloc>();
        return Scaffold(
          appBar: const AppBarWidget(title: AppStrings.addAd),
          body: SingleChildScrollView(
            padding: gPadding(right: 15, left: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                25.height,
                TextWidget(
                  "إضافة الصور",
                  style: getTextStyle16(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                25.height,
                const SmoothIndicatorAds(length: 3, index: 2),
                25.height,
                _body(context, bloc),
                10.height,
              ],
            ),
          ),
          bottomNavigationBar: BtnWidget(
            title: AppStrings.next,
            margin: gPadding(right: 15, left: 15, bottom: 15),
            onTap: () => (bloc.state.images.isEmpty)
                ? showSnackBar(
                    message: "برجاء استكمال البيانات المطلوبة", isError: true)
                : i<NavigationService>().toNamed(Routes.aqarDetailsPage),
          ),
        );
      },
    );
  }

  void showImageGallery({
    required BuildContext context,
    required UploadAqarBloc bloc,
    isMultiChoose = false,
    isFirstImage = false,
  }) =>
      showModalBottomSheet(
        context: context,
        routeSettings: const RouteSettings(name: "show_image_gallery"),
        backgroundColor: AppColors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        builder: (BuildContext context) {
          ImagePicker picker = ImagePicker();

          return Padding(
            padding: gPaddingSymmetric(horizontal: 10, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bottomSheetListTile(
                  'الكاميرا',
                  icon: CupertinoIcons.photo_camera,
                  callback: () async {
                    List<File> images = [];

                    if (isFirstImage) {
                      XFile? res =
                          await picker.pickImage(source: ImageSource.camera);
                      images.add(File(res!.path));
                      if (images.length == 1) {
                        showSnackBar(
                          message: "برجاء اختيار صورة واحده فقط",
                          isError: true,
                        );
                      } else {
                        bloc.pickFirstImage(images.first);
                      }
                    } else {
                      XFile? res =
                          await picker.pickImage(source: ImageSource.camera);
                      images.add(File(res!.path));
                      bloc.add(GetImagesAqarEvent(images: images));
                    }
                  },
                ),
                bottomSheetListTile(
                  'معرض الصور',
                  image: AppImages.addImage,
                  callback: () async {
                    List<File> images = [];
                    if (isFirstImage) {
                      if (isMultiChoose == true) {
                        List<XFile>? result = await picker.pickMultiImage();
                        List<File> images = result
                            .map<File>((element) => File(element.path))
                            .toList();

                        if (images.length == 1) {
                          showSnackBar(
                            message: "برجاء اختيار صورة واحده فقط",
                            isError: true,
                          );
                        } else {
                          bloc.pickFirstImage(images.first);
                        }
                        // bloc.add(GetImagesAqarEvent(images: images));
                      } else {
                        XFile? res =
                            await picker.pickImage(source: ImageSource.gallery);
                        images.add(File(res!.path));
                        bloc.pickFirstImage(images.first);
                        // bloc.add(GetImagesAqarEvent(images: images));
                      }
                    } else {
                      if (isMultiChoose == true) {
                        List<XFile>? result = await picker.pickMultiImage();
                        List<File> images = result
                            .map<File>((element) => File(element.path))
                            .toList();
                        bloc.add(GetImagesAqarEvent(images: images));
                      } else {
                        XFile? res =
                            await picker.pickImage(source: ImageSource.gallery);
                        images.add(File(res!.path));
                        bloc.add(GetImagesAqarEvent(images: images));
                      }
                    }
                  },
                ),
              ],
            ),
          );
        },
      );

  void showImageGalleryForMainImage({
    required BuildContext context,
    required UploadAqarBloc bloc,
    isMultiChoose = false,
  }) =>
      showModalBottomSheet(
        context: context,
        routeSettings: const RouteSettings(name: "show_image_gallery"),
        backgroundColor: AppColors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        builder: (BuildContext context) {
          ImagePicker picker = ImagePicker();

          return Padding(
            padding: gPaddingSymmetric(horizontal: 10, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bottomSheetListTile(
                  'الكاميرا',
                  icon: CupertinoIcons.photo_camera,
                  callback: () async {
                    File image = File('');
                    XFile? res =
                        await picker.pickImage(source: ImageSource.camera);
                    image = File(res!.path);
                    bloc.mainImage = image;
                    print('tthism is the mainImage ${bloc.mainImage}');
                    i<NavigationService>().pop();
                    setState(() {});
                  },
                ),
                bottomSheetListTile(
                  'معرض الصور',
                  image: AppImages.addImage,
                  callback: () async {
                    File image = File('');
                    XFile? res =
                        await picker.pickImage(source: ImageSource.gallery);
                    image = File(res!.path);
                    bloc.mainImage = image;
                    print('tthism is the mainImage ${bloc.mainImage}');
                    i<NavigationService>().pop();
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      );

/*   void showVideoGallery(BuildContext context) => showModalBottomSheet(
        context: context,
        routeSettings: const RouteSettings(name: "show_video_gallery"),
        builder: (BuildContext context) {
          return SizedBox(
            height: 100.h,
            child: Column(
              children: [
                bottomSheetListTile(
                  'الكاميرا',
                  icon: Icons.photo_camera_outlined,
                ),
                bottomSheetListTile('معرض الفيديو', img: AppImages.addImg),
              ],
            ),
          );
        },
      ); */
  Widget _body(BuildContext context, UploadAqarBloc bloc) {
    return Padding(
      padding: gPadding(top: 25, bottom: 25),
      child: Column(
        children: [
          DottedBorder(
            borderType: BorderType.Rect,
            color: AppColors.primary,
            dashPattern: const [10, 8],
            radius: const Radius.circular(100).r,
            padding: gPaddingSymmetric(horizontal: 15, vertical: 15),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.addImage,
                    height: 42.h,
                    width: 42.h,
                  ),
                  10.height,
                  TextWidget(
                    "الصورة الرئيسية للعقار",
                    style: getTextStyle16(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextWidget(
                    "يمكنك اختيار صورة واحدة كصورة رئيسية للعقار",
                    style: getTextStyleNormal(
                      color: AppColors.black.withOpacity(.5),
                    ),
                  ),
                  12.height,
                  BtnWidget(
                    title: 'أضف الصورة الرئيسية',
                    height: 35,
                    width: 305,
                    style: getTextStyle16(color: AppColors.white),
                    // onTap: () => showImageGallery(
                    //   context: context,
                    //   bloc: bloc,
                    //   isMultiChoose: false,
                    // ),
                    onTap: () => showImageGalleryForMainImage(
                        context: context, bloc: bloc, isMultiChoose: false),
                  ),
                ],
              ),
            ),
          ),
          32.height,
          Container(
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
                      "صور إضافية للعقار",
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
                    "يمكنك إضافة صور متعددة متعددة لمرافق العقار ليكون جذابا",
                    textAlign: TextAlign.center,
                    style: getTextStyleNormal(
                      color: AppColors.black.withOpacity(.46),
                    ),
                  ),
                ),
                12.height,
                BtnWidget(
                  title: "أضف صور للعقار",
                  height: 35,
                  width: 305,
                  style: getTextStyle16(color: AppColors.white),
                  onTap: () => showImageGallery(
                      context: context, bloc: bloc, isMultiChoose: true),
                ),
              ],
            ),
          ),
          15.height,
          _buildMainImage(bloc),
          15.height,
          _buildSelectedImages(bloc),
          if (bloc.state.images.isEmpty)
            Padding(
              padding: gPadding(right: 75, left: 75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.emptyAddImage,
                    height: 200.h,
                    width: 200.w,
                  ),
                  TextWidget(
                    "لا يوجد صور بعد ..قم برفع صور مميزة لاعلانك حتي تجذب العملاء",
                    textAlign: TextAlign.center,
                    style: getTextStyleNormal(
                      color: AppColors.black.withOpacity(.45),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainImage(UploadAqarBloc bloc) => Column(
        children: [
          TextWidget(
            'الصورة الرئيسية للعقار',
            style: getTextStyleNormal(
              color: AppColors.black.withOpacity(.65),
            ),
          ),
          10.height,
          if (bloc.mainImage != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: 8.radius,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(bloc.mainImage!.path.toString()),
                          ),
                        ),
                      ),
                    ),
                    IconButtonWidget(
                      onTap: () {
                        bloc.removemainImageAqarEvent();
                        setState(() {});
                      },
                      height: 35,
                      padding: gPadding(right: 5, top: 5),
                      icon: CupertinoIcons.delete_simple,
                      backgroundColor: AppColors.redAccount,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
        ],
      );

  _buildSelectedImages(UploadAqarBloc bloc) => Column(
        children: [
          TextWidget(
            'عدد الصور المحملة: ${bloc.state.images.length}',
            style: getTextStyleNormal(
              color: AppColors.black.withOpacity(.65),
            ),
          ),
          10.height,
          if (bloc.state.firstImage != null)
            Center(
              child: Image.file(
                bloc.state.firstImage!,
                height: 100.h,
                width: 100.h,
                fit: BoxFit.cover,
              ),
            ),
          if (bloc.state.images.isNotEmpty)
            SizedBox(
              width: ScreenUtil().screenWidth,
              child: Wrap(
                alignment: bloc.state.images.length <= 2
                    ? WrapAlignment.start
                    : WrapAlignment.spaceBetween,
                runSpacing: 10.h,
                spacing: bloc.state.images.length <= 2 ? 15.w : 0.0,
                children: [
                  ...List.generate(bloc.state.images.length, (index) {
                    return Stack(
                      children: [
                        Container(
                          height: 100.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: 8.radius,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(bloc.state.images[index].path.toString()),
                              ),
                            ),
                          ),
                        ),
                        IconButtonWidget(
                          onTap: () => bloc
                              .add(RemoveImageAqarEvent(selectedImage: index)),
                          height: 35,
                          padding: gPadding(right: 5, top: 5),
                          icon: CupertinoIcons.delete_simple,
                          backgroundColor: AppColors.redAccount,
                          color: AppColors.white,
                          size: 18,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
        ],
      );
}
