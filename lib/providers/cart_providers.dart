import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/cartitems.dart';

class CartProvider with ChangeNotifier {
  // Store cart items in a map with productId as the key
  Map<String, CartItem> _items = {};

  // Get all items as a list
  List<CartItem> get items {
    return _items.values.toList();
  }

  // Get the total number of items in the cart
  int get itemCount {
    return _items.length;
  }

  // Get the total cost of items in the cart
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // Add an item to the cart or update its quantity
  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      // If the item is already in the cart, increase the quantity
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      // Add the item if it doesn't exist in the cart
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          productId: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners(); // Notify listeners to update the UI
  }

  // Remove an item from the cart
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Update the quantity of an item in the cart
  void updateQuantity(String productId, int newQuantity) {
    if (_items.containsKey(productId)) {
      if (newQuantity <= 0) {
        // If quantity is 0 or less, remove the item
        removeItem(productId);
      } else {
        // Update the quantity of the item
        _items.update(
          productId,
          (existingItem) => CartItem(
            id: existingItem.id,
            productId: existingItem.productId,
            title: existingItem.title,
            price: existingItem.price,
            quantity: newQuantity,
          ),
        );
        notifyListeners();
      }
    }
  }

  // Add item to the cart and send data to the backend
  Future<void> addItemToCart(
      String productId, String title, double price) async {
    final cartItem = CartItem(
      id: DateTime.now().toString(),
      productId: productId,
      title: title,
      price: price,
      quantity: 1, // Default quantity when adding a new item
    );

    try {
      // Send POST request to the backend
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

      if (response.statusCode == 200) {
        // If the request is successful, update the local cart state
        addItem(productId, title, price);
        print('Product added to cart');
      } else {
        print('Failed to add product to cart');
        throw Exception('Failed to add product to cart');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to add item to cart. Please try again.');
    }
  }
}
