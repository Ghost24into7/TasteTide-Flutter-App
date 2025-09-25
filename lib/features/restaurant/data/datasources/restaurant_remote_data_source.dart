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
      // Mock restaurant data with Indian restaurants and rupee pricing
      final mockRestaurants = [
        {
          'id': 1,
          'name': 'Spice Garden',
          'imageUrl': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400',
          'rating': 4.5,
          'cuisine': 'North Indian',
        },
        {
          'id': 2,
          'name': 'Dosa Express',
          'imageUrl': 'https://images.unsplash.com/photo-1630383249896-424e482df921?w=400',
          'rating': 4.3,
          'cuisine': 'South Indian',
        },
        {
          'id': 3,
          'name': 'Biryani House',
          'imageUrl': 'https://images.unsplash.com/photo-1563379091339-03246963d51a?w=400',
          'rating': 4.7,
          'cuisine': 'Hyderabadi',
        },
        {
          'id': 4,
          'name': 'Pizza Corner',
          'imageUrl': 'https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=400',
          'rating': 4.2,
          'cuisine': 'Italian',
        },
        {
          'id': 5,
          'name': 'Burger Palace',
          'imageUrl': 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
          'rating': 4.4,
          'cuisine': 'American',
        },
        {
          'id': 6,
          'name': 'Tandoor Nights',
          'imageUrl': 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400',
          'rating': 4.6,
          'cuisine': 'Punjabi',
        },
        {
          'id': 7,
          'name': 'Chinese Wok',
          'imageUrl': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400',
          'rating': 4.1,
          'cuisine': 'Chinese',
        },
        {
          'id': 8,
          'name': 'Healthy Bowls',
          'imageUrl': 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400',
          'rating': 4.4,
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