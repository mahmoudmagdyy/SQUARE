import 'package:aqarat/data/data_source/remote/ad_details/ad_details_remote_data_source.dart';
import 'package:aqarat/data/data_source/remote/favorite/favorite_remote_data_source.dart';
import 'package:aqarat/data/data_source/remote/filter/base_filter_remote_data_source.dart';
import 'package:aqarat/data/data_source/remote/home/base_home_remote_data_source.dart';
import 'package:aqarat/data/data_source/remote/my_ads/my_ads_remote_data_source.dart';
import 'package:aqarat/data/data_source/remote/notification/notitication_remote_data_source.dart';
import 'package:aqarat/data/data_source/remote/profile/base_profile_remote_data_source.dart';
import 'package:aqarat/data/data_source/remote/settings/base_settings_remote_data_source.dart';
import 'package:aqarat/data/repository/ad_details/ad_details_repository.dart';
import 'package:aqarat/data/repository/favorites/favorites_repository.dart';
import 'package:aqarat/data/repository/filter/filter_repo_imp.dart';
import 'package:aqarat/data/repository/home/home_repository_imp.dart';
import 'package:aqarat/data/repository/my_ads/my_ads_repository.dart';
import 'package:aqarat/data/repository/notification/notification_repository.dart';
import 'package:aqarat/data/repository/profile/profile_repo_imp.dart';
import 'package:aqarat/data/repository/search_for_me/search_for_me_repo.dart';
import 'package:aqarat/data/repository/settings/settings_repo_imp.dart';
import 'package:aqarat/domain/repository/filter/base_filter_repository.dart';
import 'package:aqarat/domain/repository/home/base_home_repository.dart';
import 'package:aqarat/domain/repository/profile/base_profile_repository.dart';
import 'package:aqarat/domain/repository/settings/base_settings_respository.dart';
import 'package:aqarat/domain/usecases/auth/reset_password_usecase.dart';
import 'package:aqarat/domain/usecases/auth/send_otp_usecase.dart';
import 'package:aqarat/domain/usecases/auth/set_otp_usecase.dart';
import 'package:aqarat/domain/usecases/filter/filter_usecase.dart';
import 'package:aqarat/domain/usecases/home/get_ads_usecase.dart';
import 'package:aqarat/domain/usecases/home/get_city_usecase.dart';
import 'package:aqarat/domain/usecases/home/get_slider_usecase.dart';
import 'package:aqarat/domain/usecases/home/search_usecase.dart';
import 'package:aqarat/domain/usecases/profile/get_profile_id_usecase.dart';
import 'package:aqarat/domain/usecases/profile/get_profile_usecase.dart';
import 'package:aqarat/domain/usecases/profile/update_profile_usecase.dart';
import 'package:aqarat/domain/usecases/settings/delete_account_usecase.dart';
import 'package:aqarat/domain/usecases/settings/logout_usecase.dart';
import 'package:aqarat/presentation/bloc/ads_details/ads_details_cubit.dart';
import 'package:aqarat/presentation/bloc/edit_my_ad/edit_my_ad_cubit.dart';
import 'package:aqarat/presentation/bloc/filter/filter_bloc.dart';
import 'package:aqarat/presentation/bloc/home/home_bloc.dart';
import 'package:aqarat/presentation/bloc/my_ads/my_ads_cubit.dart';
import 'package:aqarat/presentation/bloc/notification/notification_cubit.dart';
import 'package:aqarat/presentation/bloc/profile/profile_bloc.dart';
import 'package:aqarat/presentation/bloc/publish_add/publish_add_cubit.dart';
import 'package:aqarat/presentation/bloc/settings/settings_bloc.dart';

import '../../data/data_source/remote/publish_add/publish_add.dart';
import '../../data/data_source/remote/search_for_me/search_for_me_remote_data_source.dart';
import '../../data/repository/publish_add/publish_add.dart';
import '../../domain/usecases/home/get_cities_with_area.dart';
import '../../presentation/pages/ticket/data/datasources/ticket_remote_data_source.dart';
import '../../presentation/pages/ticket/data/repositories/ticket_repository.dart';
import '../../presentation/pages/ticket/logic/ticket_cubit.dart';
import '/index.dart';

final GetIt sl = GetIt.instance;
final GetIt i = GetIt.I;

class ServicesLocator {
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => prefs);
    sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));
    i.registerLazySingleton<NavigationService>(() => NavigationService());
    //! Network Info
    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()),
    );

    //! Dio factory
    i.registerLazySingleton<DioFactory>(() => DioFactory());

    //! Data Source
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(),
    );
    sl.registerLazySingleton<BaseProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImp(),
    );
    sl.registerLazySingleton<BaseUploadAdRemoteDataSource>(
      () => UploadAdRemoteDataSourceImp(),
    );
    sl.registerLazySingleton<BaseHomeRemoteDataSource>(
      () => HomeRemoteDataSourceImp(),
    );
    sl.registerLazySingleton<BaseFilterRemoteDataSource>(
      () => FilterRemoteDataSourceImp(),
    );
    sl.registerLazySingleton<BaseSettingsRemoteDataSource>(
      () => SettingsRemoteDataSourceImp(),
    );
    sl.registerLazySingleton<MyAdsRemoteDataSource>(
      () => MyAdsRemoteDataSource(),
    );
    sl.registerLazySingleton<PublishAddDataSource>(
      () => PublishAddDataSource(),
    );
    sl.registerLazySingleton<FavoriteRemoteDataSource>(
      () => FavoriteRemoteDataSource(),
    );
    sl.registerFactory<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSource(),
    );
    sl.registerLazySingleton<AdDetailsRemoteDataSource>(
      () => AdDetailsRemoteDataSource(),
    );

    //! Repository
    sl.registerLazySingleton<BaseAuthenticationRepository>(
      () => AuthenticationRepositoryImp(
        sl<BaseAuthRemoteDataSource>(),
        sl<NetworkInfo>(),
      ),
    );
    sl.registerLazySingleton<BaseProfileRepository>(
      () => ProfileRepositoryImp(
        sl<BaseProfileRemoteDataSource>(),
        sl<NetworkInfo>(),
      ),
    );
    sl.registerLazySingleton<BaseUploadAqarRepository>(
      () => UploadAqarRepositoryImp(
        sl<BaseUploadAdRemoteDataSource>(),
        sl<NetworkInfo>(),
      ),
    );
    sl.registerLazySingleton<BaseHomeRepository>(
      () => HomeRepositoryImp(
        sl<BaseHomeRemoteDataSource>(),
        sl<NetworkInfo>(),
      ),
    );
    sl.registerLazySingleton<BaseFilterRepository>(
      () => FilterRepositoryImp(
        sl<BaseFilterRemoteDataSource>(),
        sl<NetworkInfo>(),
      ),
    );
    // SearchForMeRepository
    sl.registerLazySingleton<SearchForMeRepository>(
      () => SearchForMeRepository(remoteDataSource: SearchForMeDataSource()),
    );
    //
    sl.registerLazySingleton<BaseSettingsRepository>(
      () => SettingsRepositoryImp(
        sl<BaseSettingsRemoteDataSource>(),
        sl<NetworkInfo>(),
      ),
    );
    sl.registerLazySingleton<TicketRepository>(
      () => const TicketRepository(TicketRemoteDataSource()),
    );
    sl.registerLazySingleton<MyAdsRepository>(
      () => MyAdsRepository(
        sl<NetworkInfo>(),
        sl<MyAdsRemoteDataSource>(),
      ),
    );
    sl.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepository(
        sl<NetworkInfo>(),
        sl<FavoriteRemoteDataSource>(),
      ),
    );
    sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepository(
        sl<NetworkInfo>(),
        sl<NotificationRemoteDataSource>(),
      ),
    );
    sl.registerLazySingleton<PublishAddRepository>(
      () => PublishAddRepository(sl<PublishAddDataSource>()),
    );
    sl.registerLazySingleton<AdDetailsRepository>(
      () => AdDetailsRepository(
        sl(),
        sl(),
      ),
    );
    //! Use Cases
    sl.registerLazySingleton(
        () => RegisterUseCase(sl<BaseAuthenticationRepository>()));
    sl.registerLazySingleton(
        () => LoginUseCase(sl<BaseAuthenticationRepository>()));
    sl.registerLazySingleton(() => SendOtpUseCase(sl()));
    sl.registerLazySingleton(() => SetOtpUseCase(sl()));
    sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
    sl.registerLazySingleton(
        () => GetCitiesUseCase(sl<BaseUploadAqarRepository>()));
    sl.registerLazySingleton(
        () => GetTypesAqarUseCase(sl<BaseUploadAqarRepository>()));
    sl.registerLazySingleton(
        () => GetQuestionsUseCase(sl<BaseUploadAqarRepository>()));
    sl.registerLazySingleton(
        () => GetExtraOptionsUseCase(sl<BaseUploadAqarRepository>()));
    sl.registerLazySingleton(
        () => UploadUseCase(sl<BaseUploadAqarRepository>()));
    sl.registerLazySingleton(() => GetProfileIdUseCase(sl()));
    sl.registerLazySingleton(() => GetProfileUseCase(sl()));
    sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
    sl.registerLazySingleton(() => GetSilderUseCase(sl()));
    sl.registerLazySingleton(() => GetCityUseCase(sl()));
    sl.registerLazySingleton(() => GetAdsUseCase(sl()));
    sl.registerLazySingleton(() => GetCitiesWithAreaUseCase(sl()));
    sl.registerLazySingleton(() => SearchUseCase(sl()));
    sl.registerLazySingleton(() => FilterUseCase(sl()));
    sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
    sl.registerLazySingleton(() => LogOutUseCase(sl()));

    ///! Bloc
    sl.registerLazySingleton<OnboardingBloc>(() => OnboardingBloc(sl()));
    sl.registerLazySingleton<LoginBloc>(() => LoginBloc(sl<LoginUseCase>()));
    sl.registerLazySingleton<RegisterBloc>(
        () => RegisterBloc(sl<RegisterUseCase>()));
    sl.registerFactory<ForgetPasswordBloc>(
      () => ForgetPasswordBloc(
        sl<ResetPasswordUseCase>(),
        sl<SendOtpUseCase>(),
        sl<SetOtpUseCase>(),
      ),
    );
    sl.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        sl<GetProfileIdUseCase>(),
        sl<GetProfileUseCase>(),
        sl<UpdateProfileUseCase>(),
      ),
    );
    sl.registerLazySingleton<UploadAqarBloc>(() => UploadAqarBloc(
          sl<GetCitiesUseCase>(),
          sl<GetTypesAqarUseCase>(),
          sl<GetQuestionsUseCase>(),
          sl<GetExtraOptionsUseCase>(),
          sl<UploadUseCase>(),
          sl<LocationBloc>(),
          // sl<HomeBloc>(),
        ));
    sl.registerLazySingleton<MainBloc>(() => MainBloc());
    sl.registerLazySingleton<LocationBloc>(() => LocationBloc());
    sl.registerLazySingleton<HomeBloc>(
      () => HomeBloc(sl(), sl(), sl(), sl(), sl()),
    );
    sl.registerLazySingleton<FilterBloc>(() => FilterBloc(sl()));
    sl.registerLazySingleton<TicketCubit>(() => TicketCubit(sl()));
    sl.registerLazySingleton<SettingsBloc>(
        () => SettingsBloc(sl(), sl(), sl()));
    sl.registerLazySingleton<MyAdsCubit>(() => MyAdsCubit(sl()));
    sl.registerLazySingleton<NotificationCubit>(() => NotificationCubit(sl()));
    sl.registerLazySingleton<PublishAddCubit>(() => PublishAddCubit(sl()));

    sl.registerFactory<EditMyAdCubit>(() => EditMyAdCubit(sl()));

    sl.registerFactory<AdsDetailsCubit>(() => AdsDetailsCubit(sl()));
  }
}
