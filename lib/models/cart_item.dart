class CartItem {
  final String foodItemId;
  final String name;
  final String emoji;
  final double price;
  final String category;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.foodItemId,
    required this.name,
    required this.emoji,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.quantity = 1,
  });

  // Total price for this cart line
  double get subtotal => price * quantity;

  // Convert to a readable order line
  String toOrderLine() =>
      '$emoji $name x$quantity — ₦${subtotal.toStringAsFixed(2)}';
}
