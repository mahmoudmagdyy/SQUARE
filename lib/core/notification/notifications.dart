import 'dart:developer';

import 'package:aqarat/index.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHelper {
  NotificationHelper._();
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    await requestPermission();
    await _initNotification();
    await getFireToken();
    onMessage();
    onMessageOpenedApp();
    onBackgroundMessage();
  }

  static Future<void> _initNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "asalny_key",
          channelName: "asalny_channel",
          channelDescription: "asalny_channel_description",
          playSound: true,
          channelShowBadge: true,
          importance: NotificationImportance.Max,
        ),
      ],
    );
  }

  static String? _fireToken;
  static String? get fireToken => _fireToken;
  static Future<String?> getFireToken() async {
    var fireToken = await FirebaseMessaging.instance.getToken();

    await sl<BaseAuthRemoteDataSource>().updateFCMToken(fireToken.toString());
    log('User Token $fireToken');
    debugPrint('User Token $fireToken');
    return fireToken;
  }

  static Future<void> requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }

  static void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await showNotification(message);
      log('==================== onMessage ====================');
    });
  }

  static void onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // await showNotification(message);
      //Todo : Logic and Navigation Here;
      log('==================== onMessageOpenedApp ====================');
    });
  }

  static void onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    log('==================== Background ====================');
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    // await showNotification(message);
  }

  static Future<void> showNotification(RemoteMessage message) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: message.notification.hashCode,
        channelKey: "asalny_key",
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        displayOnBackground: true,
        displayOnForeground: true,
      ),
    );
  }
}
