import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token) async {
    final url = Uri.parse(
      'https://junes-departement-store-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$token',
    );
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final response = await http.patch(
        url,
        body: jsonEncode({
          'isFavorite': isFavorite,
        }),
      );

      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
        throw HttpException('Favorite Failed');
      }
    } catch (e) {
      isFavorite = oldStatus;
      notifyListeners();
      rethrow;
    }
  }
}
