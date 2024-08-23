import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/providers/users_providers.dart';
import 'package:ecommerce_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'category_screen.dart';
import 'my_orders_screen.dart';

class ProductsListScreen extends StatefulWidget {
  final String? email;

  ProductsListScreen({this.email});

  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  List<dynamic> _products = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/products'));
      if (response.statusCode == 200) {
        setState(() {
          _products =
              List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error fetching products: $error');
      // You can show a SnackBar or Dialog to notify the user of the error
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the user from the UsersProvider using the email passed to this screen
    final usersProvider = Provider.of<UsersProvider>(context);
    final User? user = usersProvider.getUserByEmail(widget.email);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase();
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.username ?? 'User Name'),
              accountEmail: Text(user?.email ?? 'user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.pink,
                child: Text(
                  user != null && user.username.isNotEmpty
                      ? user.username[0]
                          .toUpperCase() // First letter of the username
                      : 'U',
                  style: TextStyle(fontSize: 40.0, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.pink[600],
              ),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CategoryScreen()),
                );
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('My Orders'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyOrdersScreen()),
                );
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings Screen
              },
            ),
          ],
        ),
      ),
      body: _products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: _products.length,
              itemBuilder: (ctx, index) {
                final product = _products[index];
                if (_searchQuery.isNotEmpty &&
                    !product['name'].toLowerCase().contains(_searchQuery)) {
                  return Container();
                }

                final rating = product['rating']['rate'].toDouble();
                final ratingCount = product['rating']['count'];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
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
                                  product['imageUrl'],
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
                                    product['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '\$${product['price']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink[600],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      Text(
                                        '$rating ($ratingCount)',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
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
    );
  }
}
