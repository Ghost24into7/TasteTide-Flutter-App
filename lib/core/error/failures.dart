// lib/core/error/failures.dart (SOLID: Single Responsibility - Dedicated error types)
abstract class Failure {
  const Failure();
}

class ServerFailure extends Failure {
  final String message;
  const ServerFailure({required this.message});
}

class CacheFailure extends Failure {
  const CacheFailure();
}