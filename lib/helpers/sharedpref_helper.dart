import 'dart:convert';

import 'package:blord/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey = "USERIDKEY";
  static String userNameKey = "USERNAMEKEY";
  static String displayNameKey = "USERDISPLAYNAME";
  static String userEmailKey = "USEREMAILKEY";
  static String userProfilePicKey = "USERPROFILEKEY";

  static String userData = "USERDATA";

  String dummyImage = "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png";

  //save data
  Future<void> saveUserData({required AuthUser user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userData, jsonEncode(user.toJson()));
  }

  Future<AuthUser?> getUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(userData);
    if (data != null) {
      return AuthUser.fromJson(jsonDecode(data));
    } else {
      return null;
    }
  }

  //get data
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  Future<String?> getPictureUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }

}