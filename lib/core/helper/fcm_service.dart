import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    carPlay: true,
    criticalAlert: false,
    provisional: false,
  );
  messaging.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('authorized');
  }
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print(
  //       'title ${message.notification!.title} body ${message.notification!.body}');
  // });
}
