
import 'package:flutter/material.dart';
import 'product_page.dart';
import 'Theme/app_theme.dart';

void main() {
  runApp(
    MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const ProductPage(),
    ),
  );
}
