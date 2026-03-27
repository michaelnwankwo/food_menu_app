import 'package:hive/hive.dart';

part 'food_item.g.dart';

@HiveType(typeId: 0)
class FoodItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  double price;

  @HiveField(4)
  String category;

  @HiveField(5)
  String emoji; // kept for backwards compatibility

  @HiveField(6)
  String imageUrl; // 🆕 new field

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.emoji,
    this.imageUrl = '', // defaults to empty
  });

  // Helper — true if a valid image URL exists
  bool get hasImage => imageUrl.isNotEmpty;
}
