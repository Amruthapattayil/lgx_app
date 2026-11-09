
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'login.dart';
import 'preferences/theme_preference.dart';
import 'providers/posts_notifier.dart';

final ValueNotifier<bool> isDarkModeNotifier =
    ValueNotifier<bool>(false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('postsBox');

  final isDarkMode = await ThemePreference.loadTheme();
  isDarkModeNotifier.value = isDarkMode;

  runApp(
    ChangeNotifierProvider(
  create: (_) => PostsNotifier()..loadPosts(),
  child: const MyApp(),
),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> changeTheme(bool value) async {
    isDarkModeNotifier.value = value;
    await ThemePreference.saveTheme(value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mini API App',

          theme: ThemeData(
            brightness: Brightness.light,
            useMaterial3: true,
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
          ),

          themeMode: isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,

          home: LoginPage(
            isDarkMode: isDarkMode,
            onThemeChanged: changeTheme,
          ),
        );
      },
    );
  }
}
