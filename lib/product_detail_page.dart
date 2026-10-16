import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
         backgroundColor: colors.primary,
        foregroundColor: Colors.white,
         
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
Text(
  product['name'],
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: colors.secondary,
  ),
),

            const SizedBox(height: 10),
            Text('Price: ₹${product['price']}'),
            const SizedBox(height: 10),
            Text('Description: ${product['description']}'),
          ],
        ),
      ),
    );
  }
}