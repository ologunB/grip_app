import 'dart:ui';

import 'package:hexcelon/core/models/login_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../vms/settings_vm.dart';
import 'objectbox.dart';

late ObjectBox objectbox;

class AppCache {
  static const String kUserBox = 'userBox';
  static const String kDefaultBox = 'defaultBox';
  static const String userKey = 'userKey';
  static const String bibleKey = 'bibleKey';
  static const String bibleFontKey = 'bibleFontKey';
  static const String darkModeKey = 'darkModeKey';
  static const String bibleWeightKey = 'bibleWeighttKey';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(kUserBox);
    await Hive.openBox<dynamic>(kDefaultBox);
    objectbox = await ObjectBox.create();
  }

  static Box<dynamic> get _userBox => Hive.box<dynamic>(kUserBox);
  static Box<dynamic> get _defaultBox => Hive.box<dynamic>(kDefaultBox);

  static dynamic getBibleWeights() {
    return _defaultBox.get(bibleWeightKey, defaultValue: {});
  }

  static Future<void> setBibleWeights(String name, int value) async {
    dynamic data = getBibleWeights();
    data.update(name, (a) => value, ifAbsent: () => value);
    _defaultBox.put(bibleWeightKey, data);
  }

  static String getDarkMode() {
    final brightness = PlatformDispatcher.instance.platformBrightness;

    // print(brightness.name);
    return _defaultBox.get(darkModeKey, defaultValue: brightness.name);
  }

  static Future<void> setDarkMode() async {
    String mode = getDarkMode() == 'dark' ? 'light' : 'dark';
    settingsVM.currentBrightness = mode;
    await _defaultBox.put(darkModeKey, mode);
  }

  static double getBibleFont() {
    return _defaultBox.get(bibleFontKey, defaultValue: 0.4);
  }

  static Future<void> setBibleFont(double a) async {
    _defaultBox.put(bibleFontKey, a);
  }

  static String? getDefaultBible() {
    return _defaultBox.get(bibleKey);
  }

  static Future<void> setDefaultBible(String? a) async {
    await _defaultBox.put(bibleKey, a);
    settingsVM.currentBible = a;
    objectbox.putAllData();
  }

  static void setUser(LoginModel a) {
    _userBox.put(userKey, a.toJson());
  }

  static LoginModel? getUser() {
    dynamic d = _userBox.get(userKey);
    if (d == null) return null;
    return LoginModel.fromJson(d);
  }

  static Future<void> clear() async {
    await _userBox.clear();
  }

  static void clean(String key) {
    _userBox.delete(key);
  }

  static String? get(String key) {
    return _defaultBox.get(key, defaultValue: '');
  }

  static Future<void> put(String key, String? value) async {
    await _defaultBox.put(key, value);
  }
}
