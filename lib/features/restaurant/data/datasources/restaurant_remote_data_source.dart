// lib/features/restaurant/data/datasources/restaurant_remote_data_source.dart (Data - Implementation)
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/restaurant_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurants();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final Dio dio;

  RestaurantRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      final response = await dio.get('https://api.example.com/restaurants'); // Mock API
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.data);
        return jsonList.map((json) => RestaurantModel.fromJson(json)).toList();
      } else {
        throw ServerFailure(message: 'Server error');
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}