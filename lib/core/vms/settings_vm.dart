import 'dart:async';

class SettingsVM {
  final StreamController<int> _mainIndexController =
      StreamController<int>.broadcast();
  Sink<int> get _inMainIndex => _mainIndexController.sink;
  Stream<int> get outMainIndex => _mainIndexController.stream;
  int _currentIndex = 0;
  set currentIndex(int i) {
    _currentIndex = i;
    _inMainIndex.add(i);
  }

  int get currentIndex => _currentIndex;
}

SettingsVM settingsVM = SettingsVM();
