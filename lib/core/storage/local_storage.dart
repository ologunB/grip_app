import 'package:hexcelon/core/models/login_response.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  static int? getDefaultBible() {
    return _defaultBox.get(bibleKey);
  }

  static void setDefaultBible(int a) {
    _defaultBox.put(bibleKey, a);
  }

  static void setUser(LoginResponse a) {
    _userBox.put(userKey, a.toJson());
  }

  static LoginResponse? getUser() {
    dynamic d = _userBox.get(userKey);
    if (d == null) return null;
    return LoginResponse.fromJson(d);
  }

  static Future<void> clear() async {
    await _userBox.clear();
  }

  static void clean(String key) {
    _userBox.delete(key);
  }
}
