// lib/features/restaurant/presentation/pages/home_page.dart (UI - Home with restaurant list)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart'; // For fade-in animations
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Loading
import '../../../injection_container.dart' as di; // For DI (Dagger-like)
import '../bloc/restaurant_bloc.dart';
import '../bloc/restaurant_event.dart';
import '../widgets/restaurant_card.dart';
import '../../../../core/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Local Eats', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) => di.sl<RestaurantBloc>()..add(LoadRestaurants()),
        child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantLoading) {
              return Center(
                child: SpinKitFadingCircle(color: AppTheme.primaryColor, size: 50), // Aesthetically pleasing loader
              );
            } else if (state is RestaurantLoaded) {
              return FadeInUp( // Animation for list entrance
                duration: const Duration(milliseconds: 600),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = state.restaurants[index];
                    return FadeIn(
                      delay: Duration(milliseconds: index * 100), // Staggered animation
                      child: RestaurantCard(restaurant: restaurant),
                    );
                  },
                ),
              );
            } else if (state is RestaurantError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: AppTheme.errorColor),
                    const SizedBox(height: 16),
                    Text(state.message ?? 'An error occurred', style: const TextStyle(color: AppTheme.textPrimary)),
                    ElevatedButton(
                      onPressed: () => context.read<RestaurantBloc>().add(LoadRestaurants()), // Retry
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}