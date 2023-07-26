import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static final _navKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navKey => _navKey;

  static bool get canPop => _navKey.currentState!.canPop();
  static void doPop([result]) {
    if (canPop) return _navKey.currentState!.pop(result);
  }

  static Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateToAndReplace(String routeName,
      {dynamic arguments}) {
    return _navKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateToAndClear(String routeName,
      {dynamic arguments}) {
    return _navKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}
