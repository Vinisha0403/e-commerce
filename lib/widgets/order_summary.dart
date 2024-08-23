import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  final double totalAmount;

  OrderSummary(this.totalAmount);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Chip(
              label: Text(
                '\$$totalAmount',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            ElevatedButton(
              child: Text('ORDER NOW'),
              onPressed: () {
                // Order Now Logic
              },
              //textColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
