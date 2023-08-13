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

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(kUserBox);
    await Hive.openBox<dynamic>(kDefaultBox);
    objectbox = await ObjectBox.create();
  }

  static Box<dynamic> get _userBox => Hive.box<dynamic>(kUserBox);
  static Box<dynamic> get _defaultBox => Hive.box<dynamic>(kDefaultBox);

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
