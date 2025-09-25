// test/features/cart/presentation/bloc/cart_bloc_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:nestafar_assignment/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:nestafar_assignment/features/cart/presentation/bloc/cart_event.dart';
import 'package:nestafar_assignment/features/cart/presentation/bloc/cart_state.dart';
import 'package:nestafar_assignment/features/cart/domain/entities/cart_item.dart';
import 'package:nestafar_assignment/features/restaurant/domain/entities/restaurant.dart';

void main() {
  group('CartBloc', () {
    late CartBloc cartBloc;
    late CartItem testCartItem;

    setUp(() {
      cartBloc = CartBloc();
      testCartItem = const CartItem(
        id: 1,
        name: 'Test Burger',
        price: 12.99,
        imageUrl: 'https://example.com/burger.jpg',
        quantity: 1,
        restaurant: Restaurant(
          id: 1,
          name: 'Test Restaurant',
          imageUrl: 'https://example.com/restaurant.jpg',
          rating: 4.5,
          cuisine: 'American',
        ),
      );
    });

    tearDown(() {
      cartBloc.close();
    });

    test('initial state is CartInitial', () {
      expect(cartBloc.state, equals(const CartInitial()));
    });

    blocTest<CartBloc, CartState>(
      'emits [CartLoaded] when AddToCart is added',
      build: () => cartBloc,
      act: (bloc) => bloc.add(AddToCart(item: testCartItem)),
      expect: () => [
        const CartLoading(items: [], totalAmount: 0.0),
        CartLoaded(items: [testCartItem], totalAmount: 12.99),
      ],
    );

    blocTest<CartBloc, CartState>(
      'increases quantity when same item is added twice',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(AddToCart(item: testCartItem));
        bloc.add(AddToCart(item: testCartItem));
      },
      expect: () => [
        const CartLoading(items: [], totalAmount: 0.0),
        CartLoaded(items: [testCartItem], totalAmount: 12.99),
        CartLoading(items: [testCartItem], totalAmount: 12.99),
        CartLoaded(items: [testCartItem.copyWith(quantity: 2)], totalAmount: 25.98),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoaded] with empty items when RemoveFromCart is added',
      build: () => cartBloc,
      seed: () => CartLoaded(items: [testCartItem], totalAmount: 12.99),
      act: (bloc) => bloc.add(RemoveFromCart(itemId: testCartItem.id)),
      expect: () => [
        CartLoading(items: [testCartItem], totalAmount: 12.99),
        const CartLoaded(items: [], totalAmount: 0.0),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoaded] with updated quantity when UpdateQuantity is added',
      build: () => cartBloc,
      seed: () => CartLoaded(items: [testCartItem], totalAmount: 12.99),
      act: (bloc) => bloc.add(UpdateQuantity(itemId: testCartItem.id, quantity: 3)),
      expect: () => [
        CartLoading(items: [testCartItem], totalAmount: 12.99),
        CartLoaded(items: [testCartItem.copyWith(quantity: 3)], totalAmount: 38.97),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoaded] with empty items when ClearCart is added',
      build: () => cartBloc,
      seed: () => CartLoaded(items: [testCartItem], totalAmount: 12.99),
      act: (bloc) => bloc.add(ClearCart()),
      expect: () => [
        const CartLoaded(items: [], totalAmount: 0.0),
      ],
    );
  });
}