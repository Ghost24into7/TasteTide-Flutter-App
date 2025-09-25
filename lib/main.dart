// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart'; // For shared axis transitions
import 'features/restaurant/presentation/pages/home_page.dart';
import 'core/theme/app_theme.dart'; // Custom theme

void main() {
  runApp(const FoodOrderApp());
}

class FoodOrderApp extends StatelessWidget {
  const FoodOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: AppTheme.lightTheme, // Aesthetically pleasing food-themed theme
      home: BlocProvider(
        create: (_) => RestaurantBloc(), // Main BLoC for workflow
        child: const HomePage(),
      ),
    );
  }
}