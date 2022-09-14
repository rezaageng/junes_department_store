import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteProduct =>
      _items.where((item) => item.isFavorite).toList();

  Product findById(id) => _items.firstWhere((item) => item.id == id);

  Future<void> fetchProduct() async {
    final url = Uri.https(
      'junes-departement-store-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/products.json',
    );

    try {
      final response = await http.get(url);
      final products = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];

      products.forEach((id, product) {
        loadedProduct.add(Product(
          id: id,
          title: product['title'],
          description: product['description'],
          price: product['price'],
          image: product['image'],
          isFavorite: product['isFavorite'],
        ));
      });

      _items = loadedProduct;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(
      'junes-departement-store-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/products.json',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'image': product.image,
            'isFavorite': product.isFavorite,
          },
        ),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        price: product.price,
        description: product.description,
        image: product.image,
      );

      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final url = Uri.https(
      'junes-departement-store-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/products/$id.json',
    );
    final index = _items.indexWhere((prod) => prod.id == id);

    await http.patch(
      url,
      body: jsonEncode({
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'image': product.image
      }),
    );

    _items[index] = product;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https(
      'junes-departement-store-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/products/$id.json',
    );

    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Delete Failed');
    }

    existingProduct = null;
  }
}
