// lib/features/restaurant/domain/repositories/restaurant_repository.dart (Domain - Interface)
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/restaurant.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurants();
}