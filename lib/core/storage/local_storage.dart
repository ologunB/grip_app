import 'package:hexcelon/core/models/login_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../vms/settings_vm.dart';

class AppCache {
  static const String kUserBox = 'userBoxx';
  static const String kDefaultBox = 'defaultBoxx';
  static const String userKey = 'userKeyccrgddewr';
  static const String bibleKey = 'bibleKey';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(kUserBox);
    await Hive.openBox<dynamic>(kDefaultBox);
  }

  static Box<dynamic> get _userBox => Hive.box<dynamic>(kUserBox);
  static Box<dynamic> get _defaultBox => Hive.box<dynamic>(kDefaultBox);

  static String? getDefaultBible() {
    return _defaultBox.get(bibleKey);
  }

  static void setDefaultBible(String? a) {
    _defaultBox.put(bibleKey, a);
    settingsVM.currentBible = a;
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
