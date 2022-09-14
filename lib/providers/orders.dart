import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';

class Order {
  final String id;
  final List<CartItem> products;
  final double amount;
  final DateTime date;

  Order({
    required this.id,
    required this.products,
    required this.amount,
    required this.date,
  });
}

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cart, double amount) async {
    final url = Uri.https(
      'junes-departement-store-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/orders.json',
    );
    final timestamp = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'amount': amount,
          'date': timestamp.toIso8601String(),
          'products': cart
              .map((item) => {
                    'id': item.id,
                    'title': item.title,
                    'quantity': item.quantity,
                    'price': item.price,
                  })
              .toList()
        }),
      );

      _orders.insert(
        0,
        Order(
          id: jsonDecode(response.body)['name'],
          products: cart,
          amount: amount,
          date: timestamp,
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
