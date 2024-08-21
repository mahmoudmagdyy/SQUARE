import 'package:aqarat/index.dart';

class AppPreferences {
  final SharedPreferences _prefs;
  AppPreferences(this._prefs);

  Future<bool> get onSubmittedOnboarding async {
    return _prefs.setBool(LocaleKey.onboarding, true);
  }

  bool get getOnboarding {
    return _prefs.getBool(LocaleKey.onboarding) ?? false;
  }

  // login
  Future<bool> get onSubmittedLogin async {
    return await _prefs.setBool(LocaleKey.login, true);
  }

  bool get isLogin {
    return _prefs.getBool(LocaleKey.login) ?? false;
  }

  Future<bool> setToken(String token) async {
    return await _prefs.setString(LocaleKey.token, token);
  }

  Future<bool> setUserId(String userId) async {
    return await _prefs.setString(LocaleKey.userId, userId);
  }

  Future<bool> setUserName(String username) async {
    return await _prefs.setString(LocaleKey.username, username);
  }
  //
  Future<bool> setFirstName(String firstName) async {
    return await _prefs.setString(LocaleKey.firstname, firstName);
  }
  Future<bool> setLastName(String lastName) async {
    return await _prefs.setString(LocaleKey.lastname, lastName);
  }
  Future<bool> setImgUrl(String imgUrl) async {
    return await _prefs.setString(LocaleKey.imgurl, imgUrl);
  }
  Future<bool> setPhone(String phone) async {
    return await _prefs.setString(LocaleKey.phone, phone);
  }
  Future<bool> setEmail(String email) async {
    return await _prefs.setString(LocaleKey.email, email);
  }

  Future<bool> setUserRole(bool role) async {
    return await _prefs.setBool(LocaleKey.role, role);
  }

  String get getToken {
    return _prefs.getString(LocaleKey.token) ?? "";
  }

  String get getUserName {
    return _prefs.getString(LocaleKey.username) ?? "Unknown User";
  }
  String get getEmail {
    return _prefs.getString(LocaleKey.email) ?? "Unknown Email";
  }
  ////////////////////////////////
  String get getFirstName {
    return _prefs.getString(LocaleKey.firstname) ?? "Unknown User";
  }
  String get getLastName {
    return _prefs.getString(LocaleKey.lastname) ?? "Unknown User";
  }
  String get getImgUrl {
    return _prefs.getString(LocaleKey.imgurl) ?? "Unknown img";
  }
  String get getPhone {
    return _prefs.getString(LocaleKey.phone) ?? "Unknown phone";
  }




  bool get isItUser {
    return _prefs.getBool(LocaleKey.role) ?? true;
  }

  String get getuserId {
    return _prefs.getString(LocaleKey.userId) ?? "";
  }

  Future<void> logout() async {
    await _prefs.remove(LocaleKey.login);
    await _prefs.remove(LocaleKey.token);
  }
}
