import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:logger/logger.dart';

import '../models/login_model.dart';
import '../storage/local_storage.dart';

export 'dart:io';

export 'package:dio/dio.dart';

export '../models/error_util.dart';
export '../storage/local_storage.dart';

class BaseAPI {
  Dio dio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        sendTimeout: const Duration(seconds: 50),
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
        contentType: 'application/json',
        validateStatus: (int? s) => s! < 500,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (res, handler) {
          String? token = AppCache.getUser()?.token;
          if (token != null) res.headers['Authorization'] = 'Bearer $token';
          return handler.next(res);
        },
        onResponse: (res, handler) async {
          if (res.statusCode == 401 &&
              res.data['message'] == 'Please authenticate') {
            try {
              await refreshToken();
            } catch (e) {
              return handler.next(res);
            }
            return handler.resolve(await _retry(res.requestOptions));
          }

          return handler.next(res);
        },
      ),
    );

    return dio;
  }

  String get baseUrl => GlobalConfiguration().get('base_url');

  Future<void> refreshToken() async {
    String url = '${baseUrl}users/v1/auth/refresh-tokens';
    try {
      final Response<dynamic> res = await Dio().post<dynamic>(url,
          data: {'refreshToken': AppCache.getUser()?.token});
      log(res.data);
      log(res.statusCode);
      switch (res.statusCode) {
        case 200:
          AppCache.setUser(LoginModel.fromJson(res.data));
          break;
        default:
          throw 'Please login again';
      }
    } catch (ex) {
      AppCache.clear();

      log(ex);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio().request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  log(dynamic data) {
    Logger l = Logger();
    l.d(data);
  }

  String error(dynamic data) {
    if (data['data'] == null) {
      return data['message'] ?? 'An error occurred';
    } else {
      return data['data'].map((map) => map.values.join(', ')).join('\n');
    }
  }
}
