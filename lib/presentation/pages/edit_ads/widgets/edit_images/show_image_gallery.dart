import 'package:aqarat/index.dart';
import 'package:flutter/cupertino.dart';
// import 'package:image_picker/image_picker.dart';

Future<void> showImageGallery({
  required BuildContext context,
  required VoidCallback cameraCallback,
  required VoidCallback galleryCallback,
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
        return Padding(
          padding: gPaddingSymmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              bottomSheetListTile(
                'الكاميرا',
                icon: CupertinoIcons.photo_camera,
                callback: () async {
                  sl<NavigationService>().pop();
                  cameraCallback();
                },
              ),
              bottomSheetListTile(
                'معرض الصور',
                image: AppImages.addImage,
                callback: () async {
                  sl<NavigationService>().pop();
                  galleryCallback();
                },
              ),
            ],
          ),
        );
      },
    );
