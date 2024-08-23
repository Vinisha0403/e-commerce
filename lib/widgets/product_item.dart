import 'package:flutter/material.dart';
import '../models/products.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          // Navigate to Product Detail Screen
        },
        child: Image.network(product.imageUrl, fit: BoxFit.cover),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        title: Text(product.name, textAlign: TextAlign.center),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            // Add to Cart Logic
          },
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
