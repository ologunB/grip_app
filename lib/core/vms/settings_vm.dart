import 'dart:async';

import 'package:hexcelon/core/apis/base_api.dart';

class SettingsVM {
  final StreamController<Map<String, int>> _downloadsController =
      StreamController<Map<String, int>>.broadcast();
  Sink<Map<String, int>> get _inMainDownloads => _downloadsController.sink;
  Stream<Map<String, int>> get outMainDownloads => _downloadsController.stream;
  Map<String, int> _currentDownloads = {};
  Map<String, int> get currentDownloads => _currentDownloads;

  set currentDownloads(Map<String, int> i) {
    _currentDownloads = i;
    _inMainDownloads.add(i);
  }

  final StreamController<String?> _bibleController =
      StreamController<String?>.broadcast();
  Sink<String?> get _inMainBible => _bibleController.sink;
  Stream<String?> get outMainBible => _bibleController.stream;
  String? _currentBible = AppCache.getDefaultBible();
  String? get currentBible => _currentBible;

  set currentBible(String? i) {
    _currentBible = i;
    _inMainBible.add(i);
  }
}

SettingsVM settingsVM = SettingsVM();
