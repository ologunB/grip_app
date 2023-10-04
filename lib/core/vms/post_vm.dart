import 'dart:collection';

import 'package:hexcelon/core/vms/settings_vm.dart';

import '../../core/apis/post_api.dart';
import '../models/comment_model.dart';
import '../models/error_util.dart';
import '../models/post_model.dart';
import 'base_vm.dart';

class PostViewModel extends BaseModel {
  final PostApi _api = locator<PostApi>();
  String? error;

  Future<bool> createPost(Map<String, dynamic> a, List files) async {
    setBusy(true);
    try {
      await _api.createPost(a, files);
      setBusy(false);
      return true;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> updatePost(int? id, Map<String, dynamic> a) async {
    setBusy(true);
    try {
      await _api.updatePost(id, a);
      //  print(res.id);
      setBusy(false);
      return true;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> deletePost(int? id) async {
    setBusy(true);
    try {
      await _api.deletePost(id);
      setBusy(false);
      return true;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> likePost(int? a) async {
    try {
      String msg = await _api.likePost(a);
      if (settingsVM.currentPosts[a] != null) {
        Post post = settingsVM.currentPosts[a]!;
        post.isLiked = msg == 'Liked';
        settingsVM.currentPosts.update(a!, (value) => post);
      }
      return true;
    } on GripException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> likeComment(int? postId, int? commentId) async {
    try {
      await _api.likeComment(postId, commentId);
      return true;
    } on GripException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> addBookmark(int? a) async {
    try {
      await _api.addBookmark(a);
      if (settingsVM.currentPosts[a] != null) {
        Post post = settingsVM.currentPosts[a]!;
        post.isBooked = true;
        settingsVM.currentPosts.update(a!, (value) => post);
      }
      return true;
    } on GripException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> deleteBookmark(int? a) async {
    try {
      await _api.deleteBookmark(a);
      if (settingsVM.currentPosts[a] != null) {
        Post post = settingsVM.currentPosts[a]!;
        post.isBooked = false;
        settingsVM.currentPosts.update(a!, (value) => post);
      }
      return true;
    } on GripException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  List<NotificationModel>? notifications;
  Future<void> getNotifications() async {
    setBusy(true);
    try {
      notifications = await _api.getNotifications();
      setBusy(false);
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  List<Post>? bookmarks;
  Future<void> getBookmarks() async {
    setBusy(true);
    try {
      bookmarks = await _api.getBookmarks();
      setBusy(false);
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  List? searchResults;
  int current = 0;
  List<int> following = [];

  Future<void> search(String q) async {
    setBusy(true);
    try {
      searchResults = await _api.search(q);
      if (searchResults!.first.isEmpty) {
        current = 1;
      } else if (searchResults!.last.isEmpty) {
        current = 0;
      }
      searchResults!.last.forEach((UserModel u) {
        if (u.isFollow ?? false) {
          following.add(u.id!);
        }
      });
      setBusy(false);
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  late Post post;
  Future<void> getPostDetails(int? id) async {
    if (settingsVM.currentPosts[id] != null) {
      post = settingsVM.currentPosts[id]!;
      return;
    }
    setBusy(true);
    try {
      post = await _api.getPostDetails(id);
      Map<int, Post> present = settingsVM.currentPosts;
      present.update(post.id!, (a) => post, ifAbsent: () => post);
      settingsVM.currentPosts = present;

      Map<int, UserModel> users = settingsVM.currentUsers;

      UserModel u = post.user!;
      u.isFollow = post.isFollow;
      users.update(post.userId!, (a) => u, ifAbsent: () => u);

      setBusy(false);
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  List<Post>? posts;
  Future<void> getPosts({String? type}) async {
    setBusy(true);
    try {
      posts = await _api.getPosts(type: type);
      setBusy(false);
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }

  Future<List<Post>?> getNextPosts(int? id, String? type) async {
    setBusy(true);
    try {
      List<Post>? p = await _api.getNextPosts(id, type);
      setBusy(false);
      return p;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return null;
    }
  }

  LinkedHashMap<int, Comment>? comments;
  Future<bool> createComment(Map<String, dynamic> a) async {
    int tempId = DateTime.now().microsecondsSinceEpoch;
    try {
      Comment c = Comment(
        id: tempId,
        comment: a['comment'],
        postId: a['postId'],
        createdAt: DateTime.now().toIso8601String(),
        user: AppCache.getUser()?.user,
        isLike: false,
        likesCount: '0',
      );

      comments?[tempId] = c;
      List<MapEntry<int, Comment>> entries = comments!.entries.toList();
      entries.sort((b, a) => a.key.compareTo(b.key));
      comments = LinkedHashMap.fromEntries(entries);

      Comment c2 = await _api.createComment(a);
      c.id = c2.id;

      entries.sort((b, a) => a.key.compareTo(b.key));
      for (int i = 0; i < entries.length; i++) {
        if (entries[i].key == tempId) {
          entries[i] = MapEntry(c2.id!, c);
          break;
        }
      }
      comments = LinkedHashMap.fromEntries(entries);

      return true;
    } on GripException catch (e) {
      error = e.message;
      comments?.remove(tempId);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<void> getComments(int? id) async {
    setBusy(true);
    try {
      comments = await _api.getComments(id);
      setBusy(false);
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
    }
  }
}
