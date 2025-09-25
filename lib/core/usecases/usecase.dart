// lib/core/usecases/usecase.dart (SOLID: Dependency Inversion - Abstract usecases)
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}