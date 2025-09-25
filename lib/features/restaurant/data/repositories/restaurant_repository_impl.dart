// lib/features/restaurant/data/repositories/restaurant_repository_impl.dart (Data - Repo Impl)
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_remote_data_source.dart';
import '../models/restaurant_model.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;

  RestaurantRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurants() async {
    try {
      final remoteRestaurants = await remoteDataSource.getRestaurants();
      return Right(remoteRestaurants.map((model) => model.toEntity()).toList());
    } on ServerFailure {
      return Left(const ServerFailure(message: 'Server Error'));
    } catch (e) {
      return Left(const ServerFailure(message: 'Unexpected Error'));
    }
  }
}

extension RestaurantModelToEntity on RestaurantModel {
  Restaurant toEntity() => Restaurant(
        id: this.id,
        name: this.name,
        imageUrl: this.imageUrl,
        rating: this.rating,
        cuisine: this.cuisine,
      );
}