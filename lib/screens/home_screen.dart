
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_notifier.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          Consumer<CartNotifier>(
            builder: (context, cart, child) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                icon: Selector<CartNotifier, int>(
                  selector: (context, cart) => cart.cartCount,
                  builder: (context, count, child) {
                    return Badge(
                      label: Text('$count'),
                      child: const Icon(Icons.shopping_cart),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
