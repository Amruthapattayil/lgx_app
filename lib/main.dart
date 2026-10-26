
import 'package:flutter/material.dart';
import 'post_page.dart';
import 'preferences/theme_preference.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    bool savedTheme = await ThemePreference.loadTheme();

    setState(() {
      isDarkMode = savedTheme;
    });
  }

  Future<void> changeTheme(bool value) async {
    await ThemePreference.saveTheme(value);

    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini API App',

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      themeMode:
          isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: PostsPage(
        isDarkMode: isDarkMode,
        onThemeChanged: changeTheme,
      ),
    );
  }
}
