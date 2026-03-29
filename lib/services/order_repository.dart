import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

class OrderRepository {
  static const String _boxName = 'orders';

  static Box<Order> _box() => Hive.box<Order>(_boxName);

  // ── Save a new order ─────────────────────────────────────────
  static Future<Order> placeOrder({
    required List<CartItem> cartItems,
    required double totalAmount,
    required String deliveryAddress,
    required String phoneNumber,
  }) async {
    final order = Order(
      id: const Uuid().v4(),
      itemNames: cartItems.map((e) => e.name).toList(),
      quantities: cartItems.map((e) => e.quantity).toList(),
      prices: cartItems.map((e) => e.price).toList(),
      emojis: cartItems.map((e) => e.emoji).toList(),
      imageUrls: cartItems.map((e) => e.imageUrl).toList(),
      totalAmount: totalAmount,
      deliveryAddress: deliveryAddress,
      phoneNumber: phoneNumber,
      createdAt: DateTime.now(),
      status: 'Pending',
    );

    await _box().put(order.id, order);
    return order;
  }

  // ── Get all orders (newest first) ───────────────────────────
  static List<Order> getAllOrders() {
    final orders = _box().values.toList();
    orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return orders;
  }

  // ── Delete an order ──────────────────────────────────────────
  static Future<void> deleteOrder(String id) async {
    await _box().delete(id);
  }

  // ── Update order status ──────────────────────────────────────
  static Future<void> updateStatus(String id, String status) async {
    final order = _box().get(id);
    if (order != null) {
      order.status = status;
      await order.save();
    }
  }
}
