import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_menu_app/app.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodMenuApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
