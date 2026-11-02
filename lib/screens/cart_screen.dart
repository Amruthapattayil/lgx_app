import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_notifier.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: Center(
        child: Text(
          'Total Cart Items: ${cart.cartCount}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}