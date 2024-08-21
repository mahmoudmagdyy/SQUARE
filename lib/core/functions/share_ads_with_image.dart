// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:aqarat/index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void shareAdsWithImage(String imageURL, String code) async {
  try {
    final Dio dio = Dio();
    Response<dynamic>? response;
    final Directory tempDir = await getTemporaryDirectory();
    final String filePath = '${tempDir.path}/$code.png';
    if (!await File(filePath).exists()) {
      response = await dio.download(imageURL, filePath);
    }
    if (response == null || response.statusCode == 200) {
      await Share.shareFiles(
        [filePath],
        text: 'يمكنك رؤيه الاعلان علي تطبيقنا من خلال البحث علي كود $code',
      );
    }
  } catch (e) {
    log('exceptions$e');
  }
}
