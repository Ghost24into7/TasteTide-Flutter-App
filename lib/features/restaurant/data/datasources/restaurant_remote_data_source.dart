// lib/features/restaurant/data/datasources/restaurant_remote_data_source.dart (Data - Implementation)
import '../../../../core/error/failures.dart';
import '../models/restaurant_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurants();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    // Simulate network delay for realistic experience
    await Future.delayed(const Duration(seconds: 1));
    
    try {
      // Mock restaurant data with realistic content
      final mockRestaurants = [
        {
          'id': 1,
          'name': 'Burger Palace',
          'imageUrl': 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
          'rating': 4.5,
          'cuisine': 'American Fast Food',
        },
        {
          'id': 2,
          'name': 'Pizza Corner',
          'imageUrl': 'https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=400',
          'rating': 4.3,
          'cuisine': 'Italian',
        },
        {
          'id': 3,
          'name': 'Sushi Express',
          'imageUrl': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
          'rating': 4.7,
          'cuisine': 'Japanese',
        },
        {
          'id': 4,
          'name': 'Taco Fiesta',
          'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
          'rating': 4.2,
          'cuisine': 'Mexican',
        },
        {
          'id': 5,
          'name': 'Noodle House',
          'imageUrl': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400',
          'rating': 4.4,
          'cuisine': 'Asian',
        },
        {
          'id': 6,
          'name': 'Healthy Bites',
          'imageUrl': 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400',
          'rating': 4.6,
          'cuisine': 'Healthy & Fresh',
        },
      ];
      
      return mockRestaurants
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerFailure(message: 'Failed to load restaurants: ${e.toString()}');
    }
  }
}