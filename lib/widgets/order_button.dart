import 'package:flutter/material.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
    required this.order,
  }) : super(key: key);

  final Cart cart;
  final Orders order;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await widget.order.addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              widget.cart.clear();
              setState(() {
                _isLoading = false;
              });
            },
      enableFeedback: false,
      splashRadius: 20,
      icon: _isLoading
          ? const Padding(
              padding: EdgeInsets.all(4),
              child: CircularProgressIndicator(),
            )
          : const Icon(Icons.shopping_cart_checkout_rounded),
    );
  }
}
