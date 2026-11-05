
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:lgx_app/providers/cart_notifier.dart';
import 'package:lgx_app/providers/auth_notifier.dart';
import 'package:lgx_app/providers/theme_notifier.dart';
import 'package:lgx_app/screens/home_screen.dart';

class MockCartNotifier extends CartNotifier {}

void main() {
    testWidgets('Cart count updates correctly', (tester) async {

    final mockCart = MockCartNotifier();
    final auth = AuthNotifier();
    final theme = ThemeNotifier();

    await tester.pumpWidget(
      MultiProvider(
        providers: [

          ChangeNotifierProvider<CartNotifier>.value(
            value: mockCart,
          ),

          ChangeNotifierProvider<AuthNotifier>.value(
            value: auth,
          ),

          ChangeNotifierProvider<ThemeNotifier>.value(
            value: theme,
          ),

        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.text('Add Item'));

    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);

  });
}
