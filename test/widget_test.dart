import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:lgx_app/main.dart';
import 'package:lgx_app/providers/cart_notifier.dart';
import 'package:lgx_app/providers/auth_notifier.dart';
import 'package:lgx_app/providers/theme_notifier.dart';

void main() {
  testWidgets('App displays Home Screen', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartNotifier()),
          ChangeNotifierProvider(create: (_) => AuthNotifier()),
          ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ],
        child: const MyApp(),
      ),
    );

    expect(find.text('Home Screen'), findsOneWidget);
    expect(find.text('Add Item'), findsOneWidget);
  });
}