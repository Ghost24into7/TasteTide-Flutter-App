// lib/features/restaurant/presentation/widgets/restaurant_card.dart (UI Component)
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import '../../../domain/entities/restaurant.dart';
import '../../../../core/theme/app_theme.dart';
import '../pages/menu_page.dart'; // Next step in workflow

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => Navigator.push( // Transition to menu
          context,
          MaterialPageRoute(builder: (_) => MenuPage(restaurant: restaurant)),
        ),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: restaurant.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SpinKitThreeBounce(color: AppTheme.primaryColor, size: 20),
                  errorWidget: (context, url, error) => const Icon(Icons.restaurant, size: 40),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(restaurant.cuisine, style: TextStyle(color: AppTheme.textSecondary)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text('${restaurant.rating}', style: TextStyle(color: AppTheme.textSecondary)),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: AppTheme.secondaryColor),
            ],
          ),
        ),
      ),
    );
  }
}