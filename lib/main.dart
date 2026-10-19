
import 'package:flutter/material.dart';
import 'login.dart';
import 'Theme/app_theme.dart';

void main() {
  runApp(
    MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ),
  );
}
