import '../models/post_model.dart';
import 'base_api.dart';

class PostApi extends BaseAPI {
  Future<Post> create(Map<String, dynamic> data, List<File>? files) async {
    String url = 'post';
    log(data);
    files = files ?? [];
    FormData forms = FormData.fromMap(data);
    for (var file in files) {
      forms.files.add(
        MapEntry<String, MultipartFile>(
          'files',
          MultipartFile.fromFileSync(file.path,
              filename: file.path.split('/').last),
        ),
      );
    }

    try {
      final Response res = await dio().post(url, data: forms);
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

  Future<List<Post>> getAllUserPosts() async {
    String url = 'post';
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

  Future<List<Post>> getAllPosts() async {
    String url = 'post/all';
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
}
