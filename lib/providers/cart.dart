import 'package:flutter/foundation.dart';

class CartItem {
  String productId;
  String title;
  int quantity;
  double price;

  CartItem({
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => CartItem(
          productId: value.productId,
          title: value.title,
          quantity: value.quantity + 1,
          price: value.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          productId: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
  }
}
