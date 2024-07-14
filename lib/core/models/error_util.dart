import '../apis/base_api.dart';

class DioErrorUtil {
  static String handleError(dynamic error) {
    String errorDescription = 'An error happened';
    if (error is DioException) {
      errorDescription = error.message ?? '';
      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Request to server was cancelled';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Slow Connection';
          break;
        case DioExceptionType.unknown:
          errorDescription = 'No internet connection';
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Failed to receive data from server';
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = 'Failed to send data to server';
          break;
        case DioExceptionType.badCertificate:
          errorDescription = 'Server Bad Certificate';
          break;
        case DioExceptionType.badResponse:
          errorDescription = 'Bad Response';
          break;
        case DioExceptionType.connectionError:
          errorDescription = 'Bad internet connection, failed to connect';
          break;
      }
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
