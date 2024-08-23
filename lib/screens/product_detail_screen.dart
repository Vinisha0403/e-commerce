import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/cartitems.dart';
import '../providers/cart_providers.dart';
import '../providers/products_providers.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider =
        Provider.of<CartProvider>(context, listen: false); // Cart provider
    final similarProducts =
        productsProvider.getSimilarProducts(product['category']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Detail Section
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(product['imageUrl']),
                  SizedBox(height: 16),
                  Text(
                    product['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${(product['price'] as double).toStringAsFixed(2)}', // Format price with 2 decimal places
                    style: TextStyle(fontSize: 20, color: Colors.pink[600]),
                  ),
                  SizedBox(height: 16),
                  Text(
                    product['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  // Add to Cart Button
                  ElevatedButton.icon(
                    onPressed: () async {
                      final cartItem = CartItem(
                        id: Random().nextInt(10000).toString(),
                        productId: product['id'],
                        title: product['name'],
                        quantity: 1,
                        price: product['price'],
                      );

                      try {
                        final response = await http.post(
                          Uri.parse('http://localhost:3000/cart'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: json.encode({
                            'id': cartItem.id,
                            'productId': cartItem.productId,
                            'title': cartItem.title,
                            'quantity': cartItem.quantity,
                            'price': cartItem.price,
                          }),
                        );

                        if (response.statusCode == 201) {
                          cartProvider.addItem(
                            product['id'],
                            product['name'],
                            product['price'],
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Product added to cart!')),
                          );

                          // Navigate to Cart Screen
                          Navigator.of(context).pushNamed('/cart');
                        } else {
                          print(
                              'Failed to add product to cart: ${response.statusCode}');
                        }
                      } catch (error) {
                        print('Error adding product to cart: $error');
                      }
                    },
                    icon: Icon(Icons.add_shopping_cart,
                        color: Colors.yellow[700]),
                    label: Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[600],
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),

            // Similar Products Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Similar Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 300, // Adjust height as needed
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: similarProducts.length,
                itemBuilder: (ctx, index) {
                  final similarProduct = similarProducts[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              similarProduct.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                similarProduct.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$${(similarProduct.price).toStringAsFixed(2)}', // Format price with 2 decimal places
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
