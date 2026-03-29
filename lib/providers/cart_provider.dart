import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/food_item.dart';

class CartProvider extends ChangeNotifier {
  // Internal cart map — keyed by foodItemId
  final Map<String, CartItem> _items = {};

  // ── Getters ───────────────────────────────────────────────────

  // All cart items as a list
  List<CartItem> get items => _items.values.toList();

  // Total number of individual items (for badge)
  int get itemCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  // Total price of everything in cart
  double get totalPrice =>
      _items.values.fold(0.0, (sum, item) => sum + item.subtotal);

  // Check if a specific food item is in the cart
  bool isInCart(String foodItemId) => _items.containsKey(foodItemId);

  // Get quantity of a specific item
  int getQuantity(String foodItemId) => _items[foodItemId]?.quantity ?? 0;

  // ── Actions ───────────────────────────────────────────────────

  // Add item or increment quantity
  void addItem(FoodItem foodItem) {
    if (_items.containsKey(foodItem.id)) {
      _items[foodItem.id]!.quantity++;
    } else {
      _items[foodItem.id] = CartItem(
        foodItemId: foodItem.id,
        name: foodItem.name,
        emoji: foodItem.emoji,
        imageUrl: foodItem.imageUrl,
        price: foodItem.price,
        category: foodItem.category,
      );
    }
    notifyListeners();
  }

  // Remove item or decrement quantity
  void removeItem(String foodItemId) {
    if (!_items.containsKey(foodItemId)) return;
    if (_items[foodItemId]!.quantity > 1) {
      _items[foodItemId]!.quantity--;
    } else {
      _items.remove(foodItemId);
    }
    notifyListeners();
  }

  // Remove item completely regardless of quantity
  void removeItemCompletely(String foodItemId) {
    _items.remove(foodItemId);
    notifyListeners();
  }

  // Clear entire cart (call after order is placed)
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // ── Order Summary Helpers ─────────────────────────────────────

  // Formatted WhatsApp/SMS message
  String buildOrderMessage({required String address, required String phone}) {
    final buffer = StringBuffer();
    buffer.writeln('🍽️ *New Order — Mummachi\'s Kitchen*');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('📋 *Order Details:*');
    for (final item in items) {
      buffer.writeln('  ${item.toOrderLine()}');
    }
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('💰 *Total: ₦${totalPrice.toStringAsFixed(2)}*');
    buffer.writeln('📍 *Delivery Address:* $address');
    buffer.writeln('📞 *Phone:* $phone');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('⏰ Order placed via Mummachi\'s Kitchen App');
    return buffer.toString();
  }

  void incrementByCartItem(CartItem item) {
    if (_items.containsKey(item.foodItemId)) {
      _items[item.foodItemId]!.quantity++;
      notifyListeners();
    }
  }
}
