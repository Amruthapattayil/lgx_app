
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_notifier.dart';
import 'providers/auth_notifier.dart';
import 'providers/theme_notifier.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeNotifier>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: theme.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
