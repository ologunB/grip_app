import 'dart:async';

import 'package:hexcelon/core/apis/base_api.dart';

import '../models/login_model.dart';
import '../models/post_model.dart';

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

  final StreamController<Map<int, Post>> _postsController =
      StreamController<Map<int, Post>>.broadcast();
  Sink<Map<int, Post>> get _inPosts => _postsController.sink;
  Stream<Map<int, Post>> get outPosts => _postsController.stream;
  Map<int, Post> _currentPosts = {};
  Map<int, Post> get currentPosts => _currentPosts;

  set currentPosts(Map<int, Post> i) {
    _currentPosts = i;
    _inPosts.add(i);
  }

  final StreamController<Map<int, UserModel>> _usersController =
      StreamController<Map<int, UserModel>>.broadcast();
  Sink<Map<int, UserModel>> get _inUsers => _usersController.sink;
  Stream<Map<int, UserModel>> get outUsers => _usersController.stream;
  Map<int, UserModel> _currentUsers = {};
  Map<int, UserModel> get currentUsers => _currentUsers;

  set currentUsers(Map<int, UserModel> i) {
    _currentUsers = i;
    _inUsers.add(i);
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
