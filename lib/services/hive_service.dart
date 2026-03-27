import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/food_item.dart';
import '../models/order.dart'; //

class HiveService {
  static const String _boxName = 'food_items';

  // Open the Hive box (call once at app start)
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FoodItemAdapter());
    Hive.registerAdapter(OrderAdapter()); //
    await Hive.openBox<FoodItem>('food_items');
    await Hive.openBox<Order>('orders'); //
  }

  // Get the box
  static Box<FoodItem> _box() => Hive.box<FoodItem>(_boxName);

  // READ — get all food items
  static List<FoodItem> getAllItems() {
    return _box().values.toList();
  }

  // CREATE — add a new food item
  static Future<void> addItem(FoodItem item) async {
    await _box().put(item.id, item);
  }

  // DELETE — remove a food item by id
  static Future<void> deleteItem(String id) async {
    await _box().delete(id);
  }

  // UPDATE — edit an existing food item
  static Future<void> updateItem(FoodItem item) async {
    await _box().put(item.id, item);
  }

  // SEED — add Nigerian food data on first launch
  static Future<void> seedIfEmpty() async {
    if (_box().isNotEmpty) return; // only seed once

    final items = [
      FoodItem(
        id: const Uuid().v4(),
        name: 'Eba & Egusi Soup',
        description:
            'Smooth golden eba served with rich egusi soup loaded '
            'with assorted meat, stockfish, and leafy ugu.',
        price: 1800,
        category: 'Swallows',
        emoji: '🍲',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Pounded Yam & Oha Soup',
        description:
            'Freshly pounded yam paired with native oha soup cooked '
            'with cocoyam, crayfish, and tender beef.',
        price: 2500,
        category: 'Swallows',
        emoji: '🫕',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Amala & Ewedu',
        description:
            'Soft dark amala served with silky ewedu soup and '
            'gbegiri, topped with assorted meats and locust beans.',
        price: 2000,
        category: 'Swallows',
        emoji: '🥣',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Jollof Rice & Chicken',
        description:
            'Party-style smoky jollof rice cooked in rich tomato '
            'stew, served with a full leg of fried chicken.',
        price: 2800,
        category: 'Rice',
        emoji: '🍚',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Ofada Rice & Ayamase',
        description:
            'Local ofada rice served with spicy designer stew made '
            'with green peppers, assorted offals, and palm oil.',
        price: 3000,
        category: 'Rice',
        emoji: '🍛',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Fried Rice & Moi Moi',
        description:
            'Nigerian-style fried rice with carrots, green peas, '
            'liver, and prawns, served alongside soft moi moi.',
        price: 2500,
        category: 'Rice',
        emoji: '🍱',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Banga Soup',
        description:
            'Delta-style palm nut soup slow-cooked with fresh fish, '
            'dried catfish, oburunbebe stick, and native spices.',
        price: 2200,
        category: 'Soups',
        emoji: '🍵',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Afang Soup',
        description:
            'Cross River delicacy made with afang leaves, waterleaf, '
            'periwinkle, crayfish, and assorted meat in palm oil.',
        price: 2800,
        category: 'Soups',
        emoji: '🥘',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Grilled Catfish (Point & Kill)',
        description:
            'Fresh whole catfish grilled over open fire with pepper '
            'sauce, onions, and served with a side of yaji spice.',
        price: 4500,
        category: 'Proteins',
        emoji: '🐟',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Suya Platter',
        description:
            'Thin slices of perfectly spiced beef suya grilled on '
            'skewers, served with sliced onions, tomatoes, and yaji.',
        price: 2000,
        category: 'Proteins',
        emoji: '🥩',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Zobo Drink',
        description:
            'Chilled hibiscus drink brewed with ginger, cloves, '
            'and pineapple juice. Refreshing and naturally sweet.',
        price: 500,
        category: 'Drinks',
        emoji: '🍹',
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: 'Kunu Aya',
        description:
            'Creamy tiger nut drink blended with dates and coconut. '
            'A healthy and filling Northern Nigerian classic.',
        price: 600,
        category: 'Drinks',
        emoji: '🥛',
      ),
    ];

    for (final item in items) {
      await _box().put(item.id, item);
    }
  }
}
