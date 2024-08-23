import 'package:ecommerce_app/providers/cart_providers.dart';
import 'package:ecommerce_app/providers/orders_providers.dart';
import 'package:ecommerce_app/providers/products_providers.dart';
import 'package:ecommerce_app/providers/users_providers.dart';
import 'package:ecommerce_app/screens/checkout_screen.dart';
import 'package:ecommerce_app/screens/product_overview_screen.dart';
import 'package:ecommerce_app/screens/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth_provider.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => UsersProvider()),
        ChangeNotifierProvider(create: (ctx) => OrdersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter E-Commerce App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginScreen(),
        routes: {
          '/home': (context) => ProductOverviewScreen(),
          '/signup': (ctx) => SignupScreen(),
          '/cart': (context) => ShoppingCartScreen(),
          '/checkout': (ctx) => CheckoutScreen(),
        },
      ),
    );
  }
}
