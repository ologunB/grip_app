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
      Post res = await _api.updatePost(id, a);
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

  Future<bool> createComment(Map<String, dynamic> a) async {
    setBusy(true);
    try {
      Comment res = await _api.createComment(a);
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

  Future<bool> likePost(int? a) async {
    setBusy(true);
    try {
      await _api.likePost(a);
      setBusy(false);
      return true;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> unlikePost(int? a) async {
    setBusy(true);
    try {
      await _api.unlikePost(a);
      setBusy(false);
      return true;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> likeComment(int? a) async {
    setBusy(true);
    try {
      await _api.likeComment(a);
      setBusy(false);
      return true;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> unlikeComment(int? a) async {
    setBusy(true);
    try {
      await _api.unlikeComment(a);
      setBusy(false);
      return true;
    } on GripException catch (e) {
      error = e.message;
      setBusy(false);
      showVMSnackbar(e.message, err: true);
      return false;
    }
  }

  Future<bool> bookmark(int? a) async {
    setBusy(true);
    try {
      Post res = await _api.bookmark(a);
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
