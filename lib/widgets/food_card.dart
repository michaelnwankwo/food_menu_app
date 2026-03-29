import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/food_item.dart';
import '../constants/app_theme.dart';
import '../providers/cart_provider.dart';

class FoodCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const FoodCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        final inCart = cart.isInCart(item.id);
        final quantity = cart.getQuantity(item.id);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.cardShadow,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // ── Food Image ──────────────────────────────
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: FoodImage(item: item, size: 80),
                    ),

                    // ── Info ────────────────────────────────────
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.category,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textGrey,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '₦${item.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Delete ──────────────────────────────────
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline_rounded),
                      color: Colors.redAccent,
                      iconSize: 20,
                    ),
                  ],
                ),

                // ── Add to Cart Controls ──────────────────────
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: inCart
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.primary.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () => cart.removeItem(item.id),
                                      icon: const Icon(
                                        Icons.remove_rounded,
                                        size: 18,
                                      ),
                                      color: AppTheme.primary,
                                    ),
                                    Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.primary,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => cart.addItem(item),
                                      icon: const Icon(
                                        Icons.add_rounded,
                                        size: 18,
                                      ),
                                      color: AppTheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => cart.addItem(item),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 18,
                            ),
                            label: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Reusable Food Image Widget ────────────────────────────────
class FoodImage extends StatelessWidget {
  final FoodItem item;
  final double size;
  final double borderRadius;

  const FoodImage({
    super.key,
    required this.item,
    this.size = 80,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor =
        AppTheme.categoryColors[item.category] ?? const Color(0xFFFFF3E0);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: categoryColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: item.hasImage
            ? CachedNetworkImage(
                imageUrl: item.imageUrl,
                width: size,
                height: size,
                fit: BoxFit.cover,
                placeholder: (_, __) => Center(
                  child: Text(
                    item.emoji,
                    style: TextStyle(fontSize: size * 0.4),
                  ),
                ),
                errorWidget: (_, __, ___) => Center(
                  child: Text(
                    item.emoji,
                    style: TextStyle(fontSize: size * 0.4),
                  ),
                ),
              )
            : Center(
                child: Text(item.emoji, style: TextStyle(fontSize: size * 0.4)),
              ),
      ),
    );
  }
}
