// lib/features/restaurant/presentation/bloc/restaurant_state.dart
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/restaurant.dart';

abstract class RestaurantState extends Equatable {
  final List<Restaurant>? restaurants;
  final String? message;
  const RestaurantState({this.restaurants, this.message});

  @override
  List<Object?> get props => [restaurants, message];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  const RestaurantLoaded({required List<Restaurant> restaurants}) : super(restaurants: restaurants);
}

class RestaurantError extends RestaurantState {
  const RestaurantError({required String message}) : super(message: message);
}