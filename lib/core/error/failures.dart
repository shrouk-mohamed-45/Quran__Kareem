import 'package:equatable/equatable.dart';
import 'package:quran_kareem/core/utils/app_strings.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});
  @override
  List<Object> get props => [message ?? ''];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});
}

class LocalFailure extends Failure {
  const LocalFailure({super.message});
}

/// Specific failure for network connectivity issues
class NetworkFailure extends Failure {
  const NetworkFailure({String? message})
      : super(message: message ?? AppStrings.noInternetConnection);
}
