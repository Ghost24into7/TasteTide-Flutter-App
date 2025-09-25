// lib/features/cart/presentation/bloc/cart_bloc.dart
import 'package:bloc/bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../domain/entities/cart_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    emit(CartLoaded(items: state.items, totalAmount: state.totalAmount));
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    emit(CartLoading(items: state.items, totalAmount: state.totalAmount));
    
    final items = List<CartItem>.from(state.items);
    final existingItemIndex = items.indexWhere((item) => item.id == event.item.id);
    
    if (existingItemIndex >= 0) {
      // Item already exists, increase quantity
      items[existingItemIndex] = items[existingItemIndex].copyWith(
        quantity: items[existingItemIndex].quantity + 1,
      );
    } else {
      // New item, add to cart
      items.add(event.item);
    }
    
    final totalAmount = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    emit(CartLoaded(items: items, totalAmount: totalAmount));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    emit(CartLoading(items: state.items, totalAmount: state.totalAmount));
    
    final items = state.items.where((item) => item.id != event.itemId).toList();
    final totalAmount = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    
    emit(CartLoaded(items: items, totalAmount: totalAmount));
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    emit(CartLoading(items: state.items, totalAmount: state.totalAmount));
    
    final items = state.items.map((item) {
      if (item.id == event.itemId) {
        return item.copyWith(quantity: event.quantity);
      }
      return item;
    }).toList();
    
    final totalAmount = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    emit(CartLoaded(items: items, totalAmount: totalAmount));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartLoaded(items: [], totalAmount: 0.0));
  }
}