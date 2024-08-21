import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '/index.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    await Firebase
        .initializeApp(); //options: DefaultFirebaseOptions.currentPlatform
    ServicesLocator().init();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingHandlerOnBackground);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    await translator.init(
      localeType: LocalizationDefaultType.device,
      languagesList: <String>["ar", "en"],
      assetsDirectory: 'assets/langs/',
      language: "ar",
    );

    runApp(const MyApp());
    // Bloc.observer = MyBlocObserver();
    // Bloc.observer = MyBlocObserver();
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      log(" error in main ==> ${details.exception} \n details ===> $details");
      // log("flutter error in main ==> ${details.exception}");
    };
    /* ErrorWidget.builder = (FlutterErrorDetails details) {
      return const Scaffold();
    }; */
  }, (error, stack) {
    // log("error in main ==> $error");
    log("error in main ==> $error \n stack(error) ==> $stack");
  });
}

Future<void> firebaseMessagingHandlerOnBackground(RemoteMessage message) async {
  print(message.messageId);
}
