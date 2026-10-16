import 'package:flutter/material.dart';
import 'product_detail_page.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      'name': 'Phone',
      'price': 15000,
      'description': 'A smartphone for everyday use.',
    },
    {
      'name': 'Laptop',
      'price': 45000,
      'description': 'A laptop for work and study.',
    },
    {
      'name': 'Headphones',
      'price': 1500,
      'description': 'Headphones for listening to audio.',
    },
    {
      'name': 'Watch',
      'price': 2000,
      'description': 'A stylish wristwatch.',
    },
    {
      'name': 'Keyboard',
      'price': 800,
      'description': 'A keyboard for typing.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
         backgroundColor: colors.primary,
         foregroundColor: Colors.white,
        
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
             
            margin: const EdgeInsets.all(8),
            
 child: ListTile(
  title: Text(
    product['name'],
    style: TextStyle(
      color: colors.secondary,
    ),
  ),
  subtitle: Text('Price: ₹${product['price']}'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductDetailPage(product: product),
      ),
    );
  },
),

          );
        },
      ),
    );
  }
}