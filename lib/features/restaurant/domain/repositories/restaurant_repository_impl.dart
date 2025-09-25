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
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

extension RestaurantModelToEntity on RestaurantModel {
  Restaurant toEntity() => Restaurant(
        id: id,
        name: name,
        imageUrl: imageUrl,
        rating: rating,
        cuisine: cuisine,
      );
}