import 'dart:collection';

import 'package:uuid/uuid.dart';

import '../models/comment_model.dart';
import '../models/post_model.dart';
import 'base_api.dart';

class PostApi extends BaseAPI {
  Future<Post> createPost(Map<String, dynamic> data, List? files) async {
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
          await dio().post(url, data: forms, onSendProgress: (a, b) {});
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

  Future<List<NotificationModel>> getNotifications() async {
    String url = 'notification';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          List<NotificationModel> dirs = [];
          (res.data['data'] ?? []).forEach((a) {
            dirs.add(NotificationModel.fromJson(a));
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

  Future<bool> updateNotification(int? id) async {
    String url = 'notification/$id';
    try {
      final Response res = await dio().patch(url);
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

  Future<LinkedHashMap<int, Comment>> getComments(int? id) async {
    String url = 'comment/$id?page=1&limit=100';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          LinkedHashMap<int, Comment> dirs = LinkedHashMap();
          (res.data['data'] ?? []).forEach((a) {
            Comment c = Comment.fromJson(a);
            dirs[c.id!] = c;
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

  Future<bool> updatePost(int? id, Map<String, dynamic> data) async {
    String url = 'post/$id';
    log(data);
    try {
      final Response res = await dio().patch(url, data: data);
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

  Future<bool> deletePost(int? id) async {
    String url = 'post/$id';
    try {
      final Response res = await dio().delete(url);
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

  Future<Post> getPostDetails(int? id) async {
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

  Future<List<Post>> getPosts({String? type}) async {
    String url = 'post/$type';
    print(url);
    try {
      final Response res = await dio().get(url);
      switch (res.statusCode) {
        case 200:
          List<Post> dirs = [];
          log(res.data);
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

  Future<String> likePost(int? id) async {
    String url = 'like';
    try {
      final Response res = await dio().post(url, data: {'postId': id});
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return res.data['message'];
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> likeComment(int? postId, int? commentId) async {
    String url = 'like/comment';
    try {
      final Response res = await dio()
          .post(url, data: {'postId': postId, 'commentId': commentId});
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

  Future<bool> addBookmark(int? id) async {
    String url = 'bookmark';
    try {
      final Response res = await dio().post(url, data: {'postId': id});
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

  Future<bool> deleteBookmark(int? id) async {
    String url = 'bookmark/$id';
    try {
      final Response res = await dio().delete(url);
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

  Future<List<Post>> getBookmarks() async {
    String url = 'bookmark';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          List<Post> dirs = [];
          (res.data['data'] ?? []).forEach((a) {
            dirs.add(Post.fromJson(a['post']));
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
}
