// lib/features/restaurant/presentation/pages/menu_page.dart (Next step: Menu selection)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/restaurant.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/pages/cart_page.dart';

class MenuPage extends StatelessWidget {
  final Restaurant restaurant;
  const MenuPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    // Mock menu items with Indian dishes and rupee pricing
    final menuItems = [
      {
        'id': 1,
        'name': 'Butter Chicken',
        'price': 280.0,
        'image': 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=400',
        'description': 'Creamy tomato-based curry with tender chicken pieces'
      },
      {
        'id': 2,
        'name': 'Paneer Tikka Masala',
        'price': 240.0,
        'image': 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400',
        'description': 'Grilled paneer in rich and creamy tomato gravy'
      },
      {
        'id': 3,
        'name': 'Biryani (Chicken)',
        'price': 320.0,
        'image': 'https://images.unsplash.com/photo-1563379091339-03246963d51a?w=400',
        'description': 'Aromatic basmati rice with spiced chicken and saffron'
      },
      {
        'id': 4,
        'name': 'Masala Dosa',
        'price': 120.0,
        'image': 'https://images.unsplash.com/photo-1630383249896-424e482df921?w=400',
        'description': 'Crispy crepe filled with spiced potato mixture'
      },
      {
        'id': 5,
        'name': 'Chole Bhature',
        'price': 160.0,
        'image': 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=400',
        'description': 'Spicy chickpeas curry with fluffy fried bread'
      },
      {
        'id': 6,
        'name': 'Tandoori Roti',
        'price': 25.0,
        'image': 'https://images.unsplash.com/photo-1574653985050-7cedc6580cd8?w=400',
        'description': 'Fresh wheat bread cooked in tandoor oven'
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(restaurant.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Restaurant Info Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    restaurant.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(
                          width: 60,
                          height: 60,
                          color: AppTheme.backgroundColor,
                          child: const Icon(Icons.restaurant, color: AppTheme.textSecondary),
                        ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        restaurant.cuisine,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${restaurant.rating}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item['image']! as String,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 80,
                                  height: 80,
                                  color: AppTheme.backgroundColor,
                                  child: const Icon(Icons.fastfood, color: AppTheme.textSecondary),
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name']! as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['description']! as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.textSecondary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '₹${(item['price']! as double).toInt()}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final cartItem = CartItem(
                              id: item['id']! as int,
                              name: item['name']! as String,
                              price: item['price']! as double,
                              imageUrl: item['image']! as String,
                              quantity: 1,
                              restaurant: restaurant,
                            );
                            
                            context.read<CartBloc>().add(AddToCart(item: cartItem));
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item['name']} added to cart!'),
                                backgroundColor: AppTheme.successColor,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}