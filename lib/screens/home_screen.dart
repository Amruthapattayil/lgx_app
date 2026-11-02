import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_notifier.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cart Count: ${cart.cartCount}'),

            ElevatedButton(
              onPressed: () {
                context.read<CartNotifier>().addItem();
              },
              child: const Text('Add Item'),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<CartNotifier>().removeItem();
              },
              child: const Text('Remove Item'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              child: const Text('Go to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}