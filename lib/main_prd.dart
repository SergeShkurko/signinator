import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signinator/config.dart';
import 'package:signinator/dependencies_injection.dart';
import 'package:signinator/signinator_app.dart';

Future<void> main() async {
  /// Register Service locator
  await serviceLocator();

  WidgetsFlutterBinding.ensureInitialized();

  /// Set env as production
  environment = Environment.production;

  runZonedGuarded(
    /// Lock device orientation to portrait
    () => SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    ).then((_) async {
      /// Load SharedPref before load My App Widget
      SharedPreferences.getInstance().then((value) {
        initPrefManager(value);
        runApp(const SigninatorApp());
      });
    }),
    (error, stackTrace) async {
      // TODO(Serge): catch error in Sentry / Firebase crashlytics
    },
  );
}
