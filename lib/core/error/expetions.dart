import 'package:equatable/equatable.dart';
import 'package:quran_kareem/core/utils/app_strings.dart';
 
class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class FetchDataException extends ServerException {
  const FetchDataException([String? message])
      : super(message ?? AppStrings.errorDuringCommunication);
}

class BadRequestException extends ServerException {
  const BadRequestException([String? message])
      : super(message ?? AppStrings.badRequest);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([String? message])
      : super(message ?? AppStrings.unauthorized);
}

class NotFoundException extends ServerException {
  const NotFoundException([String? message])
      : super(message ?? AppStrings.requestedInfoNotFound);
}

class ConflictException extends ServerException {
  const ConflictException([String? message])
      : super(message ?? AppStrings.conflictOccurred);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([String? message])
      : super(message ?? AppStrings.internalServerError);
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([String? message])
      : super(message ?? AppStrings.noInternetConnection);
}

class UnprocessableEntityException extends ServerException {
  const UnprocessableEntityException([String? message])
      : super(message ?? AppStrings.unprocessableEntity);
}

class ForbiddenException extends ServerException {
  const ForbiddenException([String? message])
      : super(message ?? AppStrings.forbidden);
}

class CacheException implements Exception {
  
}
