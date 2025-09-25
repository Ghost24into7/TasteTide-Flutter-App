// lib/features/cart/presentation/bloc/cart_event.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final CartItem item;

  const AddToCart({required this.item});

  @override
  List<Object> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final int itemId;

  const RemoveFromCart({required this.itemId});

  @override
  List<Object> get props => [itemId];
}

class UpdateQuantity extends CartEvent {
  final int itemId;
  final int quantity;

  const UpdateQuantity({required this.itemId, required this.quantity});

  @override
  List<Object> get props => [itemId, quantity];
}

class ClearCart extends CartEvent {}

class LoadCart extends CartEvent {}