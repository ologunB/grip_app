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
      Post res = await _api.create(a, files);
      print(res.id);
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
      await _api.likePost(a);
      return true;
    } on GripException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> unlikePost(int? a) async {
    try {
      await _api.unlikePost(a);
      return true;
    } on GripException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> likeComment(int? a) async {
    setBusy(true);
    try {
      await _api.likeComment(a);
      return true;
    } on GripException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> unlikeComment(int? a) async {
    try {
      await _api.unlikeComment(a);
      return true;
    } on GripException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> bookmark(int? a) async {
    try {
      Post res = await _api.bookmark(a);
      print(res.id);
      return true;
    } on GripException catch (e) {
      error = e.message;
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  List<Post>? bookmarks;
  Future<bool> getBookmarks() async {
    setBusy(true);
    try {
      bookmarks = await _api.getBookmarks();
      setBusy(false);
      return true;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
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

  List<Comment>? comments;
  Future<bool> createComment(Map<String, dynamic> a) async {
    try {
      comments?.insert(
        0,
        Comment(
          comment: a['comment'],
          postId: a['postId'],
          createdAt: DateTime.now().toIso8601String(),
          user: AppCache.getUser()?.user,
        ),
      );
      await _api.createComment(a);
      return true;
    } on GripException catch (e) {
      error = e.message;
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
