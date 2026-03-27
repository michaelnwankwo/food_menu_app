import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/hive_service.dart';
import 'providers/cart_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await HiveService.seedIfEmpty();
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const FoodMenuApp(),
    ),
  );
}
