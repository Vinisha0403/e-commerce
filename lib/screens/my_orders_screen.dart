import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders_providers.dart'; // Adjust this import as per your file structure
import '../providers/products_providers.dart'; // Import your ProductsProvider where your products list is managed

class MyOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the OrdersProvider
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orders = ordersProvider.orders;

    // Access the ProductsProvider to get the list of products
    final productsProvider = Provider.of<ProductsProvider>(context);
    final allProducts = productsProvider
        .items; // Ensure you access the list of products correctly

    // Helper function to get the image URL using productId
    String getProductImageUrl(String productId) {
      final product = allProducts.firstWhere((prod) => prod.id == productId);
      return product.imageUrl; // Placeholder if image not found
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        backgroundColor: Colors.pink[600],
      ),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.9, // Adjust the opacity level (0.0 to 1.0)
                    child: Image.asset(
                      'assets/Empty-Order.png', // Replace with your image path
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No orders yet!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (ctx, index) {
                final order = orders[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    getProductImageUrl(order.products[0]
                                        .productId), // Fetch image URL using productId
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.products[0]
                                        .title, // Display product title
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Order Date: ${order.dateTime.toLocal().toString().split(' ')[0]}', // Display formatted date
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Total: \$${order.amount.toStringAsFixed(2)}', // Display total amount
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        // Additional order details or list of products can go here
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: order.products.map((prod) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                '${prod.quantity} x ${prod.title} - \$${prod.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
