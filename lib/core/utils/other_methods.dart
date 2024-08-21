import 'dart:io';
import 'package:aqarat/index.dart';
import 'package:intl/intl.dart';

class OtherMethods {
  OtherMethods._();
  static Future<File> compressedFile({
    required File file,
    int quality = 50,
    int percentage = 50,
  }) async {
    File path = await FlutterNativeImage.compressImage(
      file.absolute.path,
      quality: quality,
      percentage: percentage,
    );

    return path;
  }

  static String format(int number) {
    final format = NumberFormat('##,##0').format(number);
    return format;
  }


static Future<void> launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

}
