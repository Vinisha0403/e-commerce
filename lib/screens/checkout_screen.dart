import 'package:ecommerce_app/providers/orders_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_providers.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'card'; // Default payment method

  @override
  Widget build(BuildContext context) {
    final double totalCost =
        ModalRoute.of(context)!.settings.arguments as double;
    final cartProvider = Provider.of<CartProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

    void _placeOrder() {
      final cartItems = cartProvider.items;

      // Display confirmation dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Order Confirmation'),
          content: Text('Are you sure you want to place this order?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                // Add order to the Orders provider
                ordersProvider.addOrder(cartItems, totalCost);

                Navigator.of(ctx).pop(); // Close the dialog

                // Show a success message
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Order Placed'),
                    content: Text('Your order has been placed successfully.'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          // Clear the cart after order is placed
                          Provider.of<CartProvider>(context, listen: false)
                              .clearCart();

                          // Close the success dialog
                          Navigator.of(ctx).pop();

                          // Navigate to home or any other screen
                          Navigator.of(context).pushReplacementNamed('/home');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Total Cost: \$${totalCost.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.pink[600]),
            ),
            SizedBox(height: 20),
            // Payment Options Section
            Text(
              'Payment Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                RadioListTile<String>(
                  title: Text('Credit/Debit Card'),
                  value: 'card',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('PayPal'),
                  value: 'paypal',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Cash on Delivery'),
                  value: 'cod',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _placeOrder,
              child: Text('Place Order'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink[600],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
