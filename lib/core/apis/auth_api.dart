import '../models/category_model.dart';
import '../models/login_model.dart';
import 'base_api.dart';

class AuthApi extends BaseAPI {
  Future<LoginModel> signup(Map<String, dynamic> data) async {
    String url = 'user/signup';
    log(data);
    try {
      final Response res = await dio().post(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case 201:
          return LoginModel.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<LoginModel> social(Map<String, dynamic> data) async {
    String url = 'user/social';
    log(data);
    try {
      final Response res = await dio().post(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case 201:
          return LoginModel.fromJson(res.data['data']);
        case 200:
          return LoginModel.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<List<Category>> getCategories() async {
    String url = 'category';
    try {
      final Response res = await dio().get(url);
      switch (res.statusCode) {
        case 200:
          List<Category> dirs = [];
          (res.data['data'] ?? []).forEach((a) {
            dirs.add(Category.fromJson(a));
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

  Future<List<UserModel>> getCreators() async {
    String url = 'user/creators';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          List<UserModel> dirs = [];
          (res.data['data'] ?? []).forEach((a) {
            dirs.add(UserModel.fromJson(a));
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

  Future<bool> resendOTP(String? email) async {
    String url = 'user/resend';
    try {
      final Response res = await dio().post(url, data: {'email': email});
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

  Future<bool> verify(Map<String, dynamic> data) async {
    String url = 'user/verify';
    try {
      final Response res = await dio().post(url, data: data);
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

  Future<UserModel> update(Map<String, dynamic> data) async {
    String url = 'user';
    try {
      final Response res = await dio().patch(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return UserModel.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> follow(String? id) async {
    String url = 'follow';
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

  Future<bool> unfollow(String? id) async {
    String url = 'follow/remove';
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

  Future<LoginModel> login(Map<String, dynamic> data) async {
    String url = 'user/login';
    try {
      final Response res = await dio().post(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return LoginModel.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<LoginModel> getUser() async {
    String url = 'user';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return LoginModel.fromJson(res.data);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> forgotPassword(String? email) async {
    String url = 'user/forgot';
    try {
      final Response res = await dio().post(url, data: {'email': email});
      log(res.statusCode);
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

  Future<bool> resetPassword(Map<String, dynamic> data) async {
    String url = 'user/reset';
    log(data);
    try {
      final Response res = await dio().post(url, data: data);
      log(res.data);
      log(res.statusCode);
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

  Future<bool> changePassword(Map<String, dynamic> data) async {
    String url = 'user/password';
    log(data);
    try {
      final Response res = await dio().post(url, data: data);
      log(res.data);
      log(res.statusCode);
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

  Future<String> uploadMedia(File image) async {
    String url = 'user/image';
    try {
      FormData forms = FormData();
      forms.files.add(
        MapEntry<String, MultipartFile>(
          'image',
          MultipartFile.fromFileSync(
            image.path,
            filename: image.path.split('/').last,
          ),
        ),
      );

      final Response res = await dio().patch(url, data: forms);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return res.data['data'];
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw GripException(DioErrorUtil.handleError(e));
    }
  }
}
