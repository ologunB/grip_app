import 'package:dio/dio.dart';

class DioErrorUtil {
  static String handleError(dynamic error) {
    String errorDescription = '';
    if (error is DioException) {
      errorDescription = 'No internet connection';
    } else if (error is DioExceptionType) {
      switch (error) {
        case DioExceptionType.cancel:
          errorDescription = 'Request to API server was cancelled';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Slow Connection';
          break;
        case DioExceptionType.unknown:
          errorDescription = 'No internet connection';
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Receive timeout in connection with API server';
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = 'Send timeout in connection with API server';
          break;

        case DioExceptionType.badCertificate:
          errorDescription = 'Bad Certificate';
          break;
        case DioExceptionType.badResponse:
          errorDescription = 'Bad Response';
          break;
        case DioExceptionType.connectionError:
          errorDescription = 'Connection Error';
          break;
      }
    } else if (error is TypeError) {
      errorDescription = error.stackTrace.toString();
    } else {
      errorDescription = error.toString();
    }

    return errorDescription;
  }
}

class GripException implements Exception {
  GripException(this.message);

  String message;
}
