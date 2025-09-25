// lib/features/restaurant/data/models/restaurant_model.dart (Data layer)
import 'package:equatable/equatable.dart';

class RestaurantModel extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;
  final String cuisine;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.cuisine,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      cuisine: json['cuisine'],
    );
  }

  @override
  List<Object> get props => [id, name, imageUrl, rating, cuisine];
}