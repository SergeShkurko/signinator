import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Observable<bool> observable) {
    notifyListeners();
    observable.observe((_) => notifyListeners());
  }
}
