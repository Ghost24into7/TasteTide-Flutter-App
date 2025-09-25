// lib/features/restaurant/presentation/bloc/restaurant_bloc.dart (Presentation - BLoC)
import 'package:bloc/bloc.dart';
import '../../../../core/usecases/usecase.dart';

import '../../domain/usecases/get_restaurants.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

const String _messageServerFailure = 'Server Failure';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final GetRestaurants getRestaurantsUseCase;

  RestaurantBloc({required this.getRestaurantsUseCase}) : super(RestaurantInitial()) {
    on<LoadRestaurants>(_onLoadRestaurants);
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());
    final failureOrRestaurants = await getRestaurantsUseCase(NoParams());
    failureOrRestaurants.fold(
      (failure) => emit(RestaurantError(message: _messageServerFailure)),
      (restaurants) => emit(RestaurantLoaded(restaurants: restaurants)),
    );
  }
}