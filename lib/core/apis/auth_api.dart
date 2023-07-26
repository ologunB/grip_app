import 'base_api.dart';

class AuthApi extends BaseAPI {
  Future<LoginResponse> signup(Map<String, dynamic> data) async {
    String url = 'users/v1/auth/register';
    log(data);
    try {
      final Response res = await dio().post(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case 201:
          return LoginResponse.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<KycModel> getKyc() async {
    String url = 'users/v1/kyc/${AppCache.getUser()?.user?.id}';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      log(res.statusCode);
      switch (res.statusCode) {
        case 200:
          return KycModel.fromJson(res.data['data']['kyc']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<LoginResponse> verify(Map<String, dynamic> data) async {
    String url = 'users/v1/auth/verify-account';
    log(data);
    try {
      final Response res = await dio().post(url, data: data);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return LoginResponse.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<LoginResponse> resendOTP(String? id) async {
    String url = 'users/v1/auth/resend-otp';
    try {
      final Response res = await dio().post(url, data: {'userId': id});
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return LoginResponse.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> createPin(String pin) async {
    String url = 'users/v1/set-pin';
    log(pin);
    try {
      final Response res = await dio().post(url, data: {'pin': pin});
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return true;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> validatePin(String pin) async {
    String url = 'users/v1/validate-transaction-pin';
    log(pin);
    try {
      final Response res = await dio().post(url, data: {'pin': pin});
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return true;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> updatePin(String pin) async {
    String url = 'users/v1/set-pin';
    log(pin);
    try {
      final Response res = await dio().put(url, data: {'pin': pin});
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return true;
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<LoginResponse> login(Map<String, dynamic> data) async {
    String url = 'users/v1/auth/login';
    log(data);
    try {
      final Response res = await dio().post(url, data: data);
      log(res.data);
      log(res.statusCode);
      switch (res.statusCode) {
        case 201:
          return LoginResponse.fromJson(res.data['data']);
        case 200:
          if (res.data['data'].isEmpty) throw 'Invalid phone number';
          return LoginResponse.fromJson(res.data['data']);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<LoginResponse> getUser() async {
    String url = 'users/v1/auth/${AppCache.getUser()?.user?.id}';
    try {
      final Response res = await dio().get(url);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return LoginResponse.fromJson(res.data);
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<String> generateResetPassword(String phoneNumber) async {
    String url = 'users/v1/auth/forgot-password';
    try {
      final Response res =
          await dio().post(url, data: {'phoneNumber': phoneNumber});
      log(res.statusCode);
      log(res.data);
      switch (res.statusCode) {
        case 200:
          return res.data['data']['token'];
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> resetPassword(Map<String, dynamic> data) async {
    String url = 'users/v1/auth/reset-password';
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
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  // KYC

  Future<bool> verifyBVN(String val, String link) async {
    String url = 'users/v1/kyc/validate-bvn';
    try {
      final Response res =
          await dio().post(url, data: {'bvn': val, 'image': link});
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
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> verifyDocument(Map<String, dynamic> data) async {
    String url = 'users/v1/kyc/validate-identity';
    log(data);
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
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<bool> verifyAddress(Map<String, dynamic> data) async {
    String url = 'users/v1/kyc/address-validation';
    log(data);
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
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }

  Future<String> uploadMedia(File image) async {
    String url = 'media/v1/upload/image';
    try {
      FormData forms = FormData();
      forms.files.add(
        MapEntry<String, MultipartFile>(
          'file',
          MultipartFile.fromFileSync(
            image.path,
            filename: image.path.split('/').last,
          ),
        ),
      );

      final Response res = await dio().post(url, data: forms);
      log(res.data);
      switch (res.statusCode) {
        case 201:
          return res.data['data']['media'].first['path']['download'];
        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      throw ZoperException(DioErrorUtil.handleError(e));
    }
  }
}
