import 'package:flutter/foundation.dart';

import 'cart.dart';

class Order {
  final String id;
  final List<CartItem> product;
  final double amount;
  final DateTime date;

  Order({
    required this.id,
    required this.product,
    required this.amount,
    required this.date,
  });
}

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cart, double amount) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        product: cart,
        amount: amount,
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
