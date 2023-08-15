import 'package:uuid/uuid.dart';

import '../models/comment_model.dart';
import '../models/post_model.dart';
import 'base_api.dart';

class PostApi extends BaseAPI {
  Future<Post> create(Map<String, dynamic> data, List? files) async {
    String url = 'post';
    log(data);
    files = files ?? [];
    FormData forms = FormData.fromMap(data);
    forms.files.add(
      MapEntry<String, MultipartFile>(
        'files',
        MultipartFile.fromBytes(files.first, filename: const Uuid().v4()),
      ),
    );
    // cover picture
    forms.files.add(
      MapEntry<String, MultipartFile>(
        'files',
        MultipartFile.fromFileSync(files.last.path,
            filename: files.last.path.split('/').last),
      ),
    );

    try {
      final Response res =
          await dio().post(url, data: forms, onSendProgress: (a, b) {
        print((a, b));
      });
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return Post.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<Comment> createComment(Map<String, dynamic> data) async {
    String url = 'comment';
    log(data);
    try {
      final Response res = await dio().post(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return Comment.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<Post> bookmark(int? id) async {
    String url = 'bookmark';
    try {
      final Response res = await dio().post(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return Post.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<Post>> getBookmarks(int? id) async {
    String url = 'post/$id';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          List<Post> dirs = [];
          (res.data['data'] ?? []).forEach((a) {
            dirs.add(Post.fromJson(a));
          });
          return dirs;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<Comment>> getComments(int? id) async {
    String url = 'post/$id';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          List<Comment> dirs = [];
          (res.data['data'] ?? []).forEach((a) {
            dirs.add(Comment.fromJson(a));
          });
          return dirs;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<Post> update(String? id, Map<String, dynamic> data) async {
    String url = 'post/$id';
    log(data);
    try {
      final Response res = await dio().post(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return Post.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<Post> getDetails(String? id) async {
    String url = 'post/$id';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return Post.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<Post>> getPosts({String? type = 'all'}) async {
    String url = type == 'all' ? 'post' : 'post/all';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          List<Post> dirs = [];
          (res.data['data'] ?? []).forEach((a) {
            dirs.add(Post.fromJson(a));
          });
          return dirs;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> likePost(int? id) async {
    String url = 'like';
    try {
      final Response res = await dio().post(url, data: {'creatorId': id});
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return true;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> unlikePost(int? id) async {
    String url = 'like/remove';
    try {
      final Response res = await dio().post(url, data: {'creatorId': id});
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return true;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }


  Future<bool> likeComment(int? id) async {
    String url = 'like';
    try {
      final Response res = await dio().post(url, data: {'creatorId': id});
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return true;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> unlikeComment(int? id) async {
    String url = 'like/remove';
    try {
      final Response res = await dio().post(url, data: {'creatorId': id});
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return true;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }
}
