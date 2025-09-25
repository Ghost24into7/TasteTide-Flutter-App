// lib/features/cart/presentation/bloc/cart_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

abstract class CartState extends Equatable {
  final List<CartItem> items;
  final double totalAmount;
  final String? message;

  const CartState({
    required this.items,
    required this.totalAmount,
    this.message,
  });

  @override
  List<Object?> get props => [items, totalAmount, message];
}

class CartInitial extends CartState {
  const CartInitial() : super(items: const [], totalAmount: 0.0);
}

class CartLoading extends CartState {
  const CartLoading({required super.items, required super.totalAmount});
}

class CartLoaded extends CartState {
  const CartLoaded({required super.items, required super.totalAmount});
}

class CartError extends CartState {
  const CartError({
    required super.items,
    required super.totalAmount,
    required String message,
  }) : super(message: message);
}