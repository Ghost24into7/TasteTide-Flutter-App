// lib/features/cart/domain/entities/cart_item.dart
import 'package:equatable/equatable.dart';
import '../../../restaurant/domain/entities/restaurant.dart';

class CartItem extends Equatable {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final int quantity;
  final Restaurant restaurant;

  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.restaurant,
  });

  CartItem copyWith({
    int? id,
    String? name,
    double? price,
    String? imageUrl,
    int? quantity,
    Restaurant? restaurant,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      restaurant: restaurant ?? this.restaurant,
    );
  }

  double get totalPrice => price * quantity;

  @override
  List<Object> get props => [id, name, price, imageUrl, quantity, restaurant];
}