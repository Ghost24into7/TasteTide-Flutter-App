// lib/injection_container.dart (DI for SOLID: Dependency Inversion)
import 'package:get_it/get_it.dart';
import 'features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'features/restaurant/domain/usecases/get_restaurants.dart';
import 'features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'features/restaurant/domain/repositories/restaurant_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => RestaurantBloc(getRestaurantsUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetRestaurants(sl()));

  // Repos
  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSourceImpl(),
  );
}