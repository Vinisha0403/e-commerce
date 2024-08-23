import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_providers.dart';
import '../providers/products_providers.dart';

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = productsProvider.items;

    double totalCost = 0.0;
    cartItems.forEach((item) {
      totalCost += item.price * item.quantity;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        title: Text('Shopping Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.9, // Adjust the opacity level (0.0 to 1.0)
                    child: Image.asset(
                      'assets/Empty-Cart.jpg', // Replace with your image path
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your cart is empty!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, index) {
                      final item = cartItems[index];
                      final product = products.firstWhere(
                          (prod) => prod.id == item.productId,
                          orElse: () => throw Exception('Product not found'));

                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Product Image and Name
                            Expanded(
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      product.imageUrl,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Price, Quantity Controls, and Remove Button
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${item.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.pink[600],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    // IconButton(
                                    //   icon: Icon(Icons.remove),
                                    //   onPressed: () {
                                    //     cart.updateQuantity(
                                    //         item.id, item.quantity - 1);
                                    //     if (item.quantity <= 0) {
                                    //       cart.removeItem(item.id);
                                    //     }
                                    //   },
                                    // ),
                                    Text(
                                        "Quantity: ${item.quantity.toString()}"),
                                    // IconButton(
                                    //   icon: Icon(Icons.add),
                                    //   onPressed: () {
                                    //     cart.updateQuantity(
                                    //         item.id, item.quantity + 1);
                                    //   },
                                    // ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    cart.removeItem(item.productId);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Cost:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${totalCost.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.pink[600],
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/checkout', arguments: totalCost);
                  },
                  child: Text('Checkout'),
                ),
                SizedBox(height: 20),
              ],
            ),
    );
  }
}
