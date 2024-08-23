import 'package:flutter/material.dart';
import '../models/cartitems.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(cartItem.productId),
      ),
      title: Text(cartItem.title),
      subtitle: Text('Total: \$${(cartItem.price * cartItem.quantity)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              // Decrease quantity logic
            },
          ),
          Text('${cartItem.quantity}'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Increase quantity logic
            },
          ),
        ],
      ),
    );
  }
}
