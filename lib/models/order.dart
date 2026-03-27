import 'package:hive/hive.dart';
import 'cart_item.dart';

part 'order.g.dart';

@HiveType(typeId: 1)
class Order extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<String> itemNames;

  @HiveField(2)
  final List<int> quantities;

  @HiveField(3)
  final List<double> prices;

  @HiveField(4)
  final List<String> emojis;

  @HiveField(5)
  final double totalAmount;

  @HiveField(6)
  final String deliveryAddress;

  @HiveField(7)
  final String phoneNumber;

  @HiveField(8)
  final DateTime createdAt;

  @HiveField(9)
  String status; // 'Pending', 'Confirmed', 'Delivered'

  Order({
    required this.id,
    required this.itemNames,
    required this.quantities,
    required this.prices,
    required this.emojis,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.phoneNumber,
    required this.createdAt,
    this.status = 'Pending',
  });

  // Rebuild cart items from stored parallel lists
  List<CartItem> get cartItems => List.generate(
    itemNames.length,
    (i) => CartItem(
      foodItemId: '',
      name: itemNames[i],
      emoji: emojis[i],
      price: prices[i],
      category: '',
      quantity: quantities[i],
    ),
  );

  // Formatted date string
  String get formattedDate {
    final d = createdAt;
    return '${d.day}/${d.month}/${d.year} '
        '${d.hour.toString().padLeft(2, '0')}:'
        '${d.minute.toString().padLeft(2, '0')}';
  }
}
