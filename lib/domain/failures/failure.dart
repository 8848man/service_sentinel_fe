/// Base failure class
abstract class Failure {
  final String message;

  const Failure(this.message);
}

/// Server failure (API errors)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Network failure (connection errors)
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Cache failure (local storage errors)
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Validation failure (input validation errors)
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
