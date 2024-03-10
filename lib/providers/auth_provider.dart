import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/data/models/auth/user.dart';
import 'package:shopper/data/preferences/preferences_key.dart';

class AuthProvider with ChangeNotifier {
  static final AuthProvider _instance = AuthProvider._internal();
  factory AuthProvider() => _instance;

  AuthProvider._internal();

  User? _user;
  User? get user => _user;
  
  void login(User? user) {
    _user = user;
    notifyListeners();
  }

  void logout() async {
    _user = null;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.username, '');
    prefs.setString(PreferencesKey.password, '');

    notifyListeners();
  }
}
