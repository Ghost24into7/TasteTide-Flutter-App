// lib/features/restaurant/presentation/pages/order_workflow.dart
// Complete workflow navigation manager using PageView
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import 'home_page.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../order/presentation/pages/checkout_page.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_state.dart';

class OrderWorkflowPage extends StatefulWidget {
  const OrderWorkflowPage({super.key});

  @override
  State<OrderWorkflowPage> createState() => _OrderWorkflowPageState();
}

class _OrderWorkflowPageState extends State<OrderWorkflowPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _stepTitles = [
    'Restaurants',
    'Your Cart',
    'Checkout',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          _stepTitles[_currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_currentIndex == 0) // Only show cart icon on home page
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () => _navigateToPage(1),
                    ),
                    if (state.items.isNotEmpty)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${state.items.fold(0, (sum, item) => sum + item.quantity)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: const [
          HomePage(),
          CartPage(),
          CheckoutPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _navigateToPage,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.textSecondary,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: 'Restaurants',
            ),
            BottomNavigationBarItem(
              icon: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      const Icon(Icons.shopping_cart),
                      if (state.items.isNotEmpty)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              '${state.items.fold(0, (sum, item) => sum + item.quantity)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Checkout',
            ),
          ],
        ),
      ),
    );
  }
}