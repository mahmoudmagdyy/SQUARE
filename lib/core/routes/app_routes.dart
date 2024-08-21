import 'package:aqarat/domain/entities/home/ads_entity.dart';
import 'package:aqarat/presentation/pages/edit_ads/screens/edit-ad-type/edit_ad_type_screen.dart';
import 'package:aqarat/presentation/pages/edit_ads/screens/edit_details/edit_aqar_details_screen.dart';
import 'package:aqarat/presentation/pages/home/filter/filter_page.dart';
import 'package:aqarat/presentation/pages/map/filter/map_filter_screen.dart';
import 'package:aqarat/presentation/pages/my_ads/my_ads_page.dart';
import 'package:aqarat/presentation/pages/publish_add/publish_add_screen.dart';
import 'package:aqarat/presentation/pages/sign_in_search_for_me/define_interests/define_interests_find_me.dart';
import 'package:aqarat/presentation/pages/sign_in_search_for_me/search_for_me/search_for_me.dart';
import 'package:aqarat/presentation/pages/sign_in_search_for_me/select_aqar_type/select_aqar_type.dart';
import 'package:aqarat/presentation/pages/sign_in_search_for_me/sign_in_saerch_for_me.dart';
import 'package:aqarat/presentation/pages/ticket/presentation/screens/open-ticket/open_ticket_screen.dart';

import '../../presentation/pages/chat/prsentation/screen/chat_screen.dart';
import '../../presentation/pages/chat/prsentation/screen/users_chats_screen.dart';
import '../../presentation/pages/edit_ads/screens/edit_image/edit_ad_image_screen.dart';
import '../../presentation/pages/edit_ads/screens/edit_map/edit_ad_map_screen.dart';
import '../../presentation/pages/privacy/privacy_screen.dart';
import '../../presentation/pages/ticket/data/models/ticket.dart';
import '../../presentation/pages/ticket/presentation/screens/support/support_details_screen.dart';
import '/index.dart';

Map<String, Widget Function(BuildContext)> appRoutes = <String, WidgetBuilder>{
  Routes.splash: (_) => const SplashPage(),
  Routes.onboarding: (_) => OnboardingPage(),
  Routes.login: (_) => const LoginPage(),
  Routes.register: (_) => const RegisterPage(),
  Routes.forgetPassword: (_) => const ForgetPasswordPage(),
  Routes.setNewPassword: (_) => const SetNewPasswordPage(),
  Routes.verificationForget: (_) => VerificationForgetPage(),
  Routes.verificationRegister: (_) => const VerificationRegisterPage(),
  Routes.errorVerificationScreen: (_) => const ErrorVerificationScreen(),
  Routes.filter: (context) {
    var params =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return FilterPage(
      cityId: params?['cityId'],
      listOfAreas: params?['listOfAreas'],
    );
  },
  Routes.mapFilter: (_) => const MapFilterPage(),
  Routes.search: (_) => const SearchPage(),
  Routes.main: (_) => const MainPage(),
  Routes.map: (_) => const MapPage(),
  Routes.ads: (_) => const AdsPage(),
  Routes.adsDetails: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final item = args['item'] as AdsEntity;
    final isFromMyAds = args['fromMyAds'] as bool;
    return AdsDetailsPage(
      fromMyAds: isFromMyAds,
      item: item,
    );
  },
  Routes.profile: (_) => const ProfilePage(),
  Routes.chat: (context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var userId = args['user_id'];
    var username = args['user_name'];

    return ChatScreen(
      userId: userId,
      username: username,
    );
  },
  Routes.usersChatsScreen: (_) => const UsersChatsScreen(),
  Routes.profileEdit: (_) => const ProfileEditPage(),
  Routes.settings: (_) => const SettingPage(),
  Routes.notification: (_) => const NotificationPage(),
  Routes.favorite: (_) => const FavoritePage(),
  Routes.addAdsImgPage: (_) => const AddAdsImagesPage(),
  Routes.addAdsDetails: (_) => const AddAdsDetailesPage(),
  Routes.selectAdsLocation: (_) => const SelectAdsLocationPage(),
  Routes.aqarDetailsPage: (_) => const AqarDetailsPage(),
  Routes.displayAdsInputs: (_) => const DisplayAdsInputsPage(),
  Routes.signInSearchForMe: (_) => const SignInSearchForMePage(),
  Routes.defineInterests: (_) => const DefineInterestsFindMePage(),
  Routes.selectAqarType: (_) => const SelectAqarTypePage(),
  Routes.searchForMe: (_) => const SearchForMePage(),
  Routes.myAds: (_) => const MyAdsPage(),
  Routes.openTicketRoute: (_) => const OpenTicketScreen(),
  Routes.privacy: (_) => const PrivacyScreen(),
  Routes.publishAdd: (_) => const PublishAddScreen(),
  //!Edit Ads
  Routes.editMyAd: (context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var item = args['item'];
    var index = args['index'];

    return const EditMyAdImageScreen(
        // property: item,
        // index: index,
        );
  },
  Routes.supportDetailsRoute: (context) {
    var args = ModalRoute.of(context)!.settings.arguments as TickerData;

    return SupportDetailsScreen(
      data: args,
    );
  },
  Routes.editAdType: (_) {
    var args = ModalRoute.of(_)!.settings.arguments as Map<String, dynamic>;

    return EditAdTypeScreen(
      property: args['item'],
      index: args['index'],
    );
  },
  Routes.editMyAdsImage: (_) {
    // var args = ModalRoute.of(_)!.settings.arguments as Map<String, dynamic>;
    return const EditMyAdImageScreen(
        // property: args['item'],
        // index: args['index'],
        );
  },
  Routes.editAdMap: (_) {
    return EditAdMapScreen(
      latLng: ModalRoute.of(_)!.settings.arguments as LatLng,
    );
  },
  Routes.editAqarDetails: (_) => const EditAqarDetailsScreen(),
};
// =======
// import 'package:aqarat/presentation/pages/edit_ads/edit_ad_image_screen.dart';
// import 'package:aqarat/presentation/pages/edit_ads/edit_ad_map_screen.dart';
// import 'package:aqarat/presentation/pages/edit_ads/edit_ad_type_screen.dart';
// import 'package:aqarat/presentation/pages/edit_ads/edit_aqar_details_screen.dart';
// import 'package:aqarat/presentation/pages/home/filter/filter_page.dart';
// import 'package:aqarat/presentation/pages/map/filter/map_filter_screen.dart';
// import 'package:aqarat/presentation/pages/my_ads/my_ads_page.dart';
// import 'package:aqarat/presentation/pages/sign_in_search_for_me/define_interests/define_interests_find_me.dart';
// import 'package:aqarat/presentation/pages/sign_in_search_for_me/search_for_me/search_for_me.dart';
// import 'package:aqarat/presentation/pages/sign_in_search_for_me/select_aqar_type/select_aqar_type.dart';
// import 'package:aqarat/presentation/pages/sign_in_search_for_me/sign_in_saerch_for_me.dart';

// import '/index.dart';

// Map<String, Widget Function(BuildContext)> appRoutes = <String, WidgetBuilder>{
//   Routes.splash: (_) => const SplashPage(),
//   Routes.onboarding: (_) => OnboardingPage(),
//   Routes.login: (_) => const LoginPage(),
//   Routes.register: (_) => const RegisterPage(),
//   Routes.forgetPassword: (_) => const ForgetPasswordPage(),
//   Routes.setNewPassword: (_) => const SetNewPasswordPage(),
//   Routes.verificationForget: (_) => VerificationForgetPage(),
//   Routes.verificationRegister: (_) => const VerificationRegisterPage(),
//   Routes.errorVerificationScreen: (_) => const ErrorVerificationScreen(),
//   Routes.filter: (_) => const FilterPage(),

//   Routes.mapFilter: (_) => const MapFilterPage(),
//   Routes.search: (_) => const SearchPage(),
//   Routes.main: (_) => const MainPage(),
//   Routes.map: (_) => const MapPage(),
//   Routes.ads: (_) => const AdsPage(),
//   Routes.adsDetails: (_) => const AdsDetailsPage(),
//   Routes.profile: (_) => const ProfilePage(),
//   Routes.profileEdit: (_) => const ProfileEditPage(),
//   Routes.settings: (_) => const SettingPage(),
//   Routes.notification: (_) => const NotificationPage(),
//   Routes.favorite: (_) => const FavoritePage(),
//   Routes.addAdsImgPage: (_) => const AddAdsImagesPage(),
//   Routes.addAdsDetails: (_) => const AddAdsDetailesPage(),
//   Routes.selectAdsLocation: (_) => const SelectAdsLocationPage(),
//   Routes.aqarDetailsPage: (_) => const AqarDetailsPage(),
//   Routes.displayAdsInputs: (_) => const DisplayAdsInputsPage(),
//   Routes.signInSearchForMe: (_) => const SignInSearchForMePage(),
//   Routes.defineInterests: (_) => const DefineInterestsFindMePage(),
//   Routes.selectAqarType: (_) => const SelectAqarTypePage(),
//   Routes.searchForMe: (_) => const SearchForMePage(),
//   Routes.myAds: (_) => const MyAdsPage(),
//   //!Edit Ads
//   Routes.editMyAd: (context) {
//     var args =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     var item = args['item'];
//     var index = args['index'];

//     return EditMyAdImageScreen(
//       property: item,
//       index: index,
//     );
//   },
//   Routes.editAqarDetails: (_) => const EditAqarDetailsScreen(),
//   Routes.editMyAdsImage: (_) {
//     var args = ModalRoute.of(_)!.settings.arguments as Map<String, dynamic>;
//     return EditMyAdImageScreen(
//       property: args['item'],
//       index: args['index'],
//     );
//   },
//   Routes.editAdMap: (_) => const EditAdMapScreen(),
//   Routes.editAdType: (_) {
//     var args = ModalRoute.of(_)!.settings.arguments as Map<String, dynamic>;

//     return EditAdTypeScreen(
//       property: args['item'],
//       index: args['index'],
//     );
//   },
// };
// >>>>>>> a834a90263ae8b001071c9a6ed510e6fc73802f2
