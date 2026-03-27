import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../models/food_item.dart';
import '../providers/cart_provider.dart';
import '../services/hive_service.dart';
import '../widgets/cart_badge.dart';
import '../widgets/category_chip.dart';
import '../widgets/food_card.dart';
import 'add_food_screen.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';
import 'order_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _categories = [
    'All',
    'Swallows',
    'Rice',
    'Soups',
    'Proteins',
    'Drinks',
  ];
  String _selectedCategory = 'All';
  List<FoodItem> _allItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    setState(() => _allItems = HiveService.getAllItems());
  }

  List<FoodItem> get _filteredItems {
    if (_selectedCategory == 'All') return _allItems;
    return _allItems.where((i) => i.category == _selectedCategory).toList();
  }

  Future<void> _deleteItem(String id) async {
    await HiveService.deleteItem(id);
    _loadItems();
  }

  Future<void> _navigateToAdd() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddFoodScreen()),
    );
    _loadItems();
  }

  Future<void> _navigateToDetail(FoodItem item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(item: item)),
    );
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🍽️ Mummachi\'s Kitchen'),
        actions: [
          // ── Cart Icon with Badge ──────────────────────────────
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CartBadge(
              count: cart.itemCount,
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
                icon: const Icon(Icons.shopping_cart_outlined),
                color: AppTheme.textDark,
              ),
            ),
          ),

          // ── Order History ─────────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderHistoryScreen()),
              ),
              icon: const Icon(Icons.receipt_long_outlined),
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Cart Summary Banner ───────────────────────────────
          if (cart.itemCount > 0)
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ),
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${cart.itemCount} item(s) in cart',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      '₦${cart.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 12),

          // ── Category Chips ────────────────────────────────────
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (_, i) => CategoryChip(
                label: _categories[i],
                isSelected: _selectedCategory == _categories[i],
                onTap: () => setState(() => _selectedCategory = _categories[i]),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Section Title ─────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _selectedCategory == 'All' ? 'All Dishes' : _selectedCategory,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ── Food List ─────────────────────────────────────────
          Expanded(
            child: _filteredItems.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredItems.length,
                    itemBuilder: (_, i) => FoodCard(
                      item: _filteredItems[i],
                      onTap: () => _navigateToDetail(_filteredItems[i]),
                      onDelete: () => _deleteItem(_filteredItems[i].id),
                    ),
                  ),
          ),
        ],
      ),

      // ── FAB ───────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAdd,
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Item',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🍴', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text(
            'No items yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textGrey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap the button below to add\nyour first food item',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppTheme.textGrey),
          ),
        ],
      ),
    );
  }
}
