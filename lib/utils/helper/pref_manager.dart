import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ActiveTheme {
  light(ThemeMode.light),
  dark(ThemeMode.dark),
  system(ThemeMode.system);

  final ThemeMode mode;

  const ActiveTheme(this.mode);
}

class PrefManager {
  String kIsLogin = "isLogin";
  String kToken = "token";

  /// Light, Dark ,System

  SharedPreferences preferences;

  PrefManager(this.preferences);

  set isLogin(bool value) => preferences.setBool(kIsLogin, value);

  bool get isLogin => preferences.getBool(kIsLogin) ?? false;

  set token(String? value) => preferences.setString(kToken, value ?? "");

  String? get token => preferences.getString(kToken);

  void logout() => preferences.clear();
}
