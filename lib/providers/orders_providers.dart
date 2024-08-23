import 'dart:math';
import 'package:flutter/material.dart';
import '../models/orders.dart';
import '../models/cartitems.dart';

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    final newOrder = OrderItem(
      id: Random().nextInt(10000).toString(), // Generate a unique ID
      amount: total,
      products: cartProducts,
      dateTime: DateTime.now(), // Use current date and time
    );
    _orders.insert(0, newOrder); // Add new order to the beginning of the list
    notifyListeners(); // Notify listeners about the change
  }
}
