import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late final SharedPreferences _prefs;

  Future<void> loginUser(String userName) async {
    try {
      SharedPreferences sharedPreferences = await _prefs;
      sharedPreferences.setString("userName", userName);
    } catch (e) {
      print("Exception in shared prefs login user $e");
    }
  }

  Future<bool> isLoggedIn() async {
    var username = await _prefs.getString("userName");
    if (username != null) {
      return true;
    }
    return false;
  }

  logoutUser() {
    _prefs.clear();
  }

  String getUserName() {
    return _prefs.getString("userName") ?? "Unknown";
  }

  updateUser(String newName) {
    _prefs.setString("userName", newName);
    notifyListeners();
  }
}
