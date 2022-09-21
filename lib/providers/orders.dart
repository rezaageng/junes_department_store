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
  final String? authToken;
  List<Order> _orders = [];

  Orders(this.authToken, this._orders);

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse(
      'https://junes-departement-store-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json?auth=$authToken',
    );

    try {
      final response = await http.get(url);
      final List<Order> loadedOrders = [];
      final orders = jsonDecode(response.body) as Map<String, dynamic>?;

      if (orders == null) return;

      orders.forEach((orderId, order) {
        loadedOrders.add(
          Order(
            id: orderId,
            amount: order['amount'],
            date: DateTime.parse(order['date']),
            products: (order['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'],
                  ),
                )
                .toList(),
          ),
        );
      });

      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addOrder(List<CartItem> cart, double amount) async {
    final url = Uri.parse(
      'https://junes-departement-store-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json?auth=$authToken',
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
