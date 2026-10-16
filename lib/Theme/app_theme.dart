
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    primary: Colors.blue,
    secondary: Colors.green,
  ),
  cardTheme: const CardThemeData(
    color: Color(0xFFE8F5E9),
  ),
  fontFamily: 'Palatino',
);
