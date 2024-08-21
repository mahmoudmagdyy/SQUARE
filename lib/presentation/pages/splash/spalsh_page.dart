import 'dart:async';
import 'package:aqarat/index.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(const Duration(seconds: 3), () => onSubmitted());
  }

  void onSubmitted() {
    if (sl<AppPreferences>().getOnboarding == true) {
      sl<AppPreferences>().isLogin == false
          ? i<NavigationService>().toNamedAndRemoveUntil(Routes.login)
          : i<NavigationService>().toNamedAndRemoveUntil(Routes.main);
    } else {
      i<NavigationService>().toNamedAndRemoveUntil(Routes.onboarding);
    }
  }

  /*
        AnyClass(){
          newObject(){
          return ..
        }
      }

      var x = AnyClass()..newObject();
      x = x.newObject();
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: SizedBox(
                height: 140.h,
                width: 150.w,
                child: SvgPicture.asset(AppImages.logo, fit: BoxFit.fill),
              ),
            ),
            10.height,
            SizedBox(
              width: 150.w,
              child: SvgPicture.asset(AppImages.logoname),
            )
            // Text(
            //   'SQUARE',
            //   style: TextStyle(
            //     color: AppColors.primary,
            //     fontSize: 40.sp,
            //     letterSpacing: 7.5,
            //      // fontWeight: FontWeight.bold,
            //      fontFamily: 'Instrument Serif',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
/*

import 'dart:async';
import 'package:aqarat/index.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => submitted());
  }

  void submitted() {
    if (sl<AppPreferences>().getOnboarding == true) {
      sl<AppPreferences>().isLogin == false
          ? i<NavigationService>().toNamedAndRemoveUntil(Routes.login)
          : i<NavigationService>().toNamedAndRemoveUntil(Routes.main);
    } else {
      i<NavigationService>().toNamedAndRemoveUntil(Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SizedBox(
        width: 375.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 140.h,
              width: 150.w,
              child: SvgPicture.asset(AppImages.logo, fit: BoxFit.fill),
            ),
            27.height,
            SizedBox(
              height: 50.h,
              width: 300.w,
              child: SvgPicture.asset(AppImages.logoName, fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}*/
