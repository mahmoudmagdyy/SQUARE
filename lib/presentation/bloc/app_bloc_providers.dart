import 'package:aqarat/core/services/services_locator.dart';
import 'package:aqarat/presentation/bloc/auth/forget_password/forget_password_bloc.dart';
import 'package:aqarat/presentation/bloc/auth/register/register_bloc.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';
import 'package:aqarat/presentation/bloc/filter/filter_bloc.dart';
import 'package:aqarat/presentation/bloc/home/home_bloc.dart';
import 'package:aqarat/presentation/bloc/location/location_bloc.dart';
import 'package:aqarat/presentation/bloc/main/main_bloc.dart';
import 'package:aqarat/presentation/bloc/my_ads/my_ads_cubit.dart';
import 'package:aqarat/presentation/bloc/my_favorites/my_favorites_cubit.dart';
import 'package:aqarat/presentation/bloc/notification/notification_cubit.dart';
import 'package:aqarat/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:aqarat/presentation/bloc/profile/profile_bloc.dart';
import 'package:aqarat/presentation/bloc/publish_add/publish_add_cubit.dart';
import 'package:aqarat/presentation/bloc/search_for_me_bloc/search_for_me_bloc.dart';
import 'package:aqarat/presentation/bloc/search_for_me_cubit/search_for_me_cubit.dart';
import 'package:aqarat/presentation/bloc/settings/settings_bloc.dart';
import 'package:aqarat/presentation/bloc/upload/upload_aqar_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/ticket/logic/ticket_cubit.dart';

// import '/index.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(create: (context) => sl<OnboardingBloc>()),
        // BlocProvider(create: (context) => sl<LoginBloc>()),
        BlocProvider(create: (context) => sl<RegisterBloc>()),
        BlocProvider(create: (context) => sl<ForgetPasswordBloc>()),
        BlocProvider(
          create: (context) => sl<UploadAqarBloc>()
            ..add(GetCitiesEvent())
            ..add(GetTypesAqarEvent())
            ..add(GetQuestionsEvent())
            ..add(GetExtraOptionsEvent()),
        ),
        BlocProvider(create: (context) => sl<MainBloc>()),
        BlocProvider(
          create: (context) =>
              sl<LocationBloc>()..add(const GetCurrentLocationEvent()),
        ),
        BlocProvider(
          create: (context) => sl<ProfileBloc>()..add(const GetProfileEvent()),
        ),
        BlocProvider(
          create: (context) => sl<HomeBloc>()
            ..add(const GetSliderEvent())
            ..add(const GetCityEvent())
            ..add(const GetAdsEvent())
            ..getCitiesWithArea(),
        ),
        BlocProvider(create: (context) => sl<FilterBloc>()),
        BlocProvider(create: (context) => SearchForMeBloc(sl())),
        BlocProvider(create: (context) => SettingsBloc(sl(), sl(), sl())),
        BlocProvider(create: (context) => MyAdsCubit(sl())..getMyAds()),
        BlocProvider(create: (context) => MyFavoritesCubit(sl())..getAllFav()),
        // BlocProvider(create: (context) => sl<EditMyAdCubit>()),
        BlocProvider(create: (context) => sl<NotificationCubit>()),
        BlocProvider(create: (context) => sl<TicketCubit>()),
        BlocProvider(
          create: (context) => PublishAddCubit(sl())
            ..getpublishAdd()
            ..getpublishAddSlider()
            ..getAdminPhoneNumber(),
        ),
        BlocProvider(
            create: (context) => SearchForMeCubit(
                  sl(),
                )),
        BlocProvider(create: (context) => MyAdsCubit(sl())..getMyAds()),
        BlocProvider(create: (context) => MyFavoritesCubit(sl())..getAllFav()),
        BlocProvider(create: (context) => EditMyAdCubit(sl())),
        BlocProvider(
            create: (context) => sl<NotificationCubit>()..getAllNotification()),
        // sl()
      ];
}
