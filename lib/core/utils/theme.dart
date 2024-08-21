import 'package:aqarat/index.dart';

ThemeData get getThemeData => ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary, secondary: AppColors.secondary),
      fontFamily: "NotoSans",
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: AppColors.white,
        /* shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(25),
            bottomEnd: Radius.circular(25),
          ),
        ), */
        surfaceTintColor: AppColors.transparent,
      ),
      useMaterial3: true,
      dividerTheme:
          const DividerThemeData(color: AppColors.greyLight, thickness: 1.5),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(ScreenUtil().screenWidth, 40.h),
          ),
          overlayColor: MaterialStateProperty.all(AppColors.greyLight),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: 4.radius),
          ),
        ),
      ),
      /*  bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 0.0,
        surfaceTintColor: AppColors.transparent,
        color: AppColors.white,
        shape: CircularNotchedRectangle(),
        shadowColor: AppColors.lightGrey,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        sizeConstraints: BoxConstraints(maxHeight: 65.h, minWidth: 65.h),
        shape: RoundedRectangleBorder(borderRadius: 50.borderRadius),
      ),
      checkboxTheme: CheckboxThemeData(
        overlayColor: MaterialStateProperty.all(AppColors.primaryColor),
        fillColor: MaterialStateProperty.all(Colors.transparent),
        side: const BorderSide(color: AppColors.borderColor),
        checkColor: MaterialStateProperty.all(AppColors.black),
      ),
      tabBarTheme: const TabBarTheme(
        dividerColor: AppColors.white,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: AppColors.secondaryColor,
        labelColor: AppColors.secondaryColor,
        unselectedLabelColor: AppColors.darkGrey,
        indicator: MDIndicator(
          indicatorSize: MDIndicatorSize.full,
          indicatorHeight: 4.0,
          indicatorColor: AppColors.secondaryColor,
        ),
      ), */
    );
