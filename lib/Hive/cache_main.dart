import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'login.dart';
import 'preferences/theme_preference.dart';

final ValueNotifier<bool> isDarkModeNotifier =
    ValueNotifier<bool>(false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('postsBox');

  isDarkModeNotifier.value =
      await ThemePreference.loadTheme();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> changeTheme(bool value) async {
    await ThemePreference.saveTheme(value);
    isDarkModeNotifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mini API App',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode:
              isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: Theme(
            data: ThemeData.light(),
            child: LoginPage(
              isDarkMode: isDarkMode,
              onThemeChanged: changeTheme,
            ),
          ),
        );
      },
    );
  }
}