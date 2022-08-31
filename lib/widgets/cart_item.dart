import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;

  const CartItem({
    Key? key,
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(title),
        subtitle: Text('Qty: $quantity'),
        trailing: Chip(
          label: Text('\$$price'),
        ),
      ),
    );
  }
}
