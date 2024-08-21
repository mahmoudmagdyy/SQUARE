import 'dart:developer';

import 'package:get/get.dart' as getx;

import '/index.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    log("TOKEN ==> ${sl<AppPreferences>().getToken}");
    return MultiBlocProvider(
      providers: AppBlocProviders.allBlocProviders,
      child: ScreenUtilInit(
        designSize: const Size(375.0, 810.0),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return getx.GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: i<NavigationService>().navigatorKey,
            navigatorObservers: [MyObserver()],
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            defaultTransition: getx.Transition.native,
            useInheritedMediaQuery: true,
            theme: getThemeData,
            localizationsDelegates: translator.delegates,
            locale: translator.activeLocale,
            supportedLocales: translator.locals(),
            initialRoute: Routes.splash,
            routes: appRoutes,
          );
        },
      ),
    );
  }
}
