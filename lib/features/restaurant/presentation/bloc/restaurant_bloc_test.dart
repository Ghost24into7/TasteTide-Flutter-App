// test/features/restaurant/presentation/bloc/restaurant_bloc_test.dart (Unit Tests)
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:food_order_app/core/usecases/usecase.dart';
import 'package:food_order_app/core/error/failures.dart';
import 'package:food_order_app/features/restaurant/domain/entities/restaurant.dart';
import 'package:food_order_app/features/restaurant/domain/usecases/get_restaurants.dart';
import 'package:food_order_app/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'restaurant_bloc_test.mocks.dart';

@GenerateMocks([GetRestaurants])
void main() {
  late RestaurantBloc bloc;
  late MockGetRestaurants mockGetRestaurants;

  setUp(() {
    mockGetRestaurants = MockGetRestaurants();
    bloc = RestaurantBloc(getRestaurantsUseCase: mockGetRestaurants);
  });

  tearDown(() {
    bloc.close();
  });

  blocTest<RestaurantBloc, RestaurantState>(
    'emits [Loading, Loaded] when LoadRestaurants is added successfully',
    build: () {
      when(mockGetRestaurants(any)).thenAnswer(
        (_) async => Right(<Restaurant>[ /* mock list */ ]),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(LoadRestaurants()),
    expect: () => [
      RestaurantLoading(),
      isA<RestaurantLoaded>(),
    ],
  );

  blocTest<RestaurantBloc, RestaurantState>(
    'emits [Loading, Error] when LoadRestaurants fails',
    build: () {
      when(mockGetRestaurants(any)).thenAnswer(
        (_) async => Left(ServerFailure()),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(LoadRestaurants()),
    expect: () => [
      RestaurantLoading(),
      RestaurantError(message: 'Server Failure'),
    ],
  );
}