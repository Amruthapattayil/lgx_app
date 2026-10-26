
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  
  static Future<void> saveTheme(bool isDarkMode) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool('isDarkMode', isDarkMode);
  }

  
  static Future<bool> loadTheme() async {
    final preferences = await SharedPreferences.getInstance();

    bool isDarkMode = preferences.getBool('isDarkMode') ?? false;

    return isDarkMode;
  }
}
