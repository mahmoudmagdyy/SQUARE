class ApiConstance {
  static const String baseUrl = "http://square.visooft.com/api/v1/";
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String logout = "auth/logout";
  static const String deleteAccount = "auth/remove-account";
  static const String sendOtp = "auth/send-otp";
  static const String updateFCMToken = "auth/update-fcm";
  static String otp(String otp) => "auth/activate/$otp";
  static String resetPassword(String phone) => "auth/update-password/$phone";

  static const String profile = 'profile';
  static const String updateProfile = 'profile';
  static String getProfileId(String id) => "profile/$id";
  static const String cities = "cities";
  static const String city = "home/cities";
  static const String cityWithArea = "cities";

  static const String type = "property-tool/type";
  static const String filter = "property/filter";
  static const String questions = "property-tool/questions";
  static const String extraOptions = "property-tool/tools";
  static const String upload = "property";
  static const String home = "home";
  static const String slider = "home/slider";
  static const String banner = "home/banner";
  static const String setting = "setting";
  static const String search = "property/search";
  static const String searchForMe = "search-for-me";

  //! New
  static const String myAds = "property/user-property";
  static const String specificAds = "property/show";
  static const String removeMyAds = "property/remove/";
  static const String myFavorites = "property/user-favorite";
  static const String addOrRemoveFav = "property/favorite";
  static const String updateMyAds = "property/update";
  static const String notification = "notification";
  static const String similarAds = "property/similar";
  static const String sendNotificationToAdmin = 'chat';
  // ticket
  static const String report = 'report';
}

class ApiRequestStatusCode {
  ApiRequestStatusCode._();
  static const int success = 200;
}
