// test/features/restaurant/presentation/bloc/restaurant_bloc_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:nestafar_assignment/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:nestafar_assignment/features/restaurant/presentation/bloc/restaurant_event.dart';
import 'package:nestafar_assignment/features/restaurant/presentation/bloc/restaurant_state.dart';
import 'package:nestafar_assignment/features/restaurant/domain/entities/restaurant.dart';
import 'package:nestafar_assignment/features/restaurant/domain/usecases/get_restaurants.dart';
import 'package:nestafar_assignment/core/error/failures.dart';

import 'restaurant_bloc_test.mocks.dart';

@GenerateMocks([GetRestaurants])
void main() {
  group('RestaurantBloc', () {
    late RestaurantBloc restaurantBloc;
    late MockGetRestaurants mockGetRestaurants;

    setUp(() {
      mockGetRestaurants = MockGetRestaurants();
      restaurantBloc = RestaurantBloc(getRestaurantsUseCase: mockGetRestaurants);
    });

    tearDown(() {
      restaurantBloc.close();
    });

    const tRestaurants = [
      Restaurant(
        id: 1,
        name: 'Test Restaurant',
        imageUrl: 'https://example.com/restaurant.jpg',
        rating: 4.5,
        cuisine: 'American',
      ),
    ];

    test('initial state is RestaurantInitial', () {
      expect(restaurantBloc.state, equals(RestaurantInitial()));
    });

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantLoaded] when LoadRestaurants succeeds',
      build: () {
        when(mockGetRestaurants.call(any))
            .thenAnswer((_) async => const Right(tRestaurants));
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        RestaurantLoading(),
        const RestaurantLoaded(restaurants: tRestaurants),
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantError] when LoadRestaurants fails',
      build: () {
        when(mockGetRestaurants.call(any))
            .thenAnswer((_) async => const Left(ServerFailure(message: 'Server Error')));
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        RestaurantLoading(),
        const RestaurantError(message: 'Server Failure'),
      ],
    );
  });
}