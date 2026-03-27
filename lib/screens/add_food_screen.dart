import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../constants/app_theme.dart';
import '../models/food_item.dart';
import '../services/hive_service.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedCategory = 'Swallows';
  String _selectedEmoji = '🍚';
  bool _isSaving = false;

  // ── Emoji options per category ────────────────────────────────
  final Map<String, List<String>> _categoryEmojis = {
    'Swallows': ['🍚', '🫓', '🌾', '🥣', '🍽️', '🫕', '🥘', '🍲'],
    'Rice': ['🍚', '🍛', '🥘', '🫕', '🍲', '🥗', '🍱', '🫙'],
    'Soups': ['🍲', '🫕', '🥘', '🍜', '🥣', '🍵', '🫙', '🍶'],
    'Proteins': ['🍗', '🥩', '🐟', '🦐', '🥚', '🍖', '🐠', '🦀'],
    'Drinks': ['🥤', '🧃', '🍵', '🧋', '💧', '🥛', '🫖', '🍹'],
  };

  List<String> get _currentEmojis =>
      _categoryEmojis[_selectedCategory] ?? ['🍔'];

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // ── Save to Hive ─────────────────────────────────────────────
  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final newItem = FoodItem(
      id: const Uuid().v4(),
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      price: double.parse(_priceController.text.trim()),
      category: _selectedCategory,
      emoji: _selectedEmoji,
    );

    await HiveService.addItem(newItem);

    if (mounted) {
      setState(() => _isSaving = false);
      _showSuccessSnackbar();
      Navigator.pop(context);
    }
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              '${_nameController.text.trim()} added!',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppTheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food Item'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ── Emoji Display ─────────────────────────────────
            _buildEmojiDisplay(),
            const SizedBox(height: 24),

            // ── Category Selector ─────────────────────────────
            _buildSectionLabel('Category'),
            const SizedBox(height: 10),
            _buildCategorySelector(),
            const SizedBox(height: 8),

            // ── Emoji Picker ──────────────────────────────────
            _buildEmojiPicker(),
            const SizedBox(height: 24),

            // ── Food Name ─────────────────────────────────────
            _buildSectionLabel('Food Name'),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'e.g. Jollof Rice',
                prefixIcon: Icon(Icons.fastfood_rounded),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Please enter a food name';
                }
                if (v.trim().length < 2) {
                  return 'Name must be at least 2 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // ── Description ───────────────────────────────────
            _buildSectionLabel('Description'),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descController,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Describe the dish, ingredients, taste...',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Icon(Icons.notes_rounded),
                ),
                alignLabelWithHint: true,
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Please enter a description';
                }
                if (v.trim().length < 10) {
                  return 'Description must be at least 10 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // ── Price ─────────────────────────────────────────
            _buildSectionLabel('Price (₦)'),
            const SizedBox(height: 10),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                hintText: 'e.g. 2500.00',
                prefixIcon: Icon(Icons.payments_outlined),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Please enter a price';
                }
                final price = double.tryParse(v.trim());
                if (price == null) {
                  return 'Please enter a valid number';
                }
                if (price <= 0) {
                  return 'Price must be greater than 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 36),

            // ── Save Button ───────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveItem,
                child: _isSaving
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text('Save Food Item'),
              ),
            ),

            const SizedBox(height: 16),

            // ── Cancel Button ─────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ── Extracted Widgets ─────────────────────────────────────────

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppTheme.textDark,
      ),
    );
  }

  Widget _buildEmojiDisplay() {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color:
              AppTheme.categoryColors[_selectedCategory] ??
              const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(_selectedEmoji, style: const TextStyle(fontSize: 52)),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    final categories = _categoryEmojis.keys.toList();
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (_, i) {
          final cat = categories[i];
          final isSelected = _selectedCategory == cat;
          return GestureDetector(
            onTap: () => setState(() {
              _selectedCategory = cat;
              _selectedEmoji = _categoryEmojis[cat]!.first;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primary : const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                cat,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppTheme.textDark,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: _currentEmojis.map((emoji) {
          final isSelected = _selectedEmoji == emoji;
          return GestureDetector(
            onTap: () => setState(() => _selectedEmoji = emoji),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primary.withOpacity(0.15)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppTheme.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 26)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
