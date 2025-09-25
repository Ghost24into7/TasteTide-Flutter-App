// lib/features/restaurant/domain/entities/restaurant.dart (Domain layer - Entities)
import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;
  final String cuisine;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.cuisine,
  });

  @override
  List<Object> get props => [id, name, imageUrl, rating, cuisine];
}