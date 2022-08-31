import 'package:flutter/foundation.dart';

class ChartItem {
  String productId;
  String title;
  int quantity;
  double price;

  ChartItem({
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Chart with ChangeNotifier {
  late Map<String, ChartItem> _items;

  Map<String, ChartItem> get items {
    return {..._items};
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => ChartItem(
          productId: value.productId,
          title: value.title,
          quantity: value.quantity + 1,
          price: value.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => ChartItem(
          productId: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
  }
}
