import 'package:dio/dio.dart';
import 'package:quran_kareem/core/error/expetions.dart';

class ApiErrorHandler {
  static Exception handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const FetchDataException();
        case DioExceptionType.badResponse:
        // Try to extract message from response data
          String? errorMessage;

          if (error.response?.data != null) {
            final data = error.response?.data;
            // Handle case where message is a List instead of String
            if (data?['message'] is List) {
              final messageList = data?['message'] as List;
              errorMessage =
              messageList.isNotEmpty ? messageList.first.toString() : null;
            } else if (data?['message'] is String) {
              errorMessage = data?['message'] as String;
            } else if (data?['error'] is String) {
              errorMessage = data?['error'] as String;
            } else if (data is String) {
              errorMessage = data;
            }
          }

          switch (error.response?.statusCode) {
            case 400:
              return BadRequestException(errorMessage);
            case 401:
              return UnauthorizedException(errorMessage ??
                  'Your session has expired. Please login again.');
            case 403:
              return ForbiddenException(errorMessage);
            case 404:
              return NotFoundException(errorMessage);
            case 409:
              return ConflictException(errorMessage);
            case 422:
              return UnprocessableEntityException(errorMessage);
            case 500:
              return InternalServerErrorException(errorMessage);
            default:
              return FetchDataException(errorMessage ??
                  'Error occurred while communicating with server with status code: ${error.response?.statusCode}');
          }
        case DioExceptionType.cancel:
          return FetchDataException('Request was cancelled');
        case DioExceptionType.unknown:
          if (error.error != null &&
              error.error.toString().contains('SocketException')) {
            return const NoInternetConnectionException();
          }
          return FetchDataException(error.message);
        default:
          return FetchDataException(error.message);
      }
    } else if (error is TypeError) {
      // Handle type errors that might come from JSON parsing
      return FetchDataException(
          "Data format error. The app may need to be updated or the server returned unexpected data.");
    } else if (error is Exception) {
      return FetchDataException(error.toString());
    } else {
      return FetchDataException(error?.toString() ?? "Unknown error occurred");
    }
  }
}
