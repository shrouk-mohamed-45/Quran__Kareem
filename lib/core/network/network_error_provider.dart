import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:quran_kareem/core/error/expetions.dart';
import '../error/failures.dart';
import '../utils/app_strings.dart';
import 'network_info.dart';

class NetworkErrorProvider {
  final NetworkInfo networkInfo;

  NetworkErrorProvider({required this.networkInfo});

  /// Wraps network requests with connectivity checks and error handling
  /// If there's no network, returns a Left with a NetworkFailure
  /// This allows repositories to handle network errors consistently
  Future<Either<Failure, T>> handleNetworkCall<T>({
    required Future<T> Function() call,
  }) async {
    // Check if device is connected to internet
    if (await networkInfo.isConnected) {
      try {
        // Execute the network request
        final result = await call();
        return Right(result);
      } on DioException catch (error) {
        // Handle Dio specific errors
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout) {
          return const Left(
              NetworkFailure(message: 'Connection timeout. Please try again.'));
        }

        if (error.response?.statusCode == 401) {
          return const Left(ServerFailure(
              message: 'Your session has expired. Please login again.'));
        }

        // Extract message from error response
        String? errorMessage;
        if (error.response?.data != null) {
          final data = error.response?.data;
          if (data is Map<String, dynamic> && data.containsKey('message')) {
            if (data['message'] is List) {
              final messageList = data['message'] as List;
              errorMessage =
              messageList.isNotEmpty ? messageList.first.toString() : null;
            } else if (data['message'] is String) {
              errorMessage = data['message'] as String;
            }
          } else if (data is String) {
            errorMessage = data;
          }
        }

        // Create failure based on status code
        switch (error.response?.statusCode) {
          case 400:
            return Left(
                ServerFailure(message: errorMessage ?? AppStrings.badRequest));
          case 404:
            return Left(ServerFailure(
                message: errorMessage ?? AppStrings.requestedInfoNotFound));
          case 500:
            return Left(ServerFailure(
                message: errorMessage ?? AppStrings.internalServerError));
          default:
            return Left(ServerFailure(
                message: errorMessage ??
                    error.message ??
                    AppStrings.unexpectedError));
        }
      } on UnauthorizedException catch (e) {
        return Left(
            ServerFailure(message: e.message ?? AppStrings.unauthorized));
      } on FetchDataException catch (e) {
        return Left(ServerFailure(
            message: e.message ?? AppStrings.errorDuringCommunication));
      } on BadRequestException catch (e) {
        return Left(ServerFailure(message: e.message ?? AppStrings.badRequest));
      } on TypeError catch (_) {
        // Handle type errors which can happen during JSON parsing
        return const Left(ServerFailure(
            message:
            'Data format error. Please try again or contact support.'));
      } catch (error) {
        // General error handling
        return Left(ServerFailure(message: error.toString()));
      }
    } else {
      // Special network failure that can be handled differently
      return const Left(NetworkFailure());
    }
  }
}
