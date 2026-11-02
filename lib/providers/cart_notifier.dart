import 'package:flutter/material.dart';

class CartNotifier extends ChangeNotifier {
  int cartCount = 0;

  void addItem() {
    cartCount++;
    notifyListeners();
  }

  void removeItem() {
    if (cartCount > 0) {
      cartCount--;
      notifyListeners();
    }
  }
}